from __future__ import annotations

import csv
import random
from pathlib import Path


OUTPUT_PATH = Path(__file__).resolve().parent.parent / "datasets" / "indian_stocks_sample.csv"
SYMBOLS = [
    "RELIANCE",
    "TCS",
    "INFY",
    "HDFCBANK",
    "ICICIBANK",
    "SBIN",
    "LT",
    "ITC",
    "AXISBANK",
    "BHARTIARTL",
]


def make_row(symbol: str) -> dict[str, float | int | str]:
    price_change = round(random.uniform(-4.5, 4.5), 2)
    volume_change = round(random.uniform(-20, 25), 2)
    volatility = round(random.uniform(0.5, 3.5), 2)
    rsi = round(random.uniform(25, 78), 2)
    moving_average_gap = round(random.uniform(-3.2, 3.2), 2)
    target = 1 if (price_change > 0 and rsi < 70) or moving_average_gap > 1 else 0

    return {
        "symbol": symbol,
        "price_change_pct": price_change,
        "volume_change_pct": volume_change,
        "volatility_score": volatility,
        "rsi": rsi,
        "moving_average_gap": moving_average_gap,
        "target_up": target,
    }


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    rows: list[dict[str, float | int | str]] = []

    for _ in range(120):
        for symbol in SYMBOLS:
            rows.append(make_row(symbol))

    with OUTPUT_PATH.open("w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(file, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)

    print(f"Sample dataset written to: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
