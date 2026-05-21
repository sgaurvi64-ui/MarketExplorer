import 'package:flutter/material.dart';
import '../../../../core/widgets/transaction_list_tile.dart';
import '../../../../data/models/portfolio/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
  });

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return TransactionListTile(transaction: transaction);
  }
}
