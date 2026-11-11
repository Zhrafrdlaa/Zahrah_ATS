import 'package:flutter/material.dart';

import '../core/app_colors.dart';

/// Tema global aplikasi agar tampilan konsisten.
class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.background,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.dark,
          elevation: 0,
          centerTitle: false,
          scrolledUnderElevation: 0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: AppColors.primary.withValues(alpha: 0.15),
        ),
      );
}
