import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../core/formatters.dart';
import '../models/cart_item.dart';
import '../viewmodels/cart_viewmodel.dart';
import 'product_image.dart';
import 'quantity_stepper.dart';

/// Baris item keranjang (dipakai di tab Keranjang & halaman Konfirmasi).
class CartItemTile extends StatelessWidget {
  const CartItemTile({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartViewModel>();
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ProductImage(product: item.product, width: 56, height: 56, iconSize: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name, style: AppTextStyles.title.copyWith(fontSize: 14)),
                Text(item.summary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption),
                if (item.note.isNotEmpty)
                  Text('“${item.note}”',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption
                          .copyWith(fontStyle: FontStyle.italic)),
                const SizedBox(height: 4),
                Text(Formatters.rupiah(item.total), style: AppTextStyles.price.copyWith(fontSize: 13)),
              ],
            ),
          ),
          QuantityStepper(
            quantity: item.quantity,
            onAdd: () => cart.increment(item),
            onRemove: () => cart.decrement(item),
          ),
        ],
      ),
    );
  }
}
