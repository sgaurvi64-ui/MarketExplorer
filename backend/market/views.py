from datetime import timedelta
from pathlib import Path
import csv
import math
from django.utils import timezone
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Stock, StockCandle
from .serializers import StockCandleSerializer, StockSerializer


MOCK_STOCKS = [
    {
        'symbol': 'RELIANCE',
        'company_name': 'Reliance Industries Ltd.',
        'price': 2946.20,
        'change': 28.10,
        'change_percent': 0.96,
        'sector': 'Conglomerate',
    },
    {
        'symbol': 'TCS',
        'company_name': 'Tata Consultancy Services',
        'price': 4128.75,
        'change': 46.35,
        'change_percent': 1.14,
        'sector': 'Information Technology',
    },
    {
        'symbol': 'INFY',
        'company_name': 'Infosys Ltd.',
        'price': 1518.30,
        'change': -12.40,
        'change_percent': -0.81,
        'sector': 'Information Technology',
    },
    {
        'symbol': 'HDFCBANK',
        'company_name': 'HDFC Bank Ltd.',
        'price': 1682.55,
        'change': 9.85,
        'change_percent': 0.59,
        'sector': 'Banking',
    },
]


def _universe_csv_path():
    return Path(__file__).resolve().parents[2] / "ml" / "datasets" / "stocks_universe.csv"


def _load_universe_rows():
    csv_path = _universe_csv_path()
    if not csv_path.exists():
        return MOCK_STOCKS

    rows = []
    with csv_path.open("r", encoding="utf-8") as file:
        reader = csv.DictReader(file)
        for row in reader:
            rows.append({
                "symbol": (row.get("symbol") or "").strip().upper(),
                "company_name": (row.get("name") or "").strip(),
                "sector": (row.get("sector") or "").strip() or "Unknown",
            })
    return [row for row in rows if row["symbol"]]


def _price_seed(symbol: str) -> float:
    seed = sum(ord(char) for char in symbol)
    base = 150 + (seed % 4800)
    return float(base)


def _price_change(symbol: str) -> float:
    seed = sum(ord(char) for char in symbol)
    return round(((seed % 200) - 100) / 10, 2)


def _series_points(base: float, symbol: str) -> list[float]:
    seed = sum(ord(char) for char in symbol)
    points = []
    for index in range(7):
        swing = math.sin((seed + index) / 3.0) * 6
        points.append(round(base + swing + index * 0.8, 2))
    return points


def _ensure_demo_stocks():
    rows = _load_universe_rows()
    if not rows:
        rows = MOCK_STOCKS

    for item in rows:
        symbol = item["symbol"]
        if Stock.objects.filter(symbol=symbol).exists():
            continue

        price = _price_seed(symbol)
        change = _price_change(symbol)
        change_percent = round((change / price) * 100, 2) if price else 0
        stock = Stock.objects.create(
            symbol=symbol,
            company_name=item["company_name"] or f"{symbol} Ltd.",
            sector=item["sector"],
            description="Seeded Indian market demo stock for the simulator build.",
            current_price=price,
            price_change=change,
            change_percent=change_percent,
            day_high=price + abs(change) + 5,
            day_low=price - abs(change) - 5,
            volume=1000000 + (sum(ord(c) for c in symbol) % 500000),
        )

        for index, value in enumerate(_series_points(price, symbol)):
            StockCandle.objects.create(
                stock=stock,
                interval="1D",
                open_price=value - 1,
                high_price=value + 1,
                low_price=value - 2,
                close_price=value,
                volume=1000000 + index * 15000,
                recorded_at=timezone.now() - timedelta(days=6 - index),
            )


@api_view(['GET'])
def market_home(request):
    return Response({
        'module': 'market',
        'status': 'ok',
        'message': 'Market API is ready.',
    })


@api_view(['GET'])
def market_overview(request):
    return Response({
        'market_status': 'Open',
        'indices': [
            {
                'symbol': 'NIFTY 50',
                'price': 22435.75,
                'change': 182.10,
                'change_percent': 0.82,
            },
            {
                'symbol': 'SENSEX',
                'price': 73890.14,
                'change': 516.32,
                'change_percent': 0.70,
            },
            {
                'symbol': 'BANK NIFTY',
                'price': 48240.30,
                'change': -126.55,
                'change_percent': -0.26,
            },
        ],
    })


@api_view(['GET'])
def stock_list(request):
    _ensure_demo_stocks()
    serializer = StockSerializer(Stock.objects.filter(is_active=True), many=True)
    return Response({
        'count': len(serializer.data),
        'results': serializer.data,
    })


@api_view(['GET'])
def stock_details(request, symbol):
    _ensure_demo_stocks()
    stock = Stock.objects.filter(symbol=symbol.upper()).first()

    if stock is None:
        return Response({
            'message': f'Stock {symbol} not found.',
        }, status=404)

    return Response(StockSerializer(stock).data)


@api_view(['GET'])
def stock_chart(request, symbol):
    _ensure_demo_stocks()
    stock = Stock.objects.filter(symbol=symbol.upper()).first()
    if stock is None:
        return Response({
            'message': f'Stock {symbol} not found.',
        }, status=404)

    candles = StockCandle.objects.filter(stock=stock, interval='1D')
    return Response({
        'symbol': stock.symbol,
        'points': [float(candle.close_price) for candle in candles],
        'interval': '1D',
        'candles': StockCandleSerializer(candles, many=True).data,
    })
