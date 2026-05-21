from rest_framework.decorators import api_view
from rest_framework.response import Response
from market.models import Stock
from market.views import _ensure_demo_stocks
from users.helpers import get_demo_user
from .models import WatchlistItem
from .serializers import WatchlistItemSerializer


@api_view(['GET'])
def watchlist_home(request):
    return Response({
        'module': 'watchlist',
        'status': 'ok',
        'message': 'Watchlist API is ready.',
    })


@api_view(['GET'])
def watchlist_items(request):
    _ensure_demo_stocks()
    user = get_demo_user()
    items = WatchlistItem.objects.filter(user=user).select_related('stock')

    if not items.exists():
        for symbol in ['RELIANCE', 'TCS', 'HDFCBANK']:
            stock = Stock.objects.filter(symbol=symbol).first()
            if stock is not None:
                WatchlistItem.objects.get_or_create(user=user, stock=stock)
        items = WatchlistItem.objects.filter(user=user).select_related('stock')

    return Response({
        'results': WatchlistItemSerializer(items, many=True).data,
    })


@api_view(['POST'])
def add_to_watchlist(request):
    _ensure_demo_stocks()
    user = get_demo_user()
    symbol = request.data.get('symbol', 'RELIANCE')
    stock = Stock.objects.filter(symbol=symbol.upper()).first()
    if stock is None:
        return Response({'message': f'Stock {symbol} not found.'}, status=404)
    item, created = WatchlistItem.objects.get_or_create(user=user, stock=stock)
    return Response({
        'message': f'{symbol.upper()} added to watchlist.',
        'created': created,
        'item': WatchlistItemSerializer(item).data,
    })


@api_view(['POST'])
def remove_from_watchlist(request):
    user = get_demo_user()
    symbol = request.data.get('symbol', 'RELIANCE')
    item = WatchlistItem.objects.filter(user=user, stock__symbol=symbol.upper()).first()
    if item is None:
        return Response({'message': f'{symbol.upper()} was not in watchlist.'}, status=404)
    item.delete()
    return Response({
        'message': f'{symbol.upper()} removed from watchlist.',
    })
