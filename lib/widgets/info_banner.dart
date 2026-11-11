import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

class InfoBanner extends StatelessWidget {
  const InfoBanner({
    super.key,
    required this.icon,
    required this.text,
    this.color = AppColors.primary,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppTextStyles.bodyDark.copyWith(fontSize: 12))),
        ],
      ),
    );
  }
}
