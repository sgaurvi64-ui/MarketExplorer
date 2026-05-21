import 'package:flutter/material.dart';
import '../utils/currency_formatter.dart';
import '../../data/models/stock/stock_model.dart';

class StockListTile extends StatelessWidget {
  const StockListTile({
    super.key,
    required this.stock,
    this.onTap,
    this.trailing,
    this.leading,
  });

  final StockModel stock;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final isPositive = stock.change >= 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: leading ??
            CircleAvatar(
              backgroundColor: const Color(0xFFD9F6EA),
              child: Text(stock.symbol.substring(0, 1)),
            ),
        title: Text(stock.symbol),
        subtitle: Text(stock.companyName),
        trailing: trailing ??
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(CurrencyFormatter.format(stock.price)),
                Text(
                  '${isPositive ? '+' : ''}${stock.changePercent.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
