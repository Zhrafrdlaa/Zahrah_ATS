import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_routes.dart';
import '../core/app_colors.dart';
import '../core/app_exceptions.dart';
import '../core/app_text_styles.dart';
import '../core/formatters.dart';
import '../models/customization.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/empty_state.dart';
import '../widgets/pickup_time_sheet.dart';
import '../widgets/price_row.dart';

/// Halaman 5: Konfirmasi Pembayaran.
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  void _confirm(BuildContext context, CartViewModel cart) {
    if (cart.isEmpty) {
      AppSnackBar.show(context, 'Keranjang masih kosong.', isError: true);
      return;
    }
    if (cart.paymentMethod == PaymentMethod.qris) {
      Navigator.pushNamed(context, AppRoutes.qris);
      return;
    }
    try {
      cart.placeOrder();
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.success, ModalRoute.withName(AppRoutes.home));
    } on EmptyCartException catch (e) {
      AppSnackBar.show(context, e.message, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Pembayaran', style: TextStyle(fontSize: 16)),
      ),
      body: cart.isEmpty
          ? const Center(
              child: EmptyState(
                icon: Icons.shopping_bag_outlined,
                message: 'Tidak ada pesanan.\nKembali ke menu untuk memilih kopi.',
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _InfoCard(
                        icon: Icons.storefront_outlined,
                        caption: 'LOKASI PENGAMBILAN',
                        title: 'Kedai Senopati, Jakarta Selatan',
                      ),
                      const SizedBox(height: 10),
                      _InfoCard(
                        icon: Icons.schedule,
                        caption: 'PICK-UP DI GERAI (TANPA ANTRE)',
                        title:
                            '${cart.pickupLabel} (${Formatters.time(cart.pickupTime)})',
                        actionLabel: 'Ubah',
                        onAction: () => PickupTimeSheet.show(context),
                      ),
                      const SizedBox(height: 20),
                      Text('Detail Pesanan  •  ${cart.totalQuantity} Menu',
                          style: AppTextStyles.title),
                      const SizedBox(height: 10),
                      ...cart.items.map((item) => CartItemTile(item: item)),
                      const SizedBox(height: 8),
                      _CouponTile(
                        active: cart.couponActive,
                        onTap: context.read<CartViewModel>().toggleCoupon,
                      ),
                      const SizedBox(height: 20),
                      const Text('Rincian Pembayaran', style: AppTextStyles.title),
                      const SizedBox(height: 8),
                      PriceRow(label: 'Subtotal Produk', amount: cart.subtotal),
                      PriceRow(label: 'Biaya Layanan & Pengemasan', amount: cart.fee),
                      if (cart.discount > 0)
                        PriceRow(
                          label: 'Diskon Promo Pagi',
                          amount: -cart.discount,
                          color: AppColors.primary,
                        ),
                      const Divider(),
                      PriceRow(label: 'Total Pembayaran', amount: cart.total, isBold: true),
                      const SizedBox(height: 20),
                      const Text('Metode Pembayaran', style: AppTextStyles.title),
                      const SizedBox(height: 10),
                      ...PaymentMethod.values.map(
                        (method) => _PaymentOption(
                          method: method,
                          selected: cart.paymentMethod == method,
                          onTap: () =>
                              context.read<CartViewModel>().setPaymentMethod(method),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: BottomActionBar(
        total: cart.total,
        totalLabel: 'TOTAL TAGIHAN',
        buttonLabel: 'Konfirmasi & Bayar Sekarang',
        icon: Icons.arrow_forward,
        onPressed: cart.isEmpty ? null : () => _confirm(context, cart),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.caption,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String caption;
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(caption, style: AppTextStyles.caption.copyWith(fontSize: 10)),
                Text(title, style: AppTextStyles.title.copyWith(fontSize: 14)),
              ],
            ),
          ),
          if (actionLabel != null)
            TextButton(onPressed: onAction, child: Text(actionLabel!)),
        ],
      ),
    );
  }
}

class _CouponTile extends StatelessWidget {
  const _CouponTile({required this.active, required this.onTap});

  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.local_offer_outlined, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                active
                    ? 'Kupon "SARAPANHEMAT" Aktif — hemat ${Formatters.rupiah(CartViewModel.couponDiscount)}'
                    : 'Kupon "SARAPANHEMAT" dinonaktifkan. Ketuk untuk memakai.',
                style: AppTextStyles.bodyDark.copyWith(fontSize: 12),
              ),
            ),
            Icon(active ? Icons.check_circle : Icons.circle_outlined,
                color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  const _PaymentOption({
    required this.method,
    required this.selected,
    required this.onTap,
  });

  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withValues(alpha: 0.08) : AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: selected ? AppColors.primary : Colors.transparent, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(method == PaymentMethod.qris ? Icons.qr_code_2 : Icons.payments_outlined,
                color: AppColors.dark),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(method.label, style: AppTextStyles.title.copyWith(fontSize: 13)),
                  Text(method.description, style: AppTextStyles.caption),
                ],
              ),
            ),
            Icon(selected ? Icons.check_circle : Icons.circle_outlined,
                color: selected ? AppColors.primary : AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
