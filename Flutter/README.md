# Stock Simulator

A stock market simulator app built with Flutter.

## Goal

This project is a stock simulator / paper trading app where users can:

- create an account
- browse stocks
- view stock details and charts
- buy and sell with virtual money
- track portfolio performance
- manage a watchlist
- view leaderboard rankings
- manage settings

The long-term stack for this project is:

- `Flutter` for the frontend app
- `Django` for backend APIs, authentication, portfolio logic, and data management
- `ML/AI` using Anaconda-based Python tooling or Google-hosted notebook/workflow tools for prediction, insights, analytics, or recommendation features

## Recommended Architecture

Recommended architecture choice for this project:

- Architecture: `Feature-first + MVVM + Repository pattern`
- State management: `Riverpod`
- Routing: `go_router`
- Storage: `Hive + flutter_secure_storage`
- Charts: `fl_chart`
- Networking: `dio`
- Models: `freezed + json_serializable`

## Minimum MVP Screens

For a stock simulator MVP, these are the minimum screens:

- Splash
- Login / Register
- Home Dashboard
- Market / Explore
- Stock Details
- Buy / Sell Order
- Portfolio
- Transaction History
- Watchlist
- Leaderboard
- Settings

## Planned Flutter Structure

```text
lib/
│
├── app/
│   ├── app.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   └── route_names.dart
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart
│   └── constants/
│       ├── app_constants.dart
│       ├── api_constants.dart
│       └── storage_keys.dart
│
├── core/
│   ├── network/
│   │   ├── dio_client.dart
│   │   ├── network_exceptions.dart
│   │   └── interceptors/
│   │       ├── auth_interceptor.dart
│   │       └── logging_interceptor.dart
│   │
│   ├── services/
│   │   ├── local_storage_service.dart
│   │   ├── secure_storage_service.dart
│   │   ├── market_clock_service.dart
│   │   └── notification_service.dart
│   │
│   ├── utils/
│   │   ├── app_logger.dart
│   │   ├── currency_formatter.dart
│   │   ├── date_time_utils.dart
│   │   ├── validators.dart
│   │   └── result.dart
│   │
│   ├── widgets/
│   │   ├── app_button.dart
│   │   ├── app_loader.dart
│   │   ├── app_error_view.dart
│   │   ├── empty_state_view.dart
│   │   └── price_change_chip.dart
│   │
│   └── providers/
│       ├── dio_provider.dart
│       ├── storage_provider.dart
│       └── app_init_provider.dart
│
├── data/
│   ├── models/
│   │   ├── stock/
│   │   │   ├── stock_model.dart
│   │   │   ├── stock_model.freezed.dart
│   │   │   └── stock_model.g.dart
│   │   ├── market/
│   │   │   ├── candle_model.dart
│   │   │   ├── quote_model.dart
│   │   │   └── news_model.dart
│   │   ├── portfolio/
│   │   │   ├── holding_model.dart
│   │   │   ├── portfolio_model.dart
│   │   │   └── transaction_model.dart
│   │   ├── order/
│   │   │   ├── buy_order_model.dart
│   │   │   └── sell_order_model.dart
│   │   └── user/
│   │       ├── user_model.dart
│   │       └── auth_session_model.dart
│   │
│   ├── datasources/
│   │   ├── remote/
│   │   │   ├── auth_remote_data_source.dart
│   │   │   ├── market_remote_data_source.dart
│   │   │   ├── portfolio_remote_data_source.dart
│   │   │   └── leaderboard_remote_data_source.dart
│   │   │
│   │   └── local/
│   │       ├── auth_local_data_source.dart
│   │       ├── watchlist_local_data_source.dart
│   │       ├── portfolio_local_data_source.dart
│   │       └── settings_local_data_source.dart
│   │
│   └── repositories/
│       ├── auth_repository_impl.dart
│       ├── market_repository_impl.dart
│       ├── portfolio_repository_impl.dart
│       ├── watchlist_repository_impl.dart
│       └── leaderboard_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   ├── stock_entity.dart
│   │   ├── holding_entity.dart
│   │   ├── transaction_entity.dart
│   │   ├── portfolio_entity.dart
│   │   └── user_entity.dart
│   │
│   ├── repositories/
│   │   ├── auth_repository.dart
│   │   ├── market_repository.dart
│   │   ├── portfolio_repository.dart
│   │   ├── watchlist_repository.dart
│   │   └── leaderboard_repository.dart
│   │
│   └── usecases/
│       ├── auth/
│       │   ├── login_user.dart
│       │   ├── register_user.dart
│       │   └── logout_user.dart
│       ├── market/
│       │   ├── get_market_overview.dart
│       │   ├── search_stocks.dart
│       │   ├── get_stock_details.dart
│       │   └── get_stock_chart.dart
│       ├── portfolio/
│       │   ├── buy_stock.dart
│       │   ├── sell_stock.dart
│       │   ├── get_portfolio.dart
│       │   ├── get_transaction_history.dart
│       │   └── reset_portfolio.dart
│       ├── watchlist/
│       │   ├── get_watchlist.dart
│       │   ├── add_to_watchlist.dart
│       │   └── remove_from_watchlist.dart
│       └── leaderboard/
│           └── get_leaderboard.dart
│
├── features/
│   ├── splash/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   └── splash_page.dart
│   │   │   └── providers/
│   │   │       └── splash_provider.dart
│   │
│   ├── auth/
│   │   └── presentation/
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   └── register_page.dart
│   │       ├── widgets/
│   │       │   ├── auth_header.dart
│   │       │   └── auth_form.dart
│   │       └── providers/
│   │           └── auth_provider.dart
│   │
│   ├── home/
│   │   └── presentation/
│   │       ├── pages/
│   │       │   └── home_page.dart
│   │       ├── widgets/
│   │       │   ├── market_index_card.dart
│   │       │   ├── trending_stock_tile.dart
│   │       │   └── portfolio_summary_card.dart
│   │       └── providers/
│   │           └── home_provider.dart
│   │
│   ├── market/
│   │   └── presentation/
│   │       ├── pages/
│   │       │   ├── market_page.dart
│   │       │   ├── stock_details_page.dart
│   │       │   └── stock_search_page.dart
│   │       ├── widgets/
│   │       │   ├── stock_card.dart
│   │       │   ├── stock_chart_widget.dart
│   │       │   ├── stock_stats_grid.dart
│   │       │   └── buy_sell_bottom_sheet.dart
│   │       └── providers/
│   │           ├── market_provider.dart
│   │           ├── stock_details_provider.dart
│   │           └── search_provider.dart
│   │
│   ├── portfolio/
│   │   └── presentation/
│   │       ├── pages/
│   │       │   ├── portfolio_page.dart
│   │       │   └── transaction_history_page.dart
│   │       ├── widgets/
│   │       │   ├── holding_card.dart
│   │       │   ├── allocation_chart.dart
│   │       │   └── transaction_tile.dart
│   │       └── providers/
│   │           ├── portfolio_provider.dart
│   │           └── transaction_provider.dart
│   │
│   ├── watchlist/
│   │   └── presentation/
│   │       ├── pages/
│   │       │   └── watchlist_page.dart
│   │       ├── widgets/
│   │       │   └── watchlist_stock_tile.dart
│   │       └── providers/
│   │           └── watchlist_provider.dart
│   │
│   ├── leaderboard/
│   │   └── presentation/
│   │       ├── pages/
│   │       │   └── leaderboard_page.dart
│   │       ├── widgets/
│   │       │   └── leaderboard_tile.dart
│   │       └── providers/
│   │           └── leaderboard_provider.dart
│   │
│   └── settings/
│       └── presentation/
│           ├── pages/
│           │   └── settings_page.dart
│           ├── widgets/
│           │   └── settings_section.dart
│           └── providers/
│               └── settings_provider.dart
│
├── shared/
│   ├── enums/
│   │   ├── order_type.dart
│   │   ├── transaction_type.dart
│   │   └── market_status.dart
│   ├── extensions/
│   │   ├── context_extensions.dart
│   │   ├── string_extensions.dart
│   │   └── num_extensions.dart
│   └── mixins/
│       └── form_validation_mixin.dart
│
└── main.dart
```

