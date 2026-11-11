import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_routes.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/dummy_data.dart';
import '../../models/product.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../../viewmodels/menu_viewmodel.dart';
import '../../viewmodels/navigation_viewmodel.dart';
import '../../widgets/app_chip_group.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/info_banner.dart';
import '../../widgets/product_card.dart';
import '../../widgets/promo_banner.dart';
import '../../widgets/section_title.dart';

/// Tab Beranda & Menu: pencarian, filter kategori, grid produk.
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final TextEditingController _searchController =
      TextEditingController(text: context.read<MenuViewModel>().query);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _quickAdd(Product product) {
    context.read<CartViewModel>().addQuick(product);
    final nav = context.read<NavigationViewModel>();
    AppSnackBar.show(
      context,
      '${product.name} ditambahkan ke keranjang',
      actionLabel: 'LIHAT',
      onAction: () => nav.goTo(NavigationViewModel.cartTab),
    );
  }

  void _openDetail(Product product) =>
      Navigator.pushNamed(context, AppRoutes.productDetail, arguments: product);

  @override
  Widget build(BuildContext context) {
    final menu = context.watch<MenuViewModel>();
    final activeOrder = context.select<CartViewModel, String?>((c) => c.activeOrderCode);
    final name = context.select<AuthViewModel, String>((a) => a.firstName);
    final products = menu.products;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Halo, $name! 👋', style: AppTextStyles.heading),
                        const Text('Mau minum kopi apa hari ini?',
                            style: AppTextStyles.body),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    backgroundColor: AppColors.surface,
                    child: Icon(Icons.notifications_none, color: AppColors.dark),
                  ),
                ],
              ),
              if (activeOrder != null) ...[
                const SizedBox(height: 16),
                InfoBanner(
                  icon: Icons.timer_outlined,
                  text: 'Antrean sedang berjalan  •  Order #$activeOrder',
                ),
              ],
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                onChanged: context.read<MenuViewModel>().setQuery,
                decoration: InputDecoration(
                  hintText: 'Cari kopi, minuman, atau snack...',
                  prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                  suffixIcon: menu.query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            context.read<MenuViewModel>().setQuery('');
                          },
                        ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              AppChipGroup<ProductCategory?>(
                options: [null, ...ProductCategory.values],
                selected: menu.category,
                labelOf: (c) => c?.label ?? 'Semua',
                onSelected: context.read<MenuViewModel>().setCategory,
                activeColor: AppColors.primary,
              ),
              const SizedBox(height: 20),
              SectionTitle(
                title: 'Pilihan Terfavorit',
                subtitle: 'Diseduh segar khusus untukmu',
                trailing: '${products.length} ITEM',
              ),
              const SizedBox(height: 12),
            ]),
          ),
        ),
        if (products.isEmpty)
          const SliverToBoxAdapter(
            child: EmptyState(
              icon: Icons.search_off,
              message: 'Menu yang kamu cari tidak ditemukan.\nCoba kata kunci lain.',
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 230,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: 268,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: products.length,
                (context, i) => ProductCard(
                  product: products[i],
                  onTap: () => _openDetail(products[i]),
                  onAdd: () => _quickAdd(products[i]),
                ),
              ),
            ),
          ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverToBoxAdapter(
            child: PromoBanner(onPressed: () => _quickAdd(DummyData.products.first)),
          ),
        ),
      ],
    );
  }
}
