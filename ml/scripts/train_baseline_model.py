from __future__ import annotations

import json
from pathlib import Path

import joblib
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from sklearn.metrics import precision_score
from sklearn.metrics import recall_score
from sklearn.metrics import f1_score
from sklearn.model_selection import train_test_split


ROOT = Path(__file__).resolve().parent.parent
DATASET_PATH = ROOT / "datasets" / "training_features.csv"
MODEL_PATH_SHORT = ROOT / "models" / "baseline_stock_model_short.joblib"
META_PATH_SHORT = ROOT / "models" / "baseline_stock_model_short_meta.json"
MODEL_PATH_LONG = ROOT / "models" / "baseline_stock_model_long.joblib"
META_PATH_LONG = ROOT / "models" / "baseline_stock_model_long_meta.json"

FEATURE_COLUMNS = [
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
]


def main() -> None:
    if not DATASET_PATH.exists():
        raise FileNotFoundError(
            f"Dataset not found at {DATASET_PATH}. Run fetch_market_data.py and build_features.py first."
        )

    frame = pd.read_csv(DATASET_PATH)
    frame["Date"] = pd.to_datetime(frame["Date"], errors="coerce")
    frame = frame.replace([np.inf, -np.inf], np.nan).dropna(subset=FEATURE_COLUMNS + ["Date"])
    frame = frame.sort_values("Date").reset_index(drop=True)
    x = frame[FEATURE_COLUMNS]

    if (frame["Date"].dt.year >= 2024).any():
        train_mask = frame["Date"].dt.year <= 2023
        test_mask = frame["Date"].dt.year >= 2024
        x_train = x.loc[train_mask]
        x_test = x.loc[test_mask]
        split_label = "2020-2023 vs 2024-2025"
    else:
        split_index = int(len(frame) * 0.8)
        x_train = x.iloc[:split_index]
        x_test = x.iloc[split_index:]
        split_label = "80/20 time split"

    targets = {
        "short": "target_up_short",
        "long": "target_up_long",
    }

    for horizon, target_column in targets.items():
        y_train = frame.loc[x_train.index, target_column]
        y_test = frame.loc[x_test.index, target_column]

        model = RandomForestClassifier(
            n_estimators=140,
            max_depth=7,
            random_state=42,
        )
        model.fit(x_train, y_train)

        predictions = model.predict(x_test)
        accuracy = accuracy_score(y_test, predictions)
        precision = precision_score(y_test, predictions, zero_division=0)
        recall = recall_score(y_test, predictions, zero_division=0)
        f1 = f1_score(y_test, predictions, zero_division=0)

        if horizon == "short":
            model_path = MODEL_PATH_SHORT
            meta_path = META_PATH_SHORT
            target_label = "target_up_10d_2pct"
        else:
            model_path = MODEL_PATH_LONG
            meta_path = META_PATH_LONG
            target_label = "target_up_30d_5pct"

        model_path.parent.mkdir(parents=True, exist_ok=True)
        joblib.dump(model, model_path)

        metadata = {
            "model_name": f"baseline_stock_model_{horizon}",
            "features": FEATURE_COLUMNS,
            "target": target_label,
            "accuracy": round(float(accuracy), 4),
            "precision": round(float(precision), 4),
            "recall": round(float(recall), 4),
            "f1": round(float(f1), 4),
            "dataset": str(DATASET_PATH.name),
            "split_strategy": split_label,
            "rows_train": int(len(x_train)),
            "rows_test": int(len(x_test)),
        }

        meta_path.write_text(json.dumps(metadata, indent=2), encoding="utf-8")

        print(f"[{horizon}] Model saved to: {model_path}")
        print(f"[{horizon}] Metadata saved to: {meta_path}")
        print(f"[{horizon}] Validation accuracy: {accuracy:.4f}")


if __name__ == "__main__":
    main()