## Starter `pubspec.yaml`

```yaml
name: stock_simulator
description: A stock market simulator app built with Flutter.
publish_to: "none"

version: 1.0.0+1

environment:
  sdk: ">=3.4.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_riverpod: ^latest
  go_router: ^latest
  dio: ^latest
  freezed_annotation: ^latest
  json_annotation: ^latest
  hive: ^latest
  hive_flutter: ^latest
  flutter_secure_storage: ^latest
  shared_preferences: ^latest
  fl_chart: ^latest
  intl: ^latest
  uuid: ^latest
  equatable: ^latest
  cached_network_image: ^latest
  shimmer: ^latest
  internet_connection_checker_plus: ^latest

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^latest
  build_runner: ^latest
  freezed: ^latest
  json_serializable: ^latest
  hive_generator: ^latest
  riverpod_generator: ^latest
  custom_lint: ^latest
  riverpod_lint: ^latest

flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/icons/
    - assets/lottie/
    - assets/mock/
```

## Assets Folder Structure

```text
assets/
├── icons/
│   ├── app_logo.png
│   ├── google_icon.png
│   └── stock_placeholder.png
├── images/
│   ├── auth_bg.png
│   ├── empty_watchlist.png
│   └── portfolio_banner.png
├── lottie/
│   ├── loading.json
│   └── success.json
└── mock/
    ├── market_mock.json
    └── portfolio_mock.json
```

