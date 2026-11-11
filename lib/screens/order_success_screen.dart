import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_routes.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../viewmodels/navigation_viewmodel.dart';
import '../widgets/app_button.dart';

/// Halaman 7: Pesanan Berhasil.
class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final code = context.select<CartViewModel, String?>((c) => c.activeOrderCode);

    return PopScope(
      canPop: false, // Cegah kembali ke halaman pembayaran.
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.5, end: 1),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                      builder: (_, scale, child) =>
                          Transform.scale(scale: scale, child: child),
                      child: const CircleAvatar(
                        radius: 48,
                        backgroundColor: AppColors.primary,
                        child: Icon(Icons.check, size: 52, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Pesanan Berhasil!', style: AppTextStyles.heading),
                    const SizedBox(height: 4),
                    const Text('Pesananmu sedang disiapkan barista',
                        style: AppTextStyles.body),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const Text('NOMOR ANTREAN PICK-UP',
                              style: TextStyle(
                                  fontSize: 10,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary)),
                          const SizedBox(height: 8),
                          Text('#${code ?? '-'}',
                              style: const TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.dark)),
                          const SizedBox(height: 8),
                          const Text('Kedai Senopati  •  Siap ±15 mnt',
                              style: AppTextStyles.caption),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Tunjukkan kode ini ke barista di pick-up counter saat namamu dipanggil.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: 28),
                    AppButton(
                      label: 'Kembali ke Menu',
                      icon: Icons.local_cafe_outlined,
                      onPressed: () {
                        context
                            .read<NavigationViewModel>()
                            .goTo(NavigationViewModel.homeTab);
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.home, (_) => false);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
