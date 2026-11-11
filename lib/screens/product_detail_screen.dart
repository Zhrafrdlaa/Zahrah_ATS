import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../core/formatters.dart';
import '../models/cart_item.dart';
import '../models/customization.dart';
import '../models/product.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../viewmodels/menu_viewmodel.dart';
import '../viewmodels/navigation_viewmodel.dart';
import '../widgets/app_chip_group.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/info_banner.dart';
import '../widgets/product_image.dart';
import '../widgets/size_selector.dart';

/// Halaman 4: Detail Produk dengan kustomisasi pesanan.
class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product? product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  SizeOption _size = SizeOption.regular;
  Sweetness _sweetness = Sweetness.normal;
  IceLevel _ice = IceLevel.normal;
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  int _price(Product product) =>
      product.basePrice + (product.isDrink ? _size.extraPrice : 0);

  void _addToCart(Product product) {
    context.read<CartViewModel>().addItem(
          CartItem(
            product: product,
            size: _size,
            sweetness: _sweetness,
            ice: _ice,
            note: _noteController.text.trim(),
          ),
        );
    final nav = context.read<NavigationViewModel>();
    AppSnackBar.show(
      context,
      '${product.name} ditambahkan ke keranjang',
      actionLabel: 'LIHAT',
      onAction: () => nav.goTo(NavigationViewModel.cartTab),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    // Penanganan error: argumen produk tidak valid.
    if (product == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Produk tidak ditemukan.')),
      );
    }

    final menu = context.watch<MenuViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail', style: TextStyle(fontSize: 16)),
        actions: [
          IconButton(
            icon: Icon(
              menu.isFavorite(product.id) ? Icons.favorite : Icons.favorite_border,
              color: AppColors.primary,
            ),
            onPressed: () => context.read<MenuViewModel>().toggleFavorite(product.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImage(
                  product: product,
                  height: 200,
                  width: double.infinity,
                  iconSize: 72,
                  borderRadius: BorderRadius.circular(24),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _Tag(product.category.label),
                    const SizedBox(width: 8),
                    const Icon(Icons.star, size: 14, color: AppColors.primary),
                    Text(' ${product.rating} (${product.reviewCount})',
                        style: AppTextStyles.caption),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: Text(product.name, style: AppTextStyles.heading)),
                    Text(Formatters.rupiah(product.basePrice),
                        style: AppTextStyles.price.copyWith(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(product.description, style: AppTextStyles.body),
                if (product.isDrink) ...[
                  const SizedBox(height: 20),
                  const Text('Pilih Ukuran', style: AppTextStyles.title),
                  const SizedBox(height: 10),
                  SizeSelector(
                    basePrice: product.basePrice,
                    selected: _size,
                    onSelected: (v) => setState(() => _size = v),
                  ),
                  const SizedBox(height: 20),
                  const Text('Tingkat Manis', style: AppTextStyles.title),
                  const SizedBox(height: 10),
                  AppChipGroup<Sweetness>(
                    options: Sweetness.values,
                    selected: _sweetness,
                    labelOf: (v) => v.chipLabel,
                    onSelected: (v) => setState(() => _sweetness = v),
                  ),
                  const SizedBox(height: 20),
                  const Text('Penyajian & Es', style: AppTextStyles.title),
                  const SizedBox(height: 10),
                  AppChipGroup<IceLevel>(
                    options: IceLevel.values,
                    selected: _ice,
                    labelOf: (v) => v.label,
                    onSelected: (v) => setState(() => _ice = v),
                  ),
                ],
                const SizedBox(height: 20),
                const Text('Catatan untuk Barista', style: AppTextStyles.title),
                const SizedBox(height: 10),
                TextField(
                  controller: _noteController,
                  maxLength: 120,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Contoh: sedikit kurangi manisnya',
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const InfoBanner(
                  icon: Icons.local_florist_outlined,
                  text: 'Racikan artisan segar, diproses sesuai pesananmu.',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        total: _price(product),
        buttonLabel: 'Keranjang',
        onPressed: () => _addToCart(product),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary)),
    );
  }
}
