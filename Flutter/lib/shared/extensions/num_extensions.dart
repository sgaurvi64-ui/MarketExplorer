extension NumExtensions on num {
  String get asPrice => toStringAsFixed(2);
  String get asCompactPercent => '${toStringAsFixed(2)}%';
  bool get isPositiveOrZero => this >= 0;
}
