# Stock Simulator India

Indian stock market simulator built with:

- Flutter for the app UI
- Django for APIs and business logic
- ML for prediction and recommendation insights

This project supports Chrome-first Flutter development and can still run even if ML falls back to rule-based logic.

## Current Status

The project currently includes:

- Flutter app with:
  - splash
  - login / register
  - home dashboard
  - market list
  - stock details
  - buy / sell paper trading
  - portfolio
  - transaction history
  - watchlist
  - leaderboard
  - settings
- Django backend with:
  - users
  - market
  - portfolio
  - watchlist
  - leaderboard
  - ml_api
- ML pipeline with:
  - dynamic stock universe
  - historical data fetch script
  - feature engineering script
  - baseline model training
  - Django-served prediction and recommendation endpoints

## Project Structure

```text
stock_simulator/
├── Flutter/
├── backend/
├── ml/
└── README.md
```

## Tech Stack

- Flutter
- Riverpod
- go_router
- Dio
- Django
- Django REST Framework
- pandas
- scikit-learn
- yfinance
- joblib

## Features

### App Features

- paper trading with virtual money
- Indian stock-focused UI and rupee formatting
- watchlist management
- portfolio summary and holdings
- transaction history
- leaderboard
- backend health visibility

### ML Features

- stock prediction endpoint
- recommendation endpoint
- dynamic symbol universe through CSV
- trained model loading through Django
- fallback rule-based engine if model inference is unavailable

## Flutter App

Flutter app location:

- [Flutter](d:\stock_simulator\Flutter)

Run Flutter:

```powershell
cd "D:\stock_simulator\Flutter"
flutter pub get
flutter run -d chrome
```

## Django Backend

Backend location:

- [backend](d:\stock_simulator\backend)

Run Django:

```powershell
cd "D:\stock_simulator\backend"
.\venv\Scripts\Activate.ps1
pip install -r ..\ml\requirements.txt
python manage.py runserver
```

Main API root:

- `http://127.0.0.1:8000/api/`

Important backend endpoints:

- `/api/market/stocks/`
- `/api/market/overview/`
- `/api/portfolio/summary/`
- `/api/portfolio/transactions/`
- `/api/watchlist/items/`
- `/api/leaderboard/rankings/`
- `/api/ml/`
- `/api/ml/status/`
- `/api/ml/predict/<symbol>/`
- `/api/ml/recommend/`

## ML Workspace

ML workspace location:

- [ml](d:\stock_simulator\ml)

Key files:

- [stocks_universe.csv](d:\stock_simulator\ml\datasets\stocks_universe.csv)
- [fetch_market_data.py](d:\stock_simulator\ml\scripts\fetch_market_data.py)
- [build_features.py](d:\stock_simulator\ml\scripts\build_features.py)
- [train_baseline_model.py](d:\stock_simulator\ml\scripts\train_baseline_model.py)
- [baseline_stock_model.joblib](d:\stock_simulator\ml\models\baseline_stock_model.joblib)
- [baseline_stock_model_meta.json](d:\stock_simulator\ml\models\baseline_stock_model_meta.json)

### ML Pipeline

1. Fetch historical market data for the stock universe.
2. Build engineered features.
3. Train the baseline model.
4. Save the trained model in `ml/models/`.
5. Let Django serve predictions from the saved model.

Run the local ML pipeline:

```powershell
cd "D:\stock_simulator\ml"
pip install -r requirements.txt
python scripts\fetch_market_data.py
python scripts\build_features.py
python scripts\train_baseline_model.py
```

### Current ML Mode

Django is currently configured to use:

- `ML_MODE = "model"`

That means Django will try to use the trained model first.

If model inference fails, fallback logic still exists in the ML engine design, but the current setup is intended to run with the trained model files present in:

- [ml/models](d:\stock_simulator\ml\models)

## Testing Flow

Recommended local testing order:

1. Start Django backend.
2. Verify `/api/ml/status/` returns:
   - `model_available: true`
   - `meta_available: true`
   - `universe_available: true`
3. Start Flutter on Chrome.
4. Open a stock details page.
5. Confirm the ML insight card appears and shows backend-driven output.

## Notes

- The first baseline ML model is integrated successfully, but its accuracy is still weak and should be improved in the next iteration.
- The app is already usable as a Flutter + Django project even if ML is temporarily downgraded to rule-based mode.
- This project is currently optimized for development speed and architecture completion first, then model-quality improvement second.

## Next Planned Improvement

