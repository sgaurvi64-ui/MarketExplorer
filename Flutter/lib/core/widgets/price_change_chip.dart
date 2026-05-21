import 'package:flutter/material.dart';

class PriceChangeChip extends StatelessWidget {
  const PriceChangeChip({super.key, required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    final isPositive = value >= 0;
    return Chip(
      label: Text('${isPositive ? '+' : ''}${value.toStringAsFixed(2)}%'),
      backgroundColor: isPositive
          ? const Color(0xFFD9F6EA)
          : const Color(0xFFFFE5E5),
      labelStyle: TextStyle(
        color: isPositive ? Colors.green : Colors.red,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
