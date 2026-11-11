import 'package:flutter/foundation.dart';

import '../core/app_exceptions.dart';
import '../core/formatters.dart';
import '../models/cart_item.dart';
import '../models/customization.dart';
import '../models/product.dart';

/// Mengelola keranjang, kupon, waktu ambil, pembayaran, dan nomor antrean.
class CartViewModel extends ChangeNotifier {
  static const int serviceFee = 2000;
  static const int couponDiscount = 5000;

  final List<CartItem> _items = [];
  bool _couponActive = true;
  PaymentMethod _paymentMethod = PaymentMethod.qris;
  DateTime _pickupTime = DateTime.now().add(const Duration(minutes: 15));
  String _pickupLabel = 'Secepatnya';
  String? _activeOrderCode;
  int _orderCounter = 41;

  // ---- Getters ----
  List<CartItem> get items => List.unmodifiable(_items);
  bool get isEmpty => _items.isEmpty;
  bool get couponActive => _couponActive;
  PaymentMethod get paymentMethod => _paymentMethod;
  DateTime get pickupTime => _pickupTime;
  String get pickupLabel => _pickupLabel;
  String? get activeOrderCode => _activeOrderCode;

  int get totalQuantity => _items.fold(0, (sum, i) => sum + i.quantity);
  int get subtotal => _items.fold(0, (sum, i) => sum + i.total);
  int get discount => (_couponActive && _items.isNotEmpty) ? couponDiscount : 0;
  int get fee => _items.isEmpty ? 0 : serviceFee;
  int get total => (subtotal + fee - discount).clamp(0, 1 << 31).toInt();

  // ---- Keranjang ----
  void addItem(CartItem item) {
    final index = _items.indexWhere((e) => e.key == item.key);
    if (index >= 0) {
      _items[index].quantity += item.quantity;
    } else {
      _items.add(item.copy());
    }
    notifyListeners();
  }

  /// Tambah cepat dengan pilihan default (tombol + di kartu produk).
  void addQuick(Product product) => addItem(CartItem(product: product));

  void increment(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decrement(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  // ---- Checkout ----
  void toggleCoupon() {
    _couponActive = !_couponActive;
    notifyListeners();
  }

  void setPaymentMethod(PaymentMethod method) {
    _paymentMethod = method;
    notifyListeners();
  }

  void setPickupAfter(int minutes) {
    _pickupTime = DateTime.now().add(Duration(minutes: minutes));
    _pickupLabel = minutes == 15
        ? 'Secepatnya'
        : (minutes == 60 ? '1 jam lagi' : '$minutes menit lagi');
    notifyListeners();
  }

  void setPickupAt(DateTime time) {
    _pickupTime = time;
    _pickupLabel = 'Pukul ${Formatters.time(time)}';
    notifyListeners();
  }

  /// Membuat pesanan. Melempar [EmptyCartException] jika keranjang kosong.
  String placeOrder() {
    if (_items.isEmpty) throw const EmptyCartException();
    _orderCounter++;
    _activeOrderCode = 'CP-${_orderCounter.toString().padLeft(3, '0')}';
    _items.clear();
    notifyListeners();
    return _activeOrderCode!;
  }
}
