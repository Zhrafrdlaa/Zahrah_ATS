import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../core/formatters.dart';
import '../models/product.dart';
import 'product_image.dart';

/// Kartu produk untuk grid menu.
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAdd,
  });

  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.dark.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ProductImage(product: product, height: 120, width: double.infinity),
                Positioned(
                  top: 8,
                  left: 8,
                  child: _RatingBadge(rating: product.rating),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.title.copyWith(fontSize: 14)),
            const SizedBox(height: 2),
            Text(product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Text(Formatters.rupiah(product.basePrice),
                      style: AppTextStyles.price.copyWith(fontSize: 13)),
                ),
                GestureDetector(
                  onTap: onAdd,
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.add, size: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, size: 11, color: AppColors.primary),
          const SizedBox(width: 2),
          Text('$rating',
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
