import 'package:flutter/material.dart';

import '../core/app_colors.dart';

/// Banner gelap "Pesan Ulang Kopi Favorit".
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('LANGGANAN PAGI',
                    style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary)),
                const SizedBox(height: 4),
                const Text('Pesan Ulang Kopi Favorit?',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: Colors.white)),
                const SizedBox(height: 4),
                const Text('Caffè Latte Oat Milk hangat siap diambil pukul 09:55.',
                    style: TextStyle(fontSize: 12, color: Colors.white70)),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: onPressed,
                  icon: const Icon(Icons.bolt, size: 16),
                  label: const Text('Pesan Langsung'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white12,
            child: Icon(Icons.coffee_maker, color: AppColors.primary, size: 30),
          ),
        ],
      ),
    );
  }
}
