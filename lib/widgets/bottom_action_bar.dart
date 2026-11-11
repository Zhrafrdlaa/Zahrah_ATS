import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../core/formatters.dart';

/// Bar bawah berisi total harga dan tombol aksi utama.
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    required this.total,
    required this.buttonLabel,
    required this.onPressed,
    this.icon,
    this.totalLabel = 'TOTAL PEMBAYARAN',
  });

  final int total;
  final String buttonLabel;
  final VoidCallback? onPressed;
  final IconData? icon;
  final String totalLabel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.dark.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(totalLabel, style: AppTextStyles.caption),
                Text(Formatters.rupiah(total),
                    style: AppTextStyles.title.copyWith(fontSize: 18)),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: onPressed,
                  icon: Icon(icon ?? Icons.shopping_bag_outlined, size: 18),
                  label: Text(buttonLabel,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
