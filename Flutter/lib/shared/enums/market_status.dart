enum MarketStatus {
  open,
  closed,
  preMarket,
  afterHours;

  String get label {
    switch (this) {
      case MarketStatus.open:
        return 'Open';
      case MarketStatus.closed:
        return 'Closed';
      case MarketStatus.preMarket:
        return 'Pre-market';
      case MarketStatus.afterHours:
        return 'After hours';
    }
  }
}
