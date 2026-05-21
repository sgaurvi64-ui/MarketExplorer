import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _HelpTile(
            title: 'Getting started',
            subtitle: 'Learn the basics of paper trading and navigation.',
          ),
          _HelpTile(
            title: 'Trading rules',
            subtitle: 'Understand how orders and portfolio updates work.',
          ),
          _HelpTile(
            title: 'Contact support',
            subtitle: 'Send feedback or report an issue from the app.',
          ),
        ],
      ),
    );
  }
}

class _HelpTile extends StatelessWidget {
  const _HelpTile({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.help_outline),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
