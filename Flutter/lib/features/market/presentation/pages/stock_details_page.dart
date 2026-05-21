import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../data/models/market/market_insight_model.dart';
import '../../../../data/models/stock/stock_model.dart';
import '../../../portfolio/presentation/providers/portfolio_provider.dart';
import '../providers/market_provider.dart';
import '../widgets/buy_sell_bottom_sheet.dart';

class StockDetailsPage extends ConsumerWidget {
  const StockDetailsPage({super.key, required this.symbol});

  final String symbol;

  Future<void> _showTradeSheet(
    BuildContext context,
    WidgetRef ref, {
    required String action,
    required StockModel stock,
  }) async {
    final controller = TextEditingController(text: '1');
    String? errorText;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return BuySellBottomSheet(
              stock: stock,
              actionLabel: action,
              controller: controller,
              errorText: errorText,
              onSubmit: () async {
                final quantity = int.tryParse(controller.text) ?? 0;
                if (quantity <= 0) {
                  setModalState(() {
                    errorText = 'Enter a valid quantity.';
                  });
                  return;
                }

                try {
                  if (action == 'Buy') {
                    await ref
                        .read(portfolioActionsProvider)
                        .buy(symbol, quantity);
                  } else {
                    await ref
                        .read(portfolioActionsProvider)
                        .sell(symbol, quantity);
                  }
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '$action order placed for $quantity shares of ${stock.symbol}',
                        ),
                      ),
                    );
                  }
                } catch (error) {
                  setModalState(() {
                    errorText = error.toString().replaceFirst('Exception: ', '');
                  });
                }
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stockAsync = ref.watch(stockDetailsProvider(symbol));
    final insightAsync = ref.watch(stockInsightProvider(symbol));
    final insightLongAsync = ref.watch(stockInsightLongProvider(symbol));

    return Scaffold(
      appBar: AppBar(title: Text(symbol)),
      body: stockAsync.when(
        data: (stock) {
          final isPositive = stock.change >= 0;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stock.companyName,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(stock.sector),
                      const SizedBox(height: 16),
                      Text(
                        CurrencyFormatter.format(stock.price),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${isPositive ? '+' : ''}${stock.change.toStringAsFixed(2)} (${stock.changePercent.toStringAsFixed(2)}%)',
                        style: TextStyle(
                          color: isPositive ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              insightAsync.when(
                data: (insight) => _InsightCard(
                  insight: insight,
                  title: 'Short-term insight',
                  subtitle: '10-day horizon, 2% move target',
                ),
                loading: () => const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: AppLoader(message: 'Loading AI insight'),
                  ),
                ),
                error: (error, stackTrace) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 16),
              insightLongAsync.when(
                data: (insight) => _InsightCard(
                  insight: insight,
                  title: 'Long-term insight',
                  subtitle: '30-day horizon, 5% move target',
                ),
                loading: () => const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: AppLoader(message: 'Loading long-term insight'),
                  ),
                ),
                error: (error, stackTrace) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 220,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            color: const Color(0xFF0B6E4F),
                            barWidth: 3,
                            dotData: const FlDotData(show: false),
                            spots: stock.chartPoints
                                .asMap()
                                .entries
                                .map((entry) => FlSpot(
                                      entry.key.toDouble(),
                                      entry.value,
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(stock.description),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          _MetricChip(
                            label: 'High',
                            value: stock.dayHigh.toStringAsFixed(2),
                          ),
                          _MetricChip(
                            label: 'Low',
                            value: stock.dayLow.toStringAsFixed(2),
                          ),
                          _MetricChip(
                            label: 'Range',
                            value:
                                '${stock.dayLow.toStringAsFixed(2)} - ${stock.dayHigh.toStringAsFixed(2)}',
                          ),
                          _MetricChip(
                            label: 'Volume',
                            value: stock.volume.toString(),
                          ),
                          _MetricChip(
                            label: 'Change %',
                            value: '${stock.changePercent.toStringAsFixed(2)}%',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const AppLoader(message: 'Loading stock details'),
        error: (error, _) => AppErrorView(message: error.toString()),
      ),
      bottomNavigationBar: stockAsync.whenOrNull(
        data: (stock) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showTradeSheet(
                    context,
                    ref,
                    action: 'Sell',
                    stock: stock,
                  ),
                  child: const Text('Sell'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () => _showTradeSheet(
                    context,
                    ref,
                    action: 'Buy',
                    stock: stock,
                  ),
                  child: const Text('Buy'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({
    required this.insight,
    required this.title,
    required this.subtitle,
  });

  final MarketInsightModel insight;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final predictionColor = switch (insight.prediction.toUpperCase()) {
      'UP' => Colors.green,
      'DOWN' => Colors.red,
      _ => const Color(0xFFB78103),
    };

    final confidencePercent = (insight.confidence * 100).clamp(0, 100);
    final riskPercent = (insight.riskScore * 100).clamp(0, 100);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.insights_outlined),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(subtitle),
            const SizedBox(height: 12),
            Text(
              'Prediction: ${insight.prediction}',
              style: TextStyle(
                color: predictionColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            _MetricBar(
              label: 'Confidence',
              value: insight.confidence,
              color: predictionColor,
            ),
            const SizedBox(height: 8),
            _MetricBar(
              label: 'Risk',
              value: insight.riskScore,
              color: Colors.orange,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _MetricChip(
                    label: 'Confidence',
                    value: '${confidencePercent.toStringAsFixed(0)}%',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricChip(
                    label: 'Risk score',
                    value: '${riskPercent.toStringAsFixed(0)}%',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              insight.source == 'rule-based-engine' ||
                      insight.source == 'flutter-fallback'
                  ? 'Using fallback insight logic for now. You can switch to a trained model later without changing the app UI.'
                  : 'Using a trained Django-served insight model.',
            ),
            const SizedBox(height: 8),
            if (insight.confidence < 0.6)
              Text(
                'Low confidence signal. Use this as guidance, not a guarantee.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }
}

class _MetricBar extends StatelessWidget {
  const _MetricBar({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final percent = (value * 100).clamp(0, 100);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label ${percent.toStringAsFixed(0)}%'),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: (percent / 100).toDouble(),
            backgroundColor: const Color(0xFFF0F4F8),
            color: color,
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
