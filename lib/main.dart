import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app_routes.dart';
import 'app/app_theme.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/cart_viewmodel.dart';
import 'viewmodels/menu_viewmodel.dart';
import 'viewmodels/navigation_viewmodel.dart';

void main() => runApp(const CoffeePointApp());

/// Root aplikasi. ViewModel diletakkan di atas MaterialApp sehingga state
/// tetap aman saat layar diputar atau berpindah halaman.
class CoffeePointApp extends StatelessWidget {
  const CoffeePointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => MenuViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),
      ],
      child: MaterialApp(
        title: 'Coffee Point',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
