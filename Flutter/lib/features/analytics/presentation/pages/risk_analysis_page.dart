import 'package:flutter/material.dart';

class RiskAnalysisPage extends StatelessWidget {
  const RiskAnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Risk Analysis')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _RiskCard(
            title: 'Portfolio risk score',
            value: 'Moderate',
            detail: 'Volatility is in a healthy range.',
          ),
          _RiskCard(
            title: 'Sector concentration',
            value: 'Banking 38%',
            detail: 'High exposure to a single sector.',
          ),
          _RiskCard(
            title: 'Liquidity',
            value: 'Strong',
            detail: 'Most holdings have high daily volume.',
          ),
        ],
      ),
    );
  }
}

class _RiskCard extends StatelessWidget {
  const _RiskCard({
    required this.title,
    required this.value,
    required this.detail,
  });

  final String title;
  final String value;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(detail),
        trailing: Text(value),
      ),
    );
  }
}
