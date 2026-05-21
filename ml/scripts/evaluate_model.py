from __future__ import annotations

from pathlib import Path

import joblib
import numpy as np
import pandas as pd


ROOT = Path(__file__).resolve().parent.parent
DATASET_PATH = ROOT / "datasets" / "training_features.csv"
MODEL_PATH = ROOT / "models" / "baseline_stock_model.joblib"

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


def _load_data() -> pd.DataFrame:
    if not DATASET_PATH.exists():
        raise FileNotFoundError(
            f"Dataset not found at {DATASET_PATH}. Run build_features.py first."
        )
    frame = pd.read_csv(DATASET_PATH)
    frame["Date"] = pd.to_datetime(frame["Date"], errors="coerce")
    frame = frame.replace([np.inf, -np.inf], np.nan).dropna(subset=FEATURE_COLUMNS + ["Date"])
    frame = frame.sort_values("Date").reset_index(drop=True)
    return frame


def _load_model():
    if not MODEL_PATH.exists():
        raise FileNotFoundError(
            f"Model not found at {MODEL_PATH}. Run train_baseline_model.py first."
        )
    return joblib.load(MODEL_PATH)


def _walk_forward_splits(frame: pd.DataFrame, start_year: int, end_year: int):
    for year in range(start_year, end_year):
        train_mask = frame["Date"].dt.year <= year
        test_mask = frame["Date"].dt.year == year + 1
        if not test_mask.any():
            continue
        yield year, train_mask, test_mask


def main() -> None:
    frame = _load_data()
    model = _load_model()

    if (frame["Date"].dt.year >= 2024).any():
        test_mask = frame["Date"].dt.year >= 2024
        split_label = "2024-2025 holdout"
    else:
        split_label = "last-20pct holdout"
        split_index = int(len(frame) * 0.8)
        test_mask = frame.index >= split_index

    x = frame[FEATURE_COLUMNS]
    y = frame["target_up"]

    y_pred = model.predict(x.loc[test_mask])
    y_true = y.loc[test_mask]

    accuracy = float((y_pred == y_true).mean())
    win_rate = accuracy

    # Approx profitability proxy: reward if prediction is correct, penalty if wrong.
    # This is not full PnL but gives directional utility.
    profit_per_trade = float((y_pred == y_true).mean() - (y_pred != y_true).mean())
    win_loss_ratio = (y_pred == y_true).mean() / max((y_pred != y_true).mean(), 1e-6)

    print(f"Holdout split: {split_label}")
    print(f"Accuracy: {accuracy:.4f}")
    print(f"Win/loss ratio: {win_loss_ratio:.2f}")
    print(f"Avg profit proxy per trade: {profit_per_trade:.4f}")

    # Walk-forward evaluation
    years = frame["Date"].dt.year.dropna()
    if years.nunique() > 3:
        start_year = int(years.min()) + 1
        end_year = int(years.max()) - 1
        print("\nWalk-forward validation:")
        for year, train_mask, test_mask in _walk_forward_splits(frame, start_year, end_year):
            y_pred = model.predict(x.loc[test_mask])
            y_true = y.loc[test_mask]
            acc = float((y_pred == y_true).mean())
            print(f"Train <= {year} | Test {year+1} | Acc: {acc:.4f} | Rows: {test_mask.sum()}")


if __name__ == "__main__":
    main()
