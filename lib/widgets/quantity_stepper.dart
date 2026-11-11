import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  Widget _button(IconData icon, VoidCallback onTap, Color bg, Color fg) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: CircleAvatar(
        radius: 13,
        backgroundColor: bg,
        child: Icon(icon, size: 16, color: fg),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _button(quantity > 1 ? Icons.remove : Icons.delete_outline, onRemove,
            AppColors.surface, AppColors.dark),
        SizedBox(
          width: 30,
          child: Text('$quantity',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
        _button(Icons.add, onAdd, AppColors.dark, Colors.white),
      ],
    );
  }
}
