import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_routes.dart';
import '../../core/app_text_styles.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../../widgets/app_button.dart';
import '../../widgets/cart_item_tile.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/price_row.dart';

/// Tab Keranjang.
class CartTab extends StatelessWidget {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Keranjang', style: AppTextStyles.heading),
          ),
        ),
        Expanded(
          child: cart.isEmpty
              ? const Center(
                  child: EmptyState(
                    icon: Icons.shopping_bag_outlined,
                    message: 'Keranjangmu masih kosong.\nYuk pilih kopi favoritmu!',
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  children: [
                    ...cart.items.map((item) => CartItemTile(item: item)),
                    const SizedBox(height: 8),
                    PriceRow(label: 'Subtotal', amount: cart.subtotal),
                    PriceRow(label: 'Total', amount: cart.total, isBold: true),
                    const SizedBox(height: 12),
                    AppButton(
                      label: 'Lanjut ke Pembayaran',
                      icon: Icons.arrow_forward,
                      style: AppButtonStyle.primary,
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.checkout),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
