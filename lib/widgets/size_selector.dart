import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../core/formatters.dart';
import '../models/customization.dart';

/// Pemilih ukuran minuman (Regular / Large).
class SizeSelector extends StatelessWidget {
  const SizeSelector({
    super.key,
    required this.basePrice,
    required this.selected,
    required this.onSelected,
  });

  final int basePrice;
  final SizeOption selected;
  final ValueChanged<SizeOption> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: SizeOption.values.map((size) {
        final isActive = size == selected;
        final fg = isActive ? Colors.white : AppColors.dark;
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelected(size),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isActive ? AppColors.dark : AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(size.label,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: fg)),
                      const Spacer(),
                      if (isActive)
                        const Icon(Icons.check_circle,
                            size: 18, color: AppColors.primary),
                    ],
                  ),
                  Text(size.volume,
                      style: AppTextStyles.caption.copyWith(
                          color: isActive ? Colors.white70 : null)),
                  const SizedBox(height: 6),
                  Text(
                    Formatters.rupiah(basePrice + size.extraPrice),
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 12, color: fg),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
