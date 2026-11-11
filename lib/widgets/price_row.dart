import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../core/formatters.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({
    super.key,
    required this.label,
    required this.amount,
    this.isBold = false,
    this.color,
  });

  final String label;
  final int amount;
  final bool isBold;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final style = (isBold ? AppTextStyles.title : AppTextStyles.bodyDark)
        .copyWith(color: color ?? AppColors.dark);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(Formatters.rupiah(amount), style: style),
        ],
      ),
    );
  }
}
