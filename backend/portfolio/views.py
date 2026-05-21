from decimal import Decimal
from rest_framework.decorators import api_view
from rest_framework.response import Response
from market.views import _ensure_demo_stocks
from users.helpers import get_demo_user
from users.models import UserProfile
from .models import Holding, Transaction
from .serializers import HoldingSerializer, TransactionSerializer
from market.models import Stock


@api_view(['GET'])
def portfolio_home(request):
    return Response({
        'module': 'portfolio',
        'status': 'ok',
        'message': 'Portfolio API is ready.',
    })


@api_view(['GET'])
def portfolio_summary(request):
    _ensure_demo_stocks()
    user = get_demo_user()
    profile = UserProfile.objects.get(user=user)
    holdings = Holding.objects.filter(user=user).select_related('stock')
    transactions = Transaction.objects.filter(user=user)

    if not holdings.exists() and not transactions.exists():
        reliance = Stock.objects.get(symbol='RELIANCE')
        tcs = Stock.objects.get(symbol='TCS')
        Holding.objects.get_or_create(
            user=user,
            stock=reliance,
            defaults={'quantity': 15, 'average_price': Decimal('2860.50')},
        )
        Holding.objects.get_or_create(
            user=user,
            stock=tcs,
            defaults={'quantity': 6, 'average_price': Decimal('3988.00')},
        )
        holdings = Holding.objects.filter(user=user).select_related('stock')

    portfolio_value = sum(
        Decimal(holding.quantity) * holding.stock.current_price for holding in holdings
    )
    invested_value = sum(
        Decimal(holding.quantity) * holding.average_price for holding in holdings
    )

    return Response({
        'cash_balance': profile.virtual_balance,
        'portfolio_value': portfolio_value,
        'profit_loss': portfolio_value - invested_value,
        'holdings': HoldingSerializer(holdings, many=True).data,
    })


@api_view(['POST'])
def buy_stock(request):
    _ensure_demo_stocks()
    user = get_demo_user()
    profile = UserProfile.objects.get(user=user)
    symbol = request.data.get('symbol', 'RELIANCE')
    quantity = int(request.data.get('quantity', 1))
    stock = Stock.objects.filter(symbol=symbol.upper()).first()

    if stock is None:
        return Response({'message': f'Stock {symbol} not found.'}, status=404)

    total_amount = Decimal(quantity) * stock.current_price
    if profile.virtual_balance < total_amount:
        return Response({'message': 'Insufficient virtual balance.'}, status=400)

    holding, _ = Holding.objects.get_or_create(
        user=user,
        stock=stock,
        defaults={'quantity': 0, 'average_price': stock.current_price},
    )

    previous_total = Decimal(holding.quantity) * holding.average_price
    new_total = previous_total + total_amount
    new_quantity = holding.quantity + quantity
    holding.quantity = new_quantity
    holding.average_price = new_total / Decimal(new_quantity)
    holding.save()

    profile.virtual_balance -= total_amount
    profile.save(update_fields=['virtual_balance', 'updated_at'])

    transaction = Transaction.objects.create(
        user=user,
        stock=stock,
        order_type=Transaction.OrderType.BUY,
        quantity=quantity,
        price=stock.current_price,
        total_amount=total_amount,
    )

    return Response({
        'message': 'Buy order accepted.',
        'order': TransactionSerializer(transaction).data,
    })


@api_view(['POST'])
def sell_stock(request):
    _ensure_demo_stocks()
    user = get_demo_user()
    profile = UserProfile.objects.get(user=user)
    symbol = request.data.get('symbol', 'RELIANCE')
    quantity = int(request.data.get('quantity', 1))
    stock = Stock.objects.filter(symbol=symbol.upper()).first()

    if stock is None:
        return Response({'message': f'Stock {symbol} not found.'}, status=404)

    holding = Holding.objects.filter(user=user, stock=stock).first()
    if holding is None or holding.quantity < quantity:
        return Response({'message': 'Not enough shares to sell.'}, status=400)

    total_amount = Decimal(quantity) * stock.current_price
    holding.quantity -= quantity
    if holding.quantity == 0:
        holding.delete()
    else:
        holding.save(update_fields=['quantity', 'updated_at'])

    profile.virtual_balance += total_amount
    profile.save(update_fields=['virtual_balance', 'updated_at'])

    transaction = Transaction.objects.create(
        user=user,
        stock=stock,
        order_type=Transaction.OrderType.SELL,
        quantity=quantity,
        price=stock.current_price,
        total_amount=total_amount,
    )

    return Response({
        'message': 'Sell order accepted.',
        'order': TransactionSerializer(transaction).data,
    })


@api_view(['GET'])
def transaction_history(request):
    user = get_demo_user()
    transactions = Transaction.objects.filter(user=user).select_related('stock')

    if not transactions.exists():
        return Response({
            'results': [
                {
                    'id': 'tx-1',
                    'symbol': 'RELIANCE',
                    'type': 'BUY',
                    'quantity': 15,
                    'price': 2860.50,
                    'timestamp': '2026-04-06T10:30:00Z',
                },
                {
                    'id': 'tx-2',
                    'symbol': 'TCS',
                    'type': 'BUY',
                    'quantity': 6,
                    'price': 3988.00,
                    'timestamp': '2026-04-08T14:15:00Z',
                },
            ],
        })

    return Response({
        'results': TransactionSerializer(transactions, many=True).data,
    })
