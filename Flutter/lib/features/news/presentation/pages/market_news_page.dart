import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/top_nav_scaffold.dart';

class MarketNewsPage extends StatelessWidget {
  const MarketNewsPage({super.key});

  static final List<Map<String, String>> _news = [
    {
      'id': 'n1',
      'title': 'NIFTY rallies as IT and banks lead gains',
      'source': 'Market Desk',
      'time': '2h ago',
      'summary': 'Broad market strength pushed the benchmark higher, with strong flows into banking and IT.',
    },
    {
      'id': 'n2',
      'title': 'RBI commentary keeps yields steady',
      'source': 'Policy Watch',
      'time': '5h ago',
      'summary': 'Bond yields stayed range-bound after the latest policy remarks, signaling stable rates.',
    },
    {
      'id': 'n3',
      'title': 'Auto sector sees momentum ahead of festive demand',
      'source': 'Sector Pulse',
      'time': '7h ago',
      'summary': 'Retail bookings picked up across major OEMs, pointing to upbeat festive season demand.',
    },
    {
      'id': 'n4',
      'title': 'Energy stocks track global crude move',
      'source': 'Commodities',
      'time': '9h ago',
      'summary': 'Upstream names gained as crude prices ticked higher on inventory surprises.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return TopNavScaffold(
      activeTab: 'marketNews',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _news.map((item) {
          return Card(
            child: ListTile(
              title: Text(item['title'] ?? ''),
              subtitle: Text(item['summary'] ?? ''),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item['source'] ?? ''),
                  const SizedBox(height: 4),
                  Text(item['time'] ?? ''),
                ],
              ),
              onTap: () => context.push('/news/${item["id"]}'),
            ),
          );
        }).toList(),
      ),
    );
  }
}
