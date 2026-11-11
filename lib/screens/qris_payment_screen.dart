import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_routes.dart';
import '../core/app_colors.dart';
import '../core/app_exceptions.dart';
import '../core/app_text_styles.dart';
import '../core/formatters.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../widgets/app_button.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/info_banner.dart';
import '../widgets/qris_painter.dart';

/// Halaman 6: Pembayaran QRIS dengan hitung mundur.
class QrisPaymentScreen extends StatefulWidget {
  const QrisPaymentScreen({super.key});

  @override
  State<QrisPaymentScreen> createState() => _QrisPaymentScreenState();
}

class _QrisPaymentScreenState extends State<QrisPaymentScreen> {
  static const int _durationSeconds = 15 * 60;

  Timer? _timer;
  int _remaining = _durationSeconds;
  int _seed = DateTime.now().millisecondsSinceEpoch;

  bool get _expired => _remaining <= 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining <= 1) {
        timer.cancel();
      }
      setState(() => _remaining = (_remaining - 1).clamp(0, _durationSeconds).toInt());
    });
  }

  void _regenerate() {
    setState(() {
      _remaining = _durationSeconds;
      _seed = DateTime.now().millisecondsSinceEpoch;
    });
    _startTimer();
  }

  void _confirmPaid() {
    try {
      context.read<CartViewModel>().placeOrder();
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.success, ModalRoute.withName(AppRoutes.home));
    } on EmptyCartException catch (e) {
      AppSnackBar.show(context, e.message, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = context.watch<CartViewModel>().total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran Qris', style: TextStyle(fontSize: 16)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                const Text(
                  'Tunjukkan atau pindai kode QR untuk menyelesaikan pesanan kopimu',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      const Text('QRIS  •  Standar Nasional', style: AppTextStyles.label),
                      const SizedBox(height: 4),
                      const Text('GoPay • OVO • ShopeePay • DANA • BCA',
                          style: AppTextStyles.caption),
                      const SizedBox(height: 16),
                      AspectRatio(
                        aspectRatio: 1,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _expired ? 0.2 : 1,
                          child: CustomPaint(painter: QrisPainter(seed: _seed)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text('TOTAL PEMBAYARAN', style: AppTextStyles.caption),
                      Text(Formatters.rupiah(total),
                          style: AppTextStyles.heading),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (_expired)
                  const InfoBanner(
                    icon: Icons.error_outline,
                    text: 'Kode QR kedaluwarsa. Buat kode baru untuk melanjutkan.',
                    color: AppColors.error,
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Bayar dalam ${Formatters.countdown(_remaining)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, color: AppColors.primary),
                    ),
                  ),
                const SizedBox(height: 20),
                if (_expired)
                  AppButton(
                    label: 'Buat Kode QR Baru',
                    icon: Icons.refresh,
                    onPressed: _regenerate,
                  )
                else
                  AppButton(
                    label: 'Saya Sudah Bayar',
                    icon: Icons.check_circle_outline,
                    onPressed: _confirmPaid,
                  ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ganti Metode Pembayaran >',
                      style: TextStyle(color: AppColors.primary)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
