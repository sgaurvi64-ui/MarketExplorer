import '../../shared/enums/market_status.dart';

class MarketClockService {
  const MarketClockService();

  MarketStatus getCurrentStatus() {
    final hour = DateTime.now().hour;
    if (hour >= 9 && hour < 16) {
      return MarketStatus.open;
    }
    if (hour >= 7 && hour < 9) {
      return MarketStatus.preMarket;
    }
    if (hour >= 16 && hour < 20) {
      return MarketStatus.afterHours;
    }
    return MarketStatus.closed;
  }
}
