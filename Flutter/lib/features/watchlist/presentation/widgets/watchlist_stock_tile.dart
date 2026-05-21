import 'package:flutter/material.dart';
import '../../../../core/widgets/stock_list_tile.dart';
import '../../../../data/models/stock/stock_model.dart';

class WatchlistStockTile extends StatelessWidget {
  const WatchlistStockTile({
    super.key,
    required this.stock,
    this.onTap,
    this.onRemove,
  });

  final StockModel stock;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return StockListTile(
      stock: stock,
      onTap: onTap,
      trailing: IconButton(
        onPressed: onRemove,
        icon: const Icon(Icons.bookmark_remove_outlined),
      ),
    );
  }
}
