import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/cart_viewmodel.dart';
import '../../viewmodels/navigation_viewmodel.dart';
import 'cart_tab.dart';
import 'home_tab.dart';
import 'profile_tab.dart';

/// Halaman 3: kerangka utama dengan Bottom Navigation (Beranda, Keranjang, Profil).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Widget> _tabs = [HomeTab(), CartTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationViewModel>();
    final totalQuantity =
        context.select<CartViewModel, int>((cart) => cart.totalQuantity);

    return Scaffold(
      // IndexedStack menjaga state tiap tab (scroll, teks pencarian, dll).
      body: SafeArea(child: IndexedStack(index: nav.tabIndex, children: _tabs)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: nav.tabIndex,
        onDestinationSelected: nav.goTo,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.local_cafe_outlined),
            selectedIcon: Icon(Icons.local_cafe),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: totalQuantity > 0,
              label: Text('$totalQuantity'),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            selectedIcon: const Icon(Icons.shopping_bag),
            label: 'Keranjang',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
