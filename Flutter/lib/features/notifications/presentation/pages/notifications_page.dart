import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _NotificationTile(
            title: 'Price alert: RELIANCE',
            subtitle: 'RELIANCE crossed ₹2,950 today.',
            time: '10m ago',
          ),
          _NotificationTile(
            title: 'Daily summary ready',
            subtitle: 'Tap to review today’s market wrap.',
            time: '2h ago',
          ),
          _NotificationTile(
            title: 'Portfolio update',
            subtitle: 'Your portfolio is up 1.8% this week.',
            time: '1d ago',
          ),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.title,
    required this.subtitle,
    required this.time,
  });

  final String title;
  final String subtitle;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.notifications_outlined),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(time),
      ),
    );
  }
}
