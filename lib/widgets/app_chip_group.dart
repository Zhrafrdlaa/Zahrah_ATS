import 'package:flutter/material.dart';

import '../core/app_colors.dart';

/// Grup chip pilihan tunggal yang generik (kategori, manis, es, dll).
class AppChipGroup<T> extends StatelessWidget {
  const AppChipGroup({
    super.key,
    required this.options,
    required this.selected,
    required this.labelOf,
    required this.onSelected,
    this.activeColor = AppColors.dark,
  });

  final List<T> options;
  final T selected;
  final String Function(T) labelOf;
  final ValueChanged<T> onSelected;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isActive = option == selected;
        return GestureDetector(
          onTap: () => onSelected(option),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isActive ? activeColor : AppColors.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              labelOf(option),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : AppColors.dark,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
