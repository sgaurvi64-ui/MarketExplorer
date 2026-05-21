from __future__ import annotations

from pathlib import Path

import pandas as pd
import yfinance as yf


ROOT = Path(__file__).resolve().parent.parent
UNIVERSE_PATH = ROOT / "datasets" / "stocks_universe.csv"
OUTPUT_PATH = ROOT / "datasets" / "historical_prices.csv"
WIKI_URL = "https://en.wikipedia.org/wiki/NIFTY_500"


def yahoo_symbol(symbol: str, exchange: str) -> str:
    exchange_upper = exchange.upper()
    if exchange_upper == "NS":
        return f"{symbol}.NS"
    if exchange_upper == "BO":
        return f"{symbol}.BO"
    return symbol


def normalize_download_frame(data: pd.DataFrame) -> pd.DataFrame:
    frame = data.copy()

    if isinstance(frame.columns, pd.MultiIndex):
        frame.columns = [column[0] if isinstance(column, tuple) else column for column in frame.columns]

    frame = frame.reset_index()
    frame.columns = [str(column).strip() for column in frame.columns]

    rename_map = {
        "Adj Close": "Close",
        "Datetime": "Date",
    }
    frame = frame.rename(columns=rename_map)

    expected_columns = ["Open", "High", "Low", "Close", "Volume"]
    for column in expected_columns:
        if column in frame.columns:
            frame[column] = pd.to_numeric(frame[column], errors="coerce")

    return frame


def _load_or_build_universe() -> pd.DataFrame:
    if UNIVERSE_PATH.exists():
        universe = pd.read_csv(UNIVERSE_PATH)
    else:
        universe = pd.DataFrame(columns=["symbol", "exchange", "name", "sector"])

    # Try to auto-expand only if we have a small list.
    if len(universe) < 200:
        try:
            tables = pd.read_html(WIKI_URL)
            candidates = [table for table in tables if "Symbol" in table.columns]
            if candidates:
                table = candidates[0]
                expanded = pd.DataFrame(
                    {
                        "symbol": table["Symbol"].astype(str).str.strip(),
                        "exchange": "NS",
                        "name": table.get("Company", "").astype(str).str.strip()
                        if "Company" in table.columns
                        else table.get("Company name", "").astype(str).str.strip()
                        if "Company name" in table.columns
                        else "",
                        "sector": table.get("Sector", "").astype(str).str.strip()
                        if "Sector" in table.columns
                        else "Unknown",
                    }
                )
                expanded = expanded[expanded["symbol"].str.len() > 0]
                if not expanded.empty:
                    universe = expanded
                    UNIVERSE_PATH.parent.mkdir(parents=True, exist_ok=True)
                    universe.to_csv(UNIVERSE_PATH, index=False)
        except Exception as exc:
            print(f"Universe auto-expand skipped (Wikipedia blocked): {exc}")

    if universe.empty:
        raise RuntimeError(
            "Universe list is empty. Add symbols to stocks_universe.csv and retry."
        )

    return universe


def main() -> None:
    universe = _load_or_build_universe()
    frames: list[pd.DataFrame] = []

    for row in universe.itertuples(index=False):
        ticker = yahoo_symbol(row.symbol, row.exchange)
        data = yf.download(
            ticker,
            period="6y",
            interval="1d",
            auto_adjust=True,
            progress=False,
        )

        if data.empty:
            print(f"Skipped {ticker}: no data")
            continue

        frame = normalize_download_frame(data)
        frame["symbol"] = row.symbol
        frame["exchange"] = row.exchange
        frame["company_name"] = getattr(row, "name")
        frame["sector"] = row.sector
        frames.append(frame)

        print(f"Fetched {ticker}: {len(frame)} rows")

    if not frames:
        raise RuntimeError("No market data fetched.")

    combined = pd.concat(frames, ignore_index=True)
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    combined.to_csv(OUTPUT_PATH, index=False)
    print(f"Saved combined dataset to {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
