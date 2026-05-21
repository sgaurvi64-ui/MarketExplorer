import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../providers/portfolio_provider.dart';
import '../widgets/transaction_tile.dart';

class TransactionHistoryPage extends ConsumerWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Transaction History')),
      body: transactionsAsync.when(
        data: (transactions) {
          if (transactions.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('No transactions yet. Your order history will show here.'),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: transactions
                .map((transaction) => TransactionTile(transaction: transaction))
                .toList(),
          );
        },
        loading: () => const AppLoader(message: 'Loading transaction history'),
        error: (error, _) => AppErrorView(message: error.toString()),
      ),
    );
  }
}
