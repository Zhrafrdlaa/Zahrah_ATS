import 'package:flutter/material.dart';

import '../app/app_routes.dart';
import '../core/app_colors.dart';
import '../widgets/app_button.dart';

/// Halaman 1: Splash Screen.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF5A3A24), AppColors.dark, Color(0xFF241308)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: FadeTransition(
                  opacity: _controller,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.white12,
                        child: Icon(Icons.local_cafe,
                            size: 40, color: AppColors.primary),
                      ),
                      const SizedBox(height: 20),
                      const Text.rich(
                        TextSpan(
                          text: 'Coffee ',
                          children: [
                            TextSpan(
                                text: 'Point',
                                style: TextStyle(color: AppColors.primary)),
                          ],
                        ),
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      const Text('Pesan Kopi Tanpa Antre',
                          style: TextStyle(fontSize: 15, color: Colors.white70)),
                      const SizedBox(height: 6),
                      const Text('Fresh Brew  •  Pick-up Instan  •  Tanpa Antre',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11, color: Colors.white38)),
                      const SizedBox(height: 48),
                      AppButton(
                        label: 'Mulai',
                        icon: Icons.arrow_forward,
                        style: AppButtonStyle.primary,
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, AppRoutes.login),
                      ),
                      const SizedBox(height: 18),
                      const Text('Menyiapkan biji kopi terbaik...',
                          style: TextStyle(fontSize: 11, color: Colors.white38)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
