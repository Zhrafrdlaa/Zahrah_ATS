import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context,
    String message, {
    bool isError = false,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: isError ? AppColors.error : AppColors.dark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          action: (actionLabel != null && onAction != null)
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: AppColors.primary,
                  onPressed: onAction,
                )
              : null,
        ),
      );
  }
}
