from __future__ import annotations

from pathlib import Path

import pandas as pd
import numpy as np


ROOT = Path(__file__).resolve().parent.parent
INPUT_PATH = ROOT / "datasets" / "historical_prices.csv"
OUTPUT_PATH = ROOT / "datasets" / "training_features.csv"


def _compute_group_features(group: pd.DataFrame) -> pd.DataFrame:
    group = group.sort_values("Date").copy()
    numeric_columns = ["Open", "High", "Low", "Close", "Volume"]
    for column in numeric_columns:
        if column in group.columns:
            group[column] = pd.to_numeric(group[column], errors="coerce")

    group["return_1d"] = group["Close"].pct_change()
    group["return_5d"] = group["Close"].pct_change(5)
    group["return_10d"] = group["Close"].pct_change(10)
    group["volatility_10d"] = group["return_1d"].rolling(10).std()
    group["volume_change_5d"] = group["Volume"].pct_change(5)
    group["sma_10"] = group["Close"].rolling(10).mean()
    group["sma_20"] = group["Close"].rolling(20).mean()
    group["sma_50"] = group["Close"].rolling(50).mean()
    group["sma_gap_10_20"] = (group["sma_10"] - group["sma_20"]) / group["sma_20"]
    group["sma_gap_20_50"] = (group["sma_20"] - group["sma_50"]) / group["sma_50"]

    delta = group["Close"].diff()
    gain = delta.clip(lower=0)
    loss = -delta.clip(upper=0)
    avg_gain = gain.rolling(14).mean()
    avg_loss = loss.rolling(14).mean()
    rs = avg_gain / avg_loss
    group["rsi_14"] = 100 - (100 / (1 + rs))

    ema_12 = group["Close"].ewm(span=12, adjust=False).mean()
    ema_26 = group["Close"].ewm(span=26, adjust=False).mean()
    group["macd"] = ema_12 - ema_26
    group["macd_signal"] = group["macd"].ewm(span=9, adjust=False).mean()
    group["macd_hist"] = group["macd"] - group["macd_signal"]

    prev_close = group["Close"].shift(1)
    high_low = group["High"] - group["Low"]
    high_close = (group["High"] - prev_close).abs()
    low_close = (group["Low"] - prev_close).abs()
    true_range = pd.concat([high_low, high_close, low_close], axis=1).max(axis=1)
    group["atr_14"] = true_range.rolling(14).mean()

    volume_mean = group["Volume"].rolling(20).mean()
    volume_std = group["Volume"].rolling(20).std()
    group["volume_zscore_20"] = (group["Volume"] - volume_mean) / volume_std

    group["future_close_10d"] = group["Close"].shift(-10)
    group["future_close_30d"] = group["Close"].shift(-30)
    group["target_up_short"] = (group["future_close_10d"] > group["Close"] * 1.02).astype(int)
    group["target_up_long"] = (group["future_close_30d"] > group["Close"] * 1.05).astype(int)
    return group


def main() -> None:
    frame = pd.read_csv(INPUT_PATH)
    frame.columns = [str(column).strip() for column in frame.columns]
    frame["Date"] = pd.to_datetime(frame["Date"], errors="coerce")
    frame = frame.sort_values(["symbol", "Date"]).copy()
    frame = frame.dropna(subset=["Date", "Close", "Volume"])
    groups: list[pd.DataFrame] = []
    for symbol, group in frame.groupby("symbol", sort=False):
        computed = _compute_group_features(group)
        computed["symbol"] = symbol
        groups.append(computed)

    frame = pd.concat(groups, ignore_index=True)

    features = frame[
        [
            "Date",
            "symbol",
            "exchange",
            "sector",
            "return_1d",
            "return_5d",
            "return_10d",
            "volatility_10d",
            "volume_change_5d",
            "sma_gap_10_20",
            "sma_gap_20_50",
            "rsi_14",
            "macd",
            "macd_signal",
            "macd_hist",
            "atr_14",
            "volume_zscore_20",
            "target_up_short",
            "target_up_long",
        ]
    ].replace([np.inf, -np.inf], np.nan).dropna()

    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    features.to_csv(OUTPUT_PATH, index=False)
    print(f"Saved features to {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
