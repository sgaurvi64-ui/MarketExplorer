import 'package:flutter/material.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Challenges & Missions')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _ChallengeCard(
            title: 'Grow ₹10k to ₹20k',
            subtitle: 'Complete within 30 days',
            status: 'In progress',
          ),
          _ChallengeCard(
            title: '5 trades streak',
            subtitle: 'Complete 5 trades in a row',
            status: 'Unlocked',
          ),
          _ChallengeCard(
            title: 'Daily profit goal',
            subtitle: 'End the day with +₹500',
            status: 'Available',
          ),
        ],
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({
    required this.title,
    required this.subtitle,
    required this.status,
  });

  final String title;
  final String subtitle;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(status),
      ),
    );
  }
}
