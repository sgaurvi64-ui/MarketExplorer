from __future__ import annotations

import json
from decimal import Decimal
from pathlib import Path

import pandas as pd
from django.conf import settings

try:
    import joblib
except ImportError:  # pragma: no cover - optional dependency for later
    joblib = None

try:
    import yfinance as yf
except ImportError:  # pragma: no cover - optional dependency for later
    yf = None


class InsightEngine:
    def __init__(self) -> None:
        self.mode = getattr(settings, "ML_MODE", "rule_based")
        self.repo_root = settings.BASE_DIR.parent
        self.model_path = Path(
            getattr(
                settings,
                "ML_MODEL_SHORT_PATH",
                self.repo_root / "ml" / "models" / "baseline_stock_model_short.joblib",
            )
        )
        self.model_meta_path = Path(
            getattr(
                settings,
                "ML_MODEL_SHORT_META_PATH",
                self.repo_root / "ml" / "models" / "baseline_stock_model_short_meta.json",
            )
        )
        self.model_long_path = Path(
            getattr(
                settings,
                "ML_MODEL_LONG_PATH",
                self.repo_root / "ml" / "models" / "baseline_stock_model_long.joblib",
            )
        )
        self.model_long_meta_path = Path(
            getattr(
                settings,
                "ML_MODEL_LONG_META_PATH",
                self.repo_root / "ml" / "models" / "baseline_stock_model_long_meta.json",
            )
        )
        self.universe_path = Path(
            getattr(
                settings,
                "ML_UNIVERSE_PATH",
                self.repo_root / "ml" / "datasets" / "stocks_universe.csv",
            )
        )
        self._cached_model = None
        self._cached_model_long = None
        self._cached_metadata: dict[str, object] | None = None
        self._cached_universe: pd.DataFrame | None = None

    def engine_status(self) -> dict[str, object]:
        return {
            "mode": self.mode,
            "model_available": self.model_path.exists(),
            "meta_available": self.model_meta_path.exists(),
            "universe_available": self.universe_path.exists(),
            "fallback_enabled": True,
        }

    def predict(self, symbol: str, horizon: str = "short") -> dict[str, object]:
        normalized_symbol = symbol.upper()

        if self.mode == "disabled":
            return self._disabled_prediction(normalized_symbol)

        if self.mode == "model":
            model_prediction = self._model_prediction(normalized_symbol, horizon=horizon)
            if model_prediction is not None:
                return model_prediction

        return self._rule_based_prediction(normalized_symbol)

    def recommend(self) -> list[dict[str, object]]:
        recommendations: list[dict[str, object]] = []
        for symbol in self._available_symbols()[:10]:
            payload = self.predict(symbol, horizon="short")
            confidence = float(payload["confidence"])
            risk_score = float(payload["risk_score"])
            score = max(1, min(99, round((confidence * 100) - (risk_score * 35))))
            recommendations.append(
                payload
                | {
                    "score": score,
                    "label": self._label_for_prediction(
                        payload["prediction"],
                        score,
                        risk_score,
                    ),
                }
            )

        recommendations.sort(key=lambda item: item["score"], reverse=True)
        return recommendations[:5]

    def _disabled_prediction(self, symbol: str) -> dict[str, object]:
        return {
            "symbol": symbol,
            "prediction": "HOLD",
            "confidence": Decimal("0.50"),
            "risk_score": Decimal("0.50"),
            "source": "disabled-fallback",
        }

    def _model_prediction(self, symbol: str, horizon: str = "short") -> dict[str, object] | None:
        model = self._load_model(horizon=horizon)
        features = self._features_for_symbol(symbol)
        if model is None or features is None:
            return None

        prediction = int(model.predict([features])[0])

        confidence = Decimal("0.70")
        if hasattr(model, "predict_proba"):
            probabilities = model.predict_proba([features])[0]
            confidence = Decimal(str(round(float(max(probabilities)), 2)))

        return {
            "symbol": symbol,
            "prediction": "UP" if prediction == 1 else "DOWN",
            "confidence": confidence,
            "risk_score": self._risk_score(symbol),
            "source": "baseline-model-long" if horizon == "long" else "baseline-model-short",
        }

    def _rule_based_prediction(self, symbol: str) -> dict[str, object]:
        features = self._features_for_symbol(symbol)
        if features is None:
            return {
                "symbol": symbol,
                "prediction": "HOLD",
                "confidence": Decimal("0.55"),
                "risk_score": Decimal("0.40"),
                "source": "rule-based-engine",
            }

        return_1d, return_5d, return_10d, volatility_10d, volume_change_5d, sma_gap = features
        momentum = (return_5d * 0.45) + (return_10d * 0.35) + (sma_gap * 0.20)
        liquidity_push = volume_change_5d * 0.05
        directional_signal = momentum + liquidity_push + (return_1d * 0.10)

        if directional_signal > 0.015:
            prediction = "UP"
        elif directional_signal < -0.015:
            prediction = "DOWN"
        else:
            prediction = "HOLD"

        confidence_value = min(0.90, max(0.51, 0.55 + abs(directional_signal * 5)))
        risk_value = min(0.95, max(0.15, 0.28 + abs(volatility_10d * 4)))

        return {
            "symbol": symbol,
            "prediction": prediction,
            "confidence": Decimal(str(round(confidence_value, 2))),
            "risk_score": Decimal(str(round(risk_value, 2))),
            "source": "rule-based-engine",
        }

    def _features_for_symbol(self, symbol: str) -> list[float] | None:
        history = self._download_history(symbol)
        if history is None or history.empty or len(history) < 25:
            return None

        frame = self._normalize_history(history)
        if frame.empty:
            return None

        frame["return_1d"] = frame["Close"].pct_change()
        frame["return_5d"] = frame["Close"].pct_change(5)
        frame["return_10d"] = frame["Close"].pct_change(10)
        frame["volatility_10d"] = frame["return_1d"].rolling(10).std()
        frame["volume_change_5d"] = frame["Volume"].pct_change(5)
        frame["sma_10"] = frame["Close"].rolling(10).mean()
        frame["sma_20"] = frame["Close"].rolling(20).mean()
        frame["sma_50"] = frame["Close"].rolling(50).mean()
        frame["sma_gap_10_20"] = (frame["sma_10"] - frame["sma_20"]) / frame["sma_20"]
        frame["sma_gap_20_50"] = (frame["sma_20"] - frame["sma_50"]) / frame["sma_50"]

        delta = frame["Close"].diff()
        gain = delta.clip(lower=0)
        loss = -delta.clip(upper=0)
        avg_gain = gain.rolling(14).mean()
        avg_loss = loss.rolling(14).mean()
        rs = avg_gain / avg_loss
        frame["rsi_14"] = 100 - (100 / (1 + rs))

        ema_12 = frame["Close"].ewm(span=12, adjust=False).mean()
        ema_26 = frame["Close"].ewm(span=26, adjust=False).mean()
        frame["macd"] = ema_12 - ema_26
        frame["macd_signal"] = frame["macd"].ewm(span=9, adjust=False).mean()
        frame["macd_hist"] = frame["macd"] - frame["macd_signal"]

        prev_close = frame["Close"].shift(1)
        high_low = frame["High"] - frame["Low"]
        high_close = (frame["High"] - prev_close).abs()
        low_close = (frame["Low"] - prev_close).abs()
        true_range = pd.concat([high_low, high_close, low_close], axis=1).max(axis=1)
        frame["atr_14"] = true_range.rolling(14).mean()

        volume_mean = frame["Volume"].rolling(20).mean()
        volume_std = frame["Volume"].rolling(20).std()
        frame["volume_zscore_20"] = (frame["Volume"] - volume_mean) / volume_std

        latest = frame.dropna().tail(1)
        if latest.empty:
            return None

        row = latest.iloc[0]
        return [
            float(row["return_1d"]),
            float(row["return_5d"]),
            float(row["return_10d"]),
            float(row["volatility_10d"]),
            float(row["volume_change_5d"]),
            float(row["sma_gap_10_20"]),
            float(row["sma_gap_20_50"]),
            float(row["rsi_14"]),
            float(row["macd"]),
            float(row["macd_signal"]),
            float(row["macd_hist"]),
            float(row["atr_14"]),
            float(row["volume_zscore_20"]),
        ]

    def _risk_score(self, symbol: str) -> Decimal:
        features = self._features_for_symbol(symbol)
        if features is None:
            return Decimal("0.40")
        volatility_10d = abs(features[3])
        return Decimal(str(round(min(0.95, max(0.15, 0.28 + volatility_10d * 4)), 2)))

    def model_metadata(self, horizon: str = "short") -> dict[str, object] | None:
        if horizon == "long":
            if self._cached_metadata is not None and "model_name" in self._cached_metadata:
                return self._cached_metadata
            if not self.model_long_meta_path.exists():
                return None
            return json.loads(self.model_long_meta_path.read_text(encoding="utf-8"))

        if self._cached_metadata is not None:
            return self._cached_metadata
        if not self.model_meta_path.exists():
            return None
        self._cached_metadata = json.loads(
            self.model_meta_path.read_text(encoding="utf-8")
        )
        return self._cached_metadata

    def _load_model(self, horizon: str = "short"):
        if horizon == "long":
            if self._cached_model_long is not None:
                return self._cached_model_long
            if joblib is None or not self.model_long_path.exists():
                return None
            self._cached_model_long = joblib.load(self.model_long_path)
            return self._cached_model_long

        if self._cached_model is not None:
            return self._cached_model
        if joblib is None or not self.model_path.exists():
            return None
        self._cached_model = joblib.load(self.model_path)
        return self._cached_model

    def _load_universe(self) -> pd.DataFrame:
        if self._cached_universe is not None:
            return self._cached_universe
        if self.universe_path.exists():
            self._cached_universe = pd.read_csv(self.universe_path)
        else:
            self._cached_universe = pd.DataFrame(
                [
                    {"symbol": "RELIANCE", "exchange": "NS"},
                    {"symbol": "TCS", "exchange": "NS"},
                    {"symbol": "INFY", "exchange": "NS"},
                    {"symbol": "HDFCBANK", "exchange": "NS"},
                    {"symbol": "SBIN", "exchange": "NS"},
                ]
            )
        return self._cached_universe

    def _available_symbols(self) -> list[str]:
        universe = self._load_universe()
        if "symbol" not in universe.columns:
            return []
        return universe["symbol"].dropna().astype(str).str.upper().tolist()

    def _lookup_exchange(self, symbol: str) -> str:
        universe = self._load_universe()
        if "symbol" not in universe.columns:
            return "NS"
        match = universe.loc[
            universe["symbol"].astype(str).str.upper() == symbol.upper()
        ]
        if not match.empty and "exchange" in match.columns:
            return str(match.iloc[0]["exchange"]).upper()
        return "NS"

    def _ticker_for_symbol(self, symbol: str) -> str:
        exchange = self._lookup_exchange(symbol)
        if exchange == "NS":
            return f"{symbol.upper()}.NS"
        if exchange == "BO":
            return f"{symbol.upper()}.BO"
        return symbol.upper()

    def _download_history(self, symbol: str) -> pd.DataFrame | None:
        if yf is None:
            return None

        ticker = self._ticker_for_symbol(symbol)
        history = yf.download(
            ticker,
            period="6mo",
            interval="1d",
            auto_adjust=True,
            progress=False,
        )
        if history.empty:
            return None
        return history

    def _normalize_history(self, history: pd.DataFrame) -> pd.DataFrame:
        frame = history.copy()

        if isinstance(frame.columns, pd.MultiIndex):
            frame.columns = [
                column[0] if isinstance(column, tuple) else column
                for column in frame.columns
            ]

        frame = frame.reset_index()
        frame.columns = [str(column).strip() for column in frame.columns]
        frame = frame.rename(columns={"Adj Close": "Close", "Datetime": "Date"})

        numeric_columns = ["Open", "High", "Low", "Close", "Volume"]
        for column in numeric_columns:
            if column in frame.columns:
                frame[column] = pd.to_numeric(frame[column], errors="coerce")

        required_columns = ["Close", "Volume"]
        existing_required = [column for column in required_columns if column in frame.columns]
        if not existing_required:
            return pd.DataFrame()

        return frame.dropna(subset=existing_required)

    def _label_for_prediction(
        self,
        prediction: str,
        score: int,
        risk_score: float,
    ) -> str:
        if prediction == "UP" and score >= 80:
            return "Strong Momentum"
        if prediction == "UP":
            return "Moderate Buy"
        if prediction == "DOWN" and risk_score >= 0.5:
            return "High Risk"
        if prediction == "DOWN":
            return "Weak Trend"
        return "Watch Closely"
