import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle heading = TextStyle(
      fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.dark);
  static const TextStyle title = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.dark);
  static const TextStyle body =
      TextStyle(fontSize: 13, color: AppColors.textMuted, height: 1.4);
  static const TextStyle bodyDark =
      TextStyle(fontSize: 13, color: AppColors.dark, height: 1.4);
  static const TextStyle caption =
      TextStyle(fontSize: 11, color: AppColors.textMuted);
  static const TextStyle label = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.dark);
  static const TextStyle price = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primary);
}
