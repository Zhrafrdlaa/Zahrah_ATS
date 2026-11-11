import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, this.subtitle, this.trailing});

  final String title;
  final String? subtitle;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.title),
              if (subtitle != null) Text(subtitle!, style: AppTextStyles.caption),
            ],
          ),
        ),
        if (trailing != null)
          Text(trailing!,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary)),
      ],
    );
  }
}
