import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';

import '../../features/analytics/presentation/pages/portfolio_analytics_page.dart';
import '../../features/analytics/presentation/pages/performance_timeline_page.dart';
import '../../features/analytics/presentation/pages/risk_analysis_page.dart';

import '../../features/alerts/presentation/pages/alerts_page.dart';

import '../../features/achievements/presentation/pages/achievements_page.dart';

import '../../features/challenges/presentation/pages/challenges_page.dart';

import '../../features/home/presentation/pages/home_page.dart';

import '../../features/leaderboard/presentation/pages/leaderboard_page.dart';

import '../../features/learning/presentation/pages/learning_hub_page.dart';
import '../../features/learning/presentation/pages/lecture_page.dart';
import '../../features/learning/presentation/pages/notes_page.dart';

import '../../features/market/presentation/pages/market_page.dart';
import '../../features/market_summary/presentation/pages/daily_market_summary_page.dart';
import '../../features/market/presentation/pages/stock_details_page.dart';

import '../../features/news/presentation/pages/market_news_page.dart';
import '../../features/news/presentation/pages/news_detail_page.dart';

import '../../features/notifications/presentation/pages/notifications_page.dart';

import '../../features/portfolio/presentation/pages/portfolio_page.dart';
import '../../features/portfolio/presentation/pages/transaction_history_page.dart';

import '../../features/profile/presentation/pages/profile_page.dart';

import '../../features/settings/presentation/pages/settings_page.dart';

import '../../features/splash/presentation/pages/splash_page.dart';

import '../../features/streaks/presentation/pages/trading_streak_page.dart';

import '../../features/support/presentation/pages/about_page.dart';
import '../../features/support/presentation/pages/faq_page.dart';
import '../../features/support/presentation/pages/feedback_page.dart';
import '../../features/support/presentation/pages/help_support_page.dart';

import '../../features/trading/presentation/pages/limit_order_page.dart';
import '../../features/trading/presentation/pages/open_orders_page.dart';
import '../../features/trading/presentation/pages/order_book_page.dart';
import '../../features/trading/presentation/pages/order_preview_page.dart';
import '../../features/trading/presentation/pages/stop_loss_page.dart';
import '../../features/trading/presentation/pages/trade_confirmation_page.dart';

import '../../features/watchlist/presentation/pages/watchlist_page.dart';

import 'route_names.dart';

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
      GoRoute(
        path: '/register',
        name: RouteNames.register,
        builder: (context, state) => const RegisterPage(),
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
              GoRoute(
                path: '/leaderboard',
                name: RouteNames.leaderboard,
                builder: (context, state) => const LeaderboardPage(),
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
              GoRoute(
                path: '/transactions',
                name: RouteNames.transactionHistory,
                builder: (context, state) => const TransactionHistoryPage(),
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
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/learning',
                name: RouteNames.learningHub,
                builder: (context, state) => const LearningHubPage(),
              ),
              GoRoute(
                path: '/lectures',
                name: RouteNames.lectureHub,
                builder: (context, state) => const LecturePage(),
              ),
              GoRoute(
                path: '/notes',
                name: RouteNames.notesHub,
                builder: (context, state) => const NotesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                name: RouteNames.settings,
                builder: (context, state) => const SettingsPage(),
              ),
              GoRoute(
                path: '/news',
                name: RouteNames.marketNews,
                builder: (context, state) => const MarketNewsPage(),
                routes: [
                  GoRoute(
                    path: ':newsId',
                    name: RouteNames.newsDetail,
                    builder: (context, state) {
                      return NewsDetailPage(
                        newsId: state.pathParameters['newsId'] ?? '',
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: '/market-summary',
                name: RouteNames.dailySummary,
                builder: (context, state) => const DailyMarketSummaryPage(),
              ),
              GoRoute(
                path: '/notifications',
                name: RouteNames.notifications,
                builder: (context, state) => const NotificationsPage(),
              ),
              GoRoute(
                path: '/help',
                name: RouteNames.help,
                builder: (context, state) => const HelpSupportPage(),
              ),
              GoRoute(
                path: '/faq',
                name: RouteNames.faq,
                builder: (context, state) => const FaqPage(),
              ),
              GoRoute(
                path: '/feedback',
                name: RouteNames.feedback,
                builder: (context, state) => const FeedbackPage(),
              ),
              GoRoute(
                path: '/about',
                name: RouteNames.about,
                builder: (context, state) => const AboutPage(),
              ),
              GoRoute(
                path: '/order-book',
                name: RouteNames.orderBook,
                builder: (context, state) => const OrderBookPage(),
              ),
              GoRoute(
                path: '/limit-order',
                name: RouteNames.limitOrder,
                builder: (context, state) => const LimitOrderPage(),
              ),
              GoRoute(
                path: '/stop-loss',
                name: RouteNames.stopLoss,
                builder: (context, state) => const StopLossPage(),
              ),
              GoRoute(
                path: '/open-orders',
                name: RouteNames.openOrders,
                builder: (context, state) => const OpenOrdersPage(),
              ),
              GoRoute(
                path: '/order-preview',
                name: RouteNames.orderPreview,
                builder: (context, state) => const OrderPreviewPage(),
              ),
              GoRoute(
                path: '/trade-confirmation',
                name: RouteNames.tradeConfirmation,
                builder: (context, state) => const TradeConfirmationPage(),
              ),
              GoRoute(
                path: '/analytics',
                name: RouteNames.portfolioAnalytics,
                builder: (context, state) => const PortfolioAnalyticsPage(),
              ),
              GoRoute(
                path: '/performance',
                name: RouteNames.performanceTimeline,
                builder: (context, state) => const PerformanceTimelinePage(),
              ),
              GoRoute(
                path: '/risk',
                name: RouteNames.riskAnalysis,
                builder: (context, state) => const RiskAnalysisPage(),
              ),
              GoRoute(
                path: '/alerts',
                name: RouteNames.alerts,
                builder: (context, state) => const AlertsPage(),
              ),
              GoRoute(
                path: '/challenges',
                name: RouteNames.challenges,
                builder: (context, state) => const ChallengesPage(),
              ),
              GoRoute(
                path: '/achievements',
                name: RouteNames.achievements,
                builder: (context, state) => const AchievementsPage(),
              ),
              GoRoute(
                path: '/profile',
                name: RouteNames.profile,
                builder: (context, state) => const ProfilePage(),
              ),
              GoRoute(
                path: '/streaks',
                name: RouteNames.tradingStreak,
                builder: (context, state) => const TradingStreakPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class AppScaffoldShell extends StatelessWidget {
  const AppScaffoldShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart_outlined),
            selectedIcon: Icon(Icons.show_chart),
            label: 'Market',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Portfolio',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.bookmark),
            label: 'Watchlist',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'Knowledge Hub',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
