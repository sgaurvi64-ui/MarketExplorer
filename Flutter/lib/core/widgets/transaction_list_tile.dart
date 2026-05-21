import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/portfolio/transaction_model.dart';
import '../utils/currency_formatter.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    super.key,
    required this.transaction,
  });

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final isBuy = transaction.type == 'BUY';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              isBuy ? const Color(0xFFD9F6EA) : const Color(0xFFFFE5E5),
          child: Icon(
            isBuy ? Icons.arrow_downward : Icons.arrow_upward,
            color: isBuy ? Colors.green : Colors.red,
          ),
        ),
        title: Text('${transaction.type} ${transaction.symbol}'),
        subtitle: Text(
          '${transaction.quantity} shares - ${DateFormat('dd MMM, hh:mm a').format(transaction.timestamp)}',
        ),
        trailing: Text(CurrencyFormatter.format(transaction.price)),
      ),
    );
  }
}