For now, placeholders are acceptable. Design assets can be replaced later.

## First Build File List

These files were considered enough for the first working MVP build:

```text
lib/
├── main.dart
├── app/app.dart
├── app/router/app_router.dart
├── app/router/route_names.dart
├── app/theme/app_theme.dart
├── app/constants/api_constants.dart
├── core/network/dio_client.dart
├── core/services/local_storage_service.dart
├── core/widgets/app_loader.dart
├── core/widgets/app_error_view.dart
├── data/models/stock/stock_model.dart
├── data/models/portfolio/holding_model.dart
├── data/models/portfolio/transaction_model.dart
├── data/datasources/remote/market_remote_data_source.dart
├── data/datasources/local/watchlist_local_data_source.dart
├── data/repositories/market_repository_impl.dart
├── data/repositories/portfolio_repository_impl.dart
├── domain/repositories/market_repository.dart
├── domain/repositories/portfolio_repository.dart
├── domain/usecases/market/get_stock_details.dart
├── domain/usecases/portfolio/buy_stock.dart
├── domain/usecases/portfolio/sell_stock.dart
├── features/splash/presentation/pages/splash_page.dart
├── features/auth/presentation/pages/login_page.dart
├── features/home/presentation/pages/home_page.dart
├── features/market/presentation/pages/market_page.dart
├── features/market/presentation/pages/stock_details_page.dart
├── features/market/presentation/providers/market_provider.dart
├── features/portfolio/presentation/pages/portfolio_page.dart
├── features/portfolio/presentation/providers/portfolio_provider.dart
├── features/watchlist/presentation/pages/watchlist_page.dart
└── features/settings/presentation/pages/settings_page.dart
```

## Current Development Notes

- Chrome-first development is preferred instead of emulator-heavy testing.
- Asset placeholders and temporary text are acceptable for now.
- The app can be built blindly first and tested later on another system.
- The project should evolve from mock data first, then connect to Django APIs, and later integrate ML/AI features.

## Planned Backend Responsibilities

Django will be responsible for:

- user authentication
- stock and market API aggregation
- portfolio buy/sell processing
- transaction history
- watchlist persistence
- leaderboard calculations
- connecting ML/AI outputs to the app through APIs

## Planned ML/AI Responsibilities

ML/AI can be used for:

- stock trend prediction
- buy/sell suggestion scoring
- user portfolio risk analysis
- recommendation engine
- sentiment analysis from market news
- anomaly detection for unusual price movement

Possible tooling:

- `Anaconda` for local Python data science environments
- `Jupyter Notebook` for experimentation
- `Google Colab` for cloud notebook workflows
- Python libraries such as `pandas`, `numpy`, `scikit-learn`, `tensorflow`, `pytorch`, or `xgboost`

## Suggested Project Phases

1. Finish Flutter app structure and UI.
2. Build Django backend APIs.
3. Connect Flutter app to Django.
4. Build ML/AI models and expose their output through Django endpoints.
5. Improve UI, persistence, validation, and production readiness.

## Plan B Without ML

If ML/AI is postponed or removed, the project can still ship as a strong product using only:

- `Flutter`
- `Django`

In that version, Django will provide:

- authentication
- market data APIs
- portfolio calculations
- transaction history
- watchlist management
- leaderboard logic
- rule-based insights instead of ML predictions

Possible non-ML replacements:

- top gainers / losers
- volatility badges
- sector trend summaries
- diversification warnings
- rule-based buy/sell hints

This means ML is an enhancement, not a blocker for launching the app.