The next major phase is to improve ML quality beyond the current weak baseline by:

- improving features
- improving target design
- expanding the stock universe
- validating the model more realistically
- making predictions more reliable than the current ~0.50 baseline


STOCK SIMULATOR APP (FLUTTER)
│
├── 1. APP ROOT
│   ├── main.dart
│   ├── app/
│   │   ├── app.dart
│   │   ├── router/
│   │   │   ├── app_router.dart
│   │   │   └── route_names.dart
│   │   ├── theme/
│   │   │   ├── app_theme.dart
│   │   │   ├── app_colors.dart
│   │   │   ├── app_text_styles.dart
│   │   │   └── app_spacing.dart
│   │   └── constants/
│   │       ├── app_constants.dart
│   │       ├── api_constants.dart
│   │       ├── storage_keys.dart
│   │       └── asset_paths.dart
│
├── 2. CORE LAYER
│   ├── core/
│   │   ├── network/
│   │   │   ├── dio_client.dart
│   │   │   ├── network_exceptions.dart
│   │   │   ├── api_response_handler.dart
│   │   │   └── interceptors/
│   │   │       ├── auth_interceptor.dart
│   │   │       ├── logging_interceptor.dart
│   │   │       └── retry_interceptor.dart
│   │   │
│   │   ├── services/
│   │   │   ├── local_storage_service.dart
│   │   │   ├── secure_storage_service.dart
│   │   │   ├── market_clock_service.dart
│   │   │   ├── notification_service.dart
│   │   │   ├── simulator_engine_service.dart
│   │   │   └── portfolio_calculator_service.dart
│   │   │
│   │   ├── utils/
│   │   │   ├── app_logger.dart
│   │   │   ├── currency_formatter.dart
│   │   │   ├── percent_formatter.dart
│   │   │   ├── date_time_utils.dart
│   │   │   ├── validators.dart
│   │   │   ├── trade_validators.dart
│   │   │   └── result.dart
│   │   │
│   │   ├── widgets/
│   │   │   ├── common/
│   │   │   │   ├── app_button.dart
│   │   │   │   ├── app_text_field.dart
│   │   │   │   ├── app_loader.dart
│   │   │   │   ├── app_error_view.dart
│   │   │   │   ├── empty_state_view.dart
│   │   │   │   ├── section_header.dart
│   │   │   │   └── stat_card.dart
│   │   │   ├── market/
│   │   │   │   ├── stock_tile.dart
│   │   │   │   ├── stock_card.dart
│   │   │   │   ├── price_change_chip.dart
│   │   │   │   ├── market_index_card.dart
│   │   │   │   └── stock_chart_widget.dart
│   │   │   ├── portfolio/
│   │   │   │   ├── holding_card.dart
│   │   │   │   ├── portfolio_summary_card.dart
│   │   │   │   ├── transaction_tile.dart
│   │   │   │   └── allocation_chart_widget.dart
│   │   │   └── trade/
│   │   │       ├── trade_action_button.dart
│   │   │       ├── quantity_selector.dart
│   │   │       ├── order_summary_card.dart
│   │   │       └── order_type_chip.dart
│   │   │
│   │   └── providers/
│   │       ├── dio_provider.dart
│   │       ├── storage_provider.dart
│   │       ├── notification_provider.dart
│   │       └── app_init_provider.dart
│
├── 3. SHARED LAYER
│   ├── shared/
│   │   ├── enums/
│   │   │   ├── order_type.dart
│   │   │   ├── transaction_type.dart
│   │   │   ├── market_status.dart
│   │   │   ├── alert_type.dart
│   │   │   ├── challenge_status.dart
│   │   │   └── portfolio_filter_type.dart
│   │   │
│   │   ├── extensions/
│   │   │   ├── context_extensions.dart
│   │   │   ├── string_extensions.dart
│   │   │   ├── num_extensions.dart
│   │   │   └── date_extensions.dart
│   │   │
│   │   └── mixins/
│   │       ├── form_validation_mixin.dart
│   │       └── trade_calculation_mixin.dart
│
├── 4. DATA LAYER
│   ├── data/
│   │   ├── models/
│   │   │   ├── stock/
│   │   │   │   ├── stock_model.dart
│   │   │   │   ├── stock_quote_model.dart
│   │   │   │   ├── stock_chart_model.dart
│   │   │   │   ├── stock_stats_model.dart
│   │   │   │   └── stock_search_model.dart
│   │   │   │
│   │   │   ├── market/
│   │   │   │   ├── market_index_model.dart
│   │   │   │   ├── top_mover_model.dart
│   │   │   │   ├── candle_model.dart
│   │   │   │   └── news_model.dart
│   │   │   │
│   │   │   ├── portfolio/
│   │   │   │   ├── holding_model.dart
│   │   │   │   ├── portfolio_model.dart
│   │   │   │   ├── transaction_model.dart
│   │   │   │   ├── portfolio_performance_model.dart
│   │   │   │   └── allocation_model.dart
│   │   │   │
│   │   │   ├── order/
│   │   │   │   ├── buy_order_model.dart
│   │   │   │   ├── sell_order_model.dart
│   │   │   │   ├── limit_order_model.dart
│   │   │   │   ├── stop_loss_order_model.dart
│   │   │   │   └── open_order_model.dart
│   │   │   │
│   │   │   ├── watchlist/
│   │   │   │   └── watchlist_item_model.dart
│   │   │   │
│   │   │   ├── user/
│   │   │   │   ├── user_model.dart
│   │   │   │   ├── auth_session_model.dart
│   │   │   │   ├── user_profile_model.dart
│   │   │   │   └── achievement_model.dart
│   │   │   │
│   │   │   ├── alerts/
│   │   │   │   ├── price_alert_model.dart
│   │   │   │   └── notification_model.dart
│   │   │   │
│   │   │   └── learning/
│   │   │       ├── lesson_model.dart
│   │   │       └── challenge_model.dart
│   │   │
│   │   ├── datasources/
│   │   │   ├── remote/
│   │   │   │   ├── auth_remote_data_source.dart
│   │   │   │   ├── market_remote_data_source.dart
│   │   │   │   ├── portfolio_remote_data_source.dart
│   │   │   │   ├── leaderboard_remote_data_source.dart
│   │   │   │   ├── news_remote_data_source.dart
│   │   │   │   ├── analytics_remote_data_source.dart
│   │   │   │   └── alerts_remote_data_source.dart
│   │   │   │
│   │   │   └── local/
│   │   │       ├── auth_local_data_source.dart
│   │   │       ├── portfolio_local_data_source.dart
│   │   │       ├── watchlist_local_data_source.dart
│   │   │       ├── settings_local_data_source.dart
│   │   │       ├── alerts_local_data_source.dart
│   │   │       ├── challenge_local_data_source.dart
│   │   │       └── cache_local_data_source.dart
│   │   │
│   │   └── repositories/
│   │       ├── auth_repository_impl.dart
│   │       ├── market_repository_impl.dart
│   │       ├── portfolio_repository_impl.dart
│   │       ├── watchlist_repository_impl.dart
│   │       ├── leaderboard_repository_impl.dart
│   │       ├── news_repository_impl.dart
│   │       ├── alerts_repository_impl.dart
│   │       ├── analytics_repository_impl.dart
│   │       ├── learning_repository_impl.dart
│   │       └── challenge_repository_impl.dart
│
├── 5. DOMAIN LAYER
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── stock_entity.dart
│   │   │   ├── stock_quote_entity.dart
│   │   │   ├── stock_chart_entity.dart
│   │   │   ├── holding_entity.dart
│   │   │   ├── transaction_entity.dart
│   │   │   ├── portfolio_entity.dart
│   │   │   ├── user_entity.dart
│   │   │   ├── leaderboard_entity.dart
│   │   │   ├── news_entity.dart
│   │   │   ├── alert_entity.dart
│   │   │   ├── open_order_entity.dart
│   │   │   ├── analytics_entity.dart
│   │   │   ├── lesson_entity.dart
│   │   │   └── challenge_entity.dart
│   │   │
│   │   ├── repositories/
│   │   │   ├── auth_repository.dart
│   │   │   ├── market_repository.dart
│   │   │   ├── portfolio_repository.dart
│   │   │   ├── watchlist_repository.dart
│   │   │   ├── leaderboard_repository.dart
│   │   │   ├── news_repository.dart
│   │   │   ├── alerts_repository.dart
│   │   │   ├── analytics_repository.dart
│   │   │   ├── learning_repository.dart
│   │   │   └── challenge_repository.dart
│   │   │
│   │   └── usecases/
│   │       ├── auth/
│   │       │   ├── login_user.dart
│   │       │   ├── register_user.dart
│   │       │   ├── logout_user.dart
│   │       │   └── continue_as_guest.dart
│   │       │
│   │       ├── market/
│   │       │   ├── get_market_overview.dart
│   │       │   ├── search_stocks.dart
│   │       │   ├── get_stock_details.dart
│   │       │   ├── get_stock_chart.dart
│   │       │   ├── get_top_gainers.dart
│   │       │   └── get_top_losers.dart
│   │       │
│   │       ├── portfolio/
│   │       │   ├── buy_stock.dart
│   │       │   ├── sell_stock.dart
│   │       │   ├── get_portfolio.dart
│   │       │   ├── get_transaction_history.dart
│   │       │   ├── get_portfolio_analytics.dart
│   │       │   ├── reset_portfolio.dart
│   │       │   └── calculate_profit_loss.dart
│   │       │
│   │       ├── watchlist/
│   │       │   ├── get_watchlist.dart
│   │       │   ├── add_to_watchlist.dart
│   │       │   └── remove_from_watchlist.dart
│   │       │
│   │       ├── orders/
│   │       │   ├── place_limit_order.dart
│   │       │   ├── place_stop_loss_order.dart
│   │       │   ├── get_open_orders.dart
│   │       │   └── cancel_order.dart
│   │       │
│   │       ├── leaderboard/
│   │       │   └── get_leaderboard.dart
│   │       │
│   │       ├── news/
│   │       │   ├── get_market_news.dart
│   │       │   └── get_stock_news.dart
│   │       │
│   │       ├── alerts/
│   │       │   ├── create_price_alert.dart
│   │       │   ├── delete_price_alert.dart
│   │       │   └── get_price_alerts.dart
│   │       │
│   │       ├── analytics/
│   │       │   ├── get_risk_analysis.dart
│   │       │   ├── get_asset_allocation.dart
│   │       │   └── get_performance_timeline.dart
│   │       │
│   │       ├── learning/
│   │       │   ├── get_lessons.dart
│   │       │   └── get_daily_market_summary.dart
│   │       │
│   │       └── challenges/
│   │           ├── get_challenges.dart
│   │           ├── join_challenge.dart
│   │           └── update_challenge_progress.dart
│
├── 6. FEATURES LAYER
│   ├── features/
│   │
│   │   ├── splash/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── splash_page.dart
│   │   │       └── providers/
│   │   │           └── splash_provider.dart
│   │   │
│   │   ├── onboarding/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── onboarding_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── onboarding_card.dart
│   │   │       │   └── onboarding_indicator.dart
│   │   │       └── providers/
│   │   │           └── onboarding_provider.dart
│   │   │
│   │   ├── auth/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── login_page.dart
│   │   │       │   └── register_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── auth_header.dart
│   │   │       │   ├── login_form.dart
│   │   │       │   └── register_form.dart
│   │   │       └── providers/
│   │   │           └── auth_provider.dart
│   │   │
│   │   ├── shell/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── main_shell_page.dart
│   │   │       └── widgets/
│   │   │           └── bottom_nav_bar.dart
│   │   │
│   │   ├── home/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── home_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── dashboard_header.dart
│   │   │       │   ├── quick_actions_row.dart
│   │   │       │   ├── market_overview_section.dart
│   │   │       │   ├── top_movers_section.dart
│   │   │       │   ├── recent_transactions_section.dart
│   │   │       │   └── portfolio_overview_section.dart
│   │   │       └── providers/
│   │   │           └── home_provider.dart
│   │   │
│   │   ├── market/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── market_page.dart
│   │   │       │   ├── stock_search_page.dart
│   │   │       │   ├── stock_details_page.dart
│   │   │       │   ├── market_news_page.dart
│   │   │       │   └── order_book_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── market_tab_bar.dart
│   │   │       │   ├── trending_stock_tile.dart
│   │   │       │   ├── stock_stats_grid.dart
│   │   │       │   ├── chart_timeframe_selector.dart
│   │   │       │   ├── company_overview_card.dart
│   │   │       │   └── buy_sell_bottom_sheet.dart
│   │   │       └── providers/
│   │   │           ├── market_provider.dart
│   │   │           ├── search_provider.dart
│   │   │           ├── stock_details_provider.dart
│   │   │           └── order_book_provider.dart
│   │   │
│   │   ├── portfolio/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── portfolio_page.dart
│   │   │       │   ├── holding_details_page.dart
│   │   │       │   ├── transaction_history_page.dart
│   │   │       │   ├── portfolio_analytics_page.dart
│   │   │       │   └── risk_analysis_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── portfolio_chart_section.dart
│   │   │       │   ├── allocation_pie_section.dart
│   │   │       │   ├── holdings_list_section.dart
│   │   │       │   ├── transaction_filter_bar.dart
│   │   │       │   └── realized_unrealized_card.dart
│   │   │       └── providers/
│   │   │           ├── portfolio_provider.dart
│   │   │           ├── holding_details_provider.dart
│   │   │           ├── transaction_provider.dart
│   │   │           ├── analytics_provider.dart
│   │   │           └── risk_analysis_provider.dart
│   │   │
│   │   ├── trade/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── place_order_page.dart
│   │   │       │   ├── open_orders_page.dart
│   │   │       │   ├── trade_confirmation_page.dart
│   │   │       │   └── order_success_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── order_type_selector.dart
│   │   │       │   ├── quantity_input_card.dart
│   │   │       │   ├── price_input_card.dart
│   │   │       │   ├── order_preview_card.dart
│   │   │       │   └── place_order_footer.dart
│   │   │       └── providers/
│   │   │           ├── trade_provider.dart
│   │   │           ├── open_orders_provider.dart
│   │   │           └── order_confirmation_provider.dart
│   │   │
│   │   ├── watchlist/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── watchlist_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── watchlist_stock_tile.dart
│   │   │       │   └── watchlist_empty_view.dart
│   │   │       └── providers/
│   │   │           └── watchlist_provider.dart
│   │   │
│   │   ├── leaderboard/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── leaderboard_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── leaderboard_tile.dart
│   │   │       │   ├── top_trader_banner.dart
│   │   │       │   └── rank_filter_tabs.dart
│   │   │       └── providers/
│   │   │           └── leaderboard_provider.dart
│   │   │
│   │   ├── news/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── news_page.dart
│   │   │       │   └── news_details_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── news_card.dart
│   │   │       │   ├── news_category_chip.dart
│   │   │       │   └── news_source_row.dart
│   │   │       └── providers/
│   │   │           ├── news_provider.dart
│   │   │           └── news_details_provider.dart
│   │   │
│   │   ├── alerts/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── alerts_page.dart
│   │   │       │   ├── create_alert_page.dart
│   │   │       │   └── alert_history_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── alert_tile.dart
│   │   │       │   ├── alert_form.dart
│   │   │       │   └── trigger_condition_selector.dart
│   │   │       └── providers/
│   │   │           ├── alerts_provider.dart
│   │   │           └── create_alert_provider.dart
│   │   │
│   │   ├── learning/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── learning_hub_page.dart
│   │   │       │   ├── lesson_details_page.dart
│   │   │       │   └── daily_market_summary_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── lesson_card.dart
│   │   │       │   ├── learning_progress_card.dart
│   │   │       │   └── summary_section_card.dart
│   │   │       └── providers/
│   │   │           ├── learning_provider.dart
│   │   │           └── market_summary_provider.dart
│   │   │
│   │   ├── challenges/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── challenges_page.dart
│   │   │       │   ├── challenge_details_page.dart
│   │   │       │   └── daily_missions_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── challenge_card.dart
│   │   │       │   ├── challenge_progress_bar.dart
│   │   │       │   └── mission_tile.dart
│   │   │       └── providers/
│   │   │           ├── challenge_provider.dart
│   │   │           └── mission_provider.dart
│   │   │
│   │   ├── achievements/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── achievements_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── badge_card.dart
│   │   │       │   └── achievement_header.dart
│   │   │       └── providers/
│   │   │           └── achievements_provider.dart
│   │   │
│   │   ├── profile/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── profile_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── profile_header.dart
│   │   │       │   ├── stats_overview_row.dart
│   │   │       │   └── profile_action_tile.dart
│   │   │       └── providers/
│   │   │           └── profile_provider.dart
│   │   │
│   │   ├── notifications/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── notifications_page.dart
│   │   │       ├── widgets/
│   │   │       │   └── notification_tile.dart
│   │   │       └── providers/
│   │   │           └── notifications_provider.dart
│   │   │
│   │   ├── settings/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── settings_page.dart
│   │   │       │   ├── simulation_settings_page.dart
│   │   │       │   ├── help_support_page.dart
│   │   │       │   └── about_app_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── settings_section.dart
│   │   │       │   ├── settings_tile.dart
│   │   │       │   ├── simulation_slider_tile.dart
│   │   │       │   └── reset_portfolio_dialog.dart
│   │   │       └── providers/
│   │   │           ├── settings_provider.dart
│   │   │           └── simulation_settings_provider.dart
│   │   │
│   │   └── support/
│   │       └── presentation/
│   │           ├── pages/
│   │           │   ├── faq_page.dart
│   │           │   └── feedback_page.dart
│   │           ├── widgets/
│   │           │   ├── faq_tile.dart
│   │           │   └── feedback_form.dart
│   │           └── providers/
│   │               └── support_provider.dart
│
├── 7. SIMULATOR LOGIC FLOW
│   ├── User starts app
│   │   ├── Gets onboarding
│   │   ├── Registers / logs in / guest mode
│   │   └── Receives initial virtual balance
│   │
│   ├── Market flow
│   │   ├── Browse stocks
│   │   ├── Search stocks
│   │   ├── View stock details
│   │   ├── Check chart / news / stats
│   │   └── Open buy/sell action
│   │
│   ├── Buy flow
│   │   ├── Select order type
│   │   ├── Enter quantity
│   │   ├── Calculate total cost
│   │   ├── Validate balance
│   │   ├── Confirm trade
│   │   ├── Save transaction
│   │   ├── Update holding
│   │   └── Update available cash
│   │
│   ├── Sell flow
│   │   ├── Enter quantity
│   │   ├── Validate owned shares
│   │   ├── Confirm trade
│   │   ├── Save transaction
│   │   ├── Update holding quantity
│   │   ├── Remove holding if zero
│   │   └── Add balance back
│   │
│   ├── Portfolio flow
│   │   ├── Calculate invested value
│   │   ├── Calculate current value
│   │   ├── Calculate profit/loss
│   │   ├── Calculate return %
│   │   ├── Show analytics
│   │   └── Show risk analysis
│   │
│   ├── Watchlist flow
│   │   ├── Add stock
│   │   ├── Remove stock
│   │   └── Monitor prices
│   │
│   ├── Alerts flow
│   │   ├── Create alert
│   │   ├── Monitor condition
│   │   └── Trigger notification
│   │
│   ├── Challenge flow
│   │   ├── Join challenge
│   │   ├── Track progress
│   │   └── Unlock rewards
│   │
│   └── Settings flow
│       ├── Change theme
│       ├── Change simulator rules
│       ├── Reset portfolio
│       └── Update preferences
│
├── 8. BUSINESS RULES
│   ├── Initial balance assigned on first launch
│   ├── User cannot buy if balance is insufficient
│   ├── User cannot sell more than owned quantity
│   ├── Average buy price updates on repeated buys
│   ├── Profit/Loss updates from latest market price
│   ├── Transaction history stores every trade
│   ├── Watchlist does not affect portfolio
│   ├── Alerts only notify, not auto-trade
│   ├── Open orders stay pending until conditions match
│   └── Reset portfolio clears holdings, history, orders, analytics
│
├── 9. UI NAVIGATION STRUCTURE
│   ├── Splash
│   ├── Onboarding
│   ├── Auth
│   ├── Main Shell
│   │   ├── Home
│   │   ├── Market
│   │   ├── Portfolio
│   │   ├── Watchlist
│   │   └── Settings
│   │
│   ├── Nested screens
│   │   ├── Stock Details
│   │   ├── Trade Pages
│   │   ├── Open Orders
│   │   ├── Transaction History
│   │   ├── News
│   │   ├── Alerts
│   │   ├── Analytics
│   │   ├── Learning Hub
│   │   ├── Challenges
│   │   ├── Achievements
│   │   ├── Leaderboard
│   │   └── Profile
│
└── 10. DEPENDENCIES
    ├── State Management
    │   ├── flutter_riverpod
    │   ├── riverpod_generator
    │   └── riverpod_lint
    │
    ├── Routing
    │   └── go_router
    │
    ├── Networking
    │   ├── dio
    │   └── internet_connection_checker_plus
    │
    ├── Local Storage
    │   ├── hive
    │   ├── hive_flutter
    │   ├── hive_generator
    │   ├── shared_preferences
    │   └── flutter_secure_storage
    │
    ├── Model Generation
    │   ├── freezed
    │   ├── freezed_annotation
    │   ├── json_serializable
    │   ├── json_annotation
    │   ├── build_runner
    │   └── equatable
    │
    ├── Charts
    │   └── fl_chart
    │
    ├── UI Helpers
    │   ├── cached_network_image
    │   ├── shimmer
    │   ├── intl
    │   ├── uuid
    │   └── collection
    │
    └── Optional
        ├── flutter_local_notifications
        ├── lottie
        └── url_launcher