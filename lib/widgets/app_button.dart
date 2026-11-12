import 'package:flutter/material.dart';

import '../core/app_colors.dart';

enum AppButtonStyle { dark, primary, outline }

/// Tombol standar aplikasi (dipakai di seluruh halaman).
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.leading,
    this.isLoading = false,
    this.style = AppButtonStyle.dark,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  /// Widget di sebelah kiri teks 
  final Widget? leading;
  final bool isLoading;
  final AppButtonStyle style;

  @override
  Widget build(BuildContext context) {
    final bg = switch (style) {
      AppButtonStyle.dark => AppColors.dark,
      AppButtonStyle.primary => AppColors.primary,
      AppButtonStyle.outline => Colors.transparent,
    };
    final fg = style == AppButtonStyle.outline ? AppColors.dark : Colors.white;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          disabledBackgroundColor: bg,
          disabledForegroundColor: fg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: style == AppButtonStyle.outline
                ? const BorderSide(color: AppColors.dark)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: fg),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: 10),
                  ],
                  Text(label,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700)),
                  if (icon != null) ...[
                    const SizedBox(width: 8),
                    Icon(icon, size: 18),
                  ],
                ],
              ),
      ),
    );
  }
}