import 'package:flutter/material.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../data/models/leaderboard/leaderboard_user_model.dart';

class LeaderboardTile extends StatelessWidget {
  const LeaderboardTile({
    super.key,
    required this.user,
  });

  final LeaderboardUserModel user;

  @override
  Widget build(BuildContext context) {
    final isPositive = user.returnsPercent >= 0;
    return Card(
      color: user.isCurrentUser ? const Color(0xFFEAF8F1) : Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: user.rank == 1
              ? const Color(0xFFF4B860)
              : const Color(0xFFE8EEF3),
          child: Text('${user.rank}'),
        ),
        title: Text(user.name),
        subtitle: Text(
          user.isCurrentUser
              ? 'Your current portfolio ${CurrencyFormatter.format(user.totalValue)}'
              : 'Portfolio ${CurrencyFormatter.format(user.totalValue)}',
        ),
        trailing: Text(
          '${isPositive ? '+' : ''}${user.returnsPercent.toStringAsFixed(1)}%',
          style: TextStyle(
            color: isPositive ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
