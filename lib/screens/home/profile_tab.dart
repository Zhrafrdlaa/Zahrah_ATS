import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_routes.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/menu_viewmodel.dart';
import '../../viewmodels/navigation_viewmodel.dart';
import '../../widgets/app_button.dart';

/// Tab Profil.
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthViewModel>().user;
    final favoriteCount = context.watch<MenuViewModel>().favoriteCount;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 42,
                backgroundColor: AppColors.surface,
                child: Icon(Icons.person, size: 44, color: AppColors.dark),
              ),
              const SizedBox(height: 14),
              Text(user?.name ?? 'Tamu', style: AppTextStyles.heading),
              Text(user?.email ?? '-', style: AppTextStyles.body),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.favorite, color: AppColors.primary),
                    const SizedBox(width: 12),
                    const Expanded(
                        child: Text('Menu favorit', style: AppTextStyles.bodyDark)),
                    Text('$favoriteCount', style: AppTextStyles.title),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Keluar',
                icon: Icons.logout,
                style: AppButtonStyle.outline,
                onPressed: () {
                  context.read<AuthViewModel>().logout();
                  context.read<NavigationViewModel>().goTo(NavigationViewModel.homeTab);
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.login, (_) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
