import 'package:flutter/material.dart';

import '../models/product.dart';

/// Foto produk. Memakai gambar dari internet, dan otomatis menampilkan
/// placeholder (gradient + ikon) saat loading, gagal dimuat, atau tanpa URL.
class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.product,
    this.width,
    this.height,
    this.iconSize = 44,
    this.borderRadius = const BorderRadius.all(Radius.circular(14)),
  });

  final Product product;
  final double? width;
  final double? height;
  final double iconSize;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final url = product.imageUrl;
    if (url == null) return _placeholder();

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: width,
        height: height,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) =>
              progress == null ? child : _placeholder(isLoading: true),
          errorBuilder: (context, error, stackTrace) => _placeholder(),
        ),
      ),
    );
  }

  Widget _placeholder({bool isLoading = false}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [product.tint.withValues(alpha: 0.55), product.tint],
        ),
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : Icon(product.icon, size: iconSize, color: Colors.white),
      ),
    );
  }
}
