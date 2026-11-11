import 'package:flutter/foundation.dart';

/// Menyimpan tab aktif pada Home agar bisa diganti dari halaman mana pun
/// (misalnya tombol "LIHAT" pada snackbar untuk membuka keranjang).
class NavigationViewModel extends ChangeNotifier {
  static const int homeTab = 0;
  static const int cartTab = 1;
  static const int profileTab = 2;

  int _tabIndex = homeTab;
  int get tabIndex => _tabIndex;

  void goTo(int index) {
    if (_tabIndex == index) return;
    _tabIndex = index;
    notifyListeners();
  }
}
