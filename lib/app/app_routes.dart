import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/checkout_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/order_success_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/qris_payment_screen.dart';
import '../screens/splash_screen.dart';

/// Daftar rute terpusat agar navigasi mudah dikelola.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String productDetail = '/product-detail';
  static const String checkout = '/checkout';
  static const String qris = '/qris';
  static const String success = '/success';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final Widget page = switch (settings.name) {
      login => const LoginScreen(),
      home => const HomeScreen(),
      productDetail => ProductDetailScreen(
          product: settings.arguments is Product
              ? settings.arguments as Product
              : null,
        ),
      checkout => const CheckoutScreen(),
      qris => const QrisPaymentScreen(),
      success => const OrderSuccessScreen(),
      _ => const SplashScreen(),
    };
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}
