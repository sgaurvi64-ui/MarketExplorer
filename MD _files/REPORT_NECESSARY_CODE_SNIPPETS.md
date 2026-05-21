# Necessary Code Snippets for Report

This file contains only the core code sections worth pasting into the project report.  
Each snippet is labeled with the source file it comes from.

---

## `Flutter/lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'core/services/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: StockSimulatorApp()));
  FirebaseService.initialize();
}
```

---

## `Flutter/lib/app/router/app_router.dart`

```dart
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppScaffoldShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: RouteNames.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/market',
                name: RouteNames.market,
                builder: (context, state) => const MarketPage(),
                routes: [
                  GoRoute(
                    path: ':symbol',
                    name: RouteNames.stockDetails,
                    builder: (context, state) {
                      return StockDetailsPage(
                        symbol: state.pathParameters['symbol']!,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/portfolio',
                name: RouteNames.portfolio,
                builder: (context, state) => const PortfolioPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/watchlist',
                name: RouteNames.watchlist,
                builder: (context, state) => const WatchlistPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
```

---

## `Flutter/lib/features/market/presentation/pages/market_page.dart`

```dart
class MarketPage extends ConsumerStatefulWidget {
  const MarketPage({super.key});

  @override
  ConsumerState<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends ConsumerState<MarketPage> {
  String _query = '';
  String _selectedSector = 'All';
  String _selectedTab = 'All';

  @override
  Widget build(BuildContext context) {
    final stocksAsync = ref.watch(marketStocksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Market')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              onChanged: (value) => setState(() => _query = value.trim()),
              decoration: const InputDecoration(
                hintText: 'Search stocks or companies',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: stocksAsync.when(
              data: (stocks) {
                final filtered = stocks.where((stock) {
                  final query = _query.toLowerCase();
                  final matchesQuery =
                      stock.symbol.toLowerCase().contains(query) ||
                      stock.companyName.toLowerCase().contains(query);
                  final matchesSector =
                      _selectedSector == 'All' || stock.sector == _selectedSector;
                  return matchesQuery && matchesSector;
                }).toList();

                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    ...filtered.map((stock) {
                      return StockListTile(
                        stock: stock,
                        onTap: () => context.push('/market/${stock.symbol}'),
                      );
                    }),
                  ],
                );
              },
              loading: () => const AppLoader(message: 'Loading market'),
              error: (error, _) => AppErrorView(message: error.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## `Flutter/lib/features/portfolio/presentation/pages/portfolio_page.dart`

```dart
class PortfolioPage extends ConsumerWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final holdingsAsync = ref.watch(holdingsProvider);
    final transactionsAsync = ref.watch(transactionsProvider);
    final summaryAsync = ref.watch(portfolioSummaryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Portfolio')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          summaryAsync.when(
            data: (summary) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Current holdings'),
                      Text(CurrencyFormatter.format(summary.portfolioValue)),
                      Text(
                        'Cash available ${CurrencyFormatter.format(summary.cashBalance)}'
                        ' - P/L ${summary.profitLoss >= 0 ? '+' : ''}'
                        '${CurrencyFormatter.format(summary.profitLoss)}',
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => const AppLoader(message: 'Loading holdings'),
            error: (error, _) => AppErrorView(message: error.toString()),
          ),
          holdingsAsync.when(
            data: (holdings) => Column(
              children: holdings.map((holding) {
                return HoldingCard(holding: holding);
              }).toList(),
            ),
            loading: () => const AppLoader(message: 'Loading positions'),
            error: (error, _) => AppErrorView(message: error.toString()),
          ),
          transactionsAsync.when(
            data: (transactions) => Column(
              children: transactions.take(3).map((tx) {
                return TransactionTile(transaction: tx);
              }).toList(),
            ),
            loading: () => const AppLoader(message: 'Loading transactions'),
            error: (error, _) => AppErrorView(message: error.toString()),
          ),
        ],
      ),
    );
  }
}
```

---

## `Flutter/lib/data/datasources/remote/market_remote_data_source.dart`

```dart
class MarketRemoteDataSource {
  MarketRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<StockModel>> fetchStocks() async {
    try {
      final response = await _dio
          .get('${ApiConstants.market}/stocks/')
          .timeout(const Duration(seconds: 3));
      final results = List<Map<String, dynamic>>.from(
        response.data['results'] as List<dynamic>,
      );
      return results.map(StockModel.fromJson).toList();
    } catch (_) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return _fallbackStocks;
    }
  }

  Future<StockModel> fetchStockDetails(String symbol) async {
    try {
      final response = await _dio
          .get('${ApiConstants.market}/stocks/$symbol/')
          .timeout(const Duration(seconds: 3));
      final chartResponse = await _dio
          .get('${ApiConstants.market}/stocks/$symbol/chart/')
          .timeout(const Duration(seconds: 3));
      final points = List<dynamic>.from(chartResponse.data['points'] as List<dynamic>)
          .map((item) => (item as num).toDouble())
          .toList();
      return StockModel.fromJson(
        Map<String, dynamic>.from(response.data as Map),
        chartPoints: points,
      );
    } catch (_) {
      final stocks = await fetchStocks();
      return stocks.firstWhere((stock) => stock.symbol == symbol);
    }
  }
}
```

---

## `backend/config/urls.py`

```python
from django.contrib import admin
from django.http import JsonResponse
from django.urls import path, include

def api_home(request):
    return JsonResponse({
        "message": "Stock Simulator Django API is running!"
    })

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', api_home),
    path('api/users/', include('users.urls')),
    path('api/market/', include('market.urls')),
    path('api/portfolio/', include('portfolio.urls')),
    path('api/watchlist/', include('watchlist.urls')),
    path('api/leaderboard/', include('leaderboard.urls')),
    path('api/ml/', include('ml_api.urls')),
]
```

---

## `backend/users/models.py`

```python
class UserProfile(models.Model):
    user = models.OneToOneField(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='profile',
    )
    display_name = models.CharField(max_length=150)
    virtual_balance = models.DecimalField(max_digits=12, decimal_places=2, default=25000)
    is_demo_account = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.display_name or self.user.username
```

---

## `backend/users/views.py`

```python
@api_view(['POST'])
def register_user(request):
    first_name = request.data.get('first_name', '').strip()
    last_name = request.data.get('last_name', '').strip()
    name = request.data.get('name', 'Demo User').strip()
    email = request.data.get('email', 'demo@stocksim.in')
    username = (
        request.data.get('username')
        or request.data.get('user_id')
        or email.split('@')[0]
    )

    user, created = User.objects.get_or_create(
        username=username,
        defaults={
            'email': email,
            'first_name': first_name or name,
            'last_name': last_name,
        },
    )

    profile, _ = UserProfile.objects.get_or_create(
        user=user,
        defaults={
            'display_name': name,
            'virtual_balance': 1000000,
            'is_demo_account': True,
        },
    )

    return Response({
        'message': 'Registration successful.',
        'user': UserSerializer(user).data,
    }, status=status.HTTP_201_CREATED if created else status.HTTP_200_OK)


@api_view(['POST'])
def login_user(request):
    email = request.data.get('email', 'demo@stocksim.in')
    user = User.objects.filter(email=email).first() or get_demo_user()

    return Response({
        'message': 'Login successful.',
        'token': 'demo-token-123',
        'user': UserSerializer(user).data,
    })
```

---

## `backend/market/models.py`

```python
class Stock(models.Model):
    symbol = models.CharField(max_length=20, unique=True)
    company_name = models.CharField(max_length=255)
    sector = models.CharField(max_length=120, blank=True)
    description = models.TextField(blank=True)
    current_price = models.DecimalField(max_digits=12, decimal_places=2)
    price_change = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    change_percent = models.DecimalField(max_digits=8, decimal_places=2, default=0)
    day_high = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    day_low = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    volume = models.BigIntegerField(default=0)
    is_active = models.BooleanField(default=True)


class StockCandle(models.Model):
    stock = models.ForeignKey(Stock, on_delete=models.CASCADE, related_name='candles')
    interval = models.CharField(max_length=20, default='1D')
    open_price = models.DecimalField(max_digits=12, decimal_places=2)
    high_price = models.DecimalField(max_digits=12, decimal_places=2)
    low_price = models.DecimalField(max_digits=12, decimal_places=2)
    close_price = models.DecimalField(max_digits=12, decimal_places=2)
    volume = models.BigIntegerField(default=0)
    recorded_at = models.DateTimeField()
```

---

## `backend/market/views.py`

```python
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
def stock_list(request):
    _ensure_demo_stocks()
    serializer = StockSerializer(Stock.objects.filter(is_active=True), many=True)
    return Response({
        'count': len(serializer.data),
        'results': serializer.data,
    })


@api_view(['GET'])
def stock_chart(request, symbol):
    _ensure_demo_stocks()
    stock = Stock.objects.filter(symbol=symbol.upper()).first()
    candles = StockCandle.objects.filter(stock=stock, interval='1D')
    return Response({
        'symbol': stock.symbol,
        'points': [float(candle.close_price) for candle in candles],
        'interval': '1D',
        'candles': StockCandleSerializer(candles, many=True).data,
    })
```

---

## `backend/portfolio/models.py`

```python
class Holding(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='holdings',
    )
    stock = models.ForeignKey(
        'market.Stock',
        on_delete=models.CASCADE,
        related_name='holdings',
    )
    quantity = models.PositiveIntegerField(default=0)
    average_price = models.DecimalField(max_digits=12, decimal_places=2, default=0)


class Transaction(models.Model):
    class OrderType(models.TextChoices):
        BUY = 'BUY', 'Buy'
        SELL = 'SELL', 'Sell'

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='transactions',
    )
    stock = models.ForeignKey(
        'market.Stock',
        on_delete=models.CASCADE,
        related_name='transactions',
    )
    order_type = models.CharField(max_length=4, choices=OrderType.choices)
    quantity = models.PositiveIntegerField()
    price = models.DecimalField(max_digits=12, decimal_places=2)
    total_amount = models.DecimalField(max_digits=14, decimal_places=2)
```

---

## `backend/portfolio/views.py`

```python
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
```

---

## `backend/ml_api/services.py`

```python
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
        self.universe_path = Path(
            getattr(
                settings,
                "ML_UNIVERSE_PATH",
                self.repo_root / "ml" / "datasets" / "stocks_universe.csv",
            )
        )

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
        recommendations = []
        for symbol in self._available_symbols()[:10]:
            payload = self.predict(symbol, horizon="short")
            confidence = float(payload["confidence"])
            risk_score = float(payload["risk_score"])
            score = max(1, min(99, round((confidence * 100) - (risk_score * 35))))
            recommendations.append(
                payload | {
                    "score": score,
                    "label": self._label_for_prediction(
                        payload["prediction"], score, risk_score,
                    ),
                }
            )

        recommendations.sort(key=lambda item: item["score"], reverse=True)
        return recommendations[:5]
```

---

## `backend/ml_api/views.py`

```python
engine = InsightEngine()


@api_view(['GET'])
def predict_stock(request, symbol):
    horizon = request.query_params.get("horizon", "short")
    payload = engine.predict(symbol, horizon=horizon)
    snapshot = PredictionSnapshot.objects.create(
        symbol=payload['symbol'],
        prediction=payload['prediction'],
        confidence=payload['confidence'],
        risk_score=payload['risk_score'],
        source=payload['source'],
    )
    return Response(PredictionSnapshotSerializer(snapshot).data)


@api_view(['GET', 'POST'])
def recommendation_summary(request):
    return Response({
        'engine': engine.engine_status(),
        'results': engine.recommend(),
    })
```

---

## `ml/scripts/build_features.py`

```python
def _compute_group_features(group: pd.DataFrame) -> pd.DataFrame:
    group = group.sort_values("Date").copy()
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

    group["future_close_10d"] = group["Close"].shift(-10)
    group["future_close_30d"] = group["Close"].shift(-30)
    group["target_up_short"] = (group["future_close_10d"] > group["Close"] * 1.02).astype(int)
    group["target_up_long"] = (group["future_close_30d"] > group["Close"] * 1.05).astype(int)
    return group
```

---

## `ml/scripts/train_baseline_model.py`

```python
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
    frame = pd.read_csv(DATASET_PATH)
    frame["Date"] = pd.to_datetime(frame["Date"], errors="coerce")
    frame = frame.replace([np.inf, -np.inf], np.nan).dropna(subset=FEATURE_COLUMNS + ["Date"])
    frame = frame.sort_values("Date").reset_index(drop=True)
    x = frame[FEATURE_COLUMNS]

    split_index = int(len(frame) * 0.8)
    x_train = x.iloc[:split_index]
    x_test = x.iloc[split_index:]

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

        model_path = MODEL_PATH_SHORT if horizon == "short" else MODEL_PATH_LONG
        meta_path = META_PATH_SHORT if horizon == "short" else META_PATH_LONG
        joblib.dump(model, model_path)
        meta_path.write_text(
            json.dumps({"target": target_column}, indent=2),
            encoding="utf-8",
        )
```
