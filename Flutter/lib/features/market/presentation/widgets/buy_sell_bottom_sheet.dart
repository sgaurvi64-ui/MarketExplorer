import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/validators.dart';
import '../../../../data/models/stock/stock_model.dart';

class BuySellBottomSheet extends StatelessWidget {
  const BuySellBottomSheet({
    super.key,
    required this.stock,
    required this.actionLabel,
    required this.controller,
    required this.onSubmit,
    this.errorText,
    this.isSubmitting = false,
  });

  final StockModel stock;
  final String actionLabel;
  final TextEditingController controller;
  final Future<void> Function() onSubmit;
  final String? errorText;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    final isBuy = actionLabel.toLowerCase() == 'buy';
    final estimatedQuantity = int.tryParse(controller.text) ?? 0;
    final estimatedValue = estimatedQuantity * stock.price;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          20 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                      isBuy ? AppColors.cardTint : const Color(0xFFFFE5E5),
                  child: Icon(
                    isBuy ? Icons.add_chart : Icons.show_chart,
                    color: isBuy ? AppColors.primary : Colors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$actionLabel ${stock.symbol}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        stock.companyName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _InfoChip(
                    label: 'Live price',
                    value: CurrencyFormatter.format(stock.price),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InfoChip(
                    label: 'Estimated value',
                    value: CurrencyFormatter.format(estimatedValue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
                helperText: 'Paper trade only. No real money involved.',
                errorText: errorText,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF7FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.softBorder),
              ),
              child: Text(
                isBuy
                    ? 'This will add shares to your simulated portfolio and reduce available cash.'
                    : 'This will reduce your holdings and credit the sale proceeds to your simulated cash balance.',
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: isSubmitting
                    ? null
                    : () async {
                        final validationError = Validators.requiredField(
                              controller.text,
                              fieldName: 'Quantity',
                            ) ??
                            Validators.quantity(controller.text);
                        if (validationError != null) {
                          return;
                        }
                        await onSubmit();
                      },
                child: Text(
                  isSubmitting ? 'Processing...' : '$actionLabel Now',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.softBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
