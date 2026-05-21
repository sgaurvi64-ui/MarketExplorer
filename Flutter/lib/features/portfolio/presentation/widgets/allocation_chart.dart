import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../data/models/portfolio/holding_model.dart';

class AllocationChart extends StatelessWidget {
  const AllocationChart({
    super.key,
    required this.holdings,
  });

  final List<HoldingModel> holdings;

  @override
  Widget build(BuildContext context) {
    if (holdings.isEmpty) {
      return const SizedBox.shrink();
    }

    final totalValue = holdings.fold<double>(
      0,
      (sum, item) => sum + item.marketValue,
    );

    final colors = [
      const Color(0xFF0B6E4F),
      const Color(0xFFF4B860),
      const Color(0xFF5B8CFF),
      const Color(0xFFE96BA8),
      const Color(0xFF7ED957),
      const Color(0xFFBFA8FF),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 36,
              sections: [
                for (int index = 0; index < holdings.length; index++)
                  PieChartSectionData(
                    color: colors[index % colors.length],
                    value: holdings[index].marketValue,
                    title: '',
                    radius: 70,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            for (int index = 0; index < holdings.length; index++)
              _LegendItem(
                color: colors[index % colors.length],
                label: holdings[index].stock.symbol,
                value: CurrencyFormatter.format(holdings[index].marketValue),
                percent: ((holdings[index].marketValue / totalValue) * 100)
                    .toStringAsFixed(1),
              ),
          ],
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
    required this.percent,
  });

  final Color color;
  final String label;
  final String value;
  final String percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(width: 6),
          Text(
            '$percent%',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
