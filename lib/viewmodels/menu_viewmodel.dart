import 'package:flutter/foundation.dart';

import '../data/dummy_data.dart';
import '../models/product.dart';

/// Mengelola pencarian, filter kategori, dan favorit.
class MenuViewModel extends ChangeNotifier {
  final List<Product> _all = DummyData.products;
  final Set<String> _favoriteIds = {'p1'};
  String _query = '';
  ProductCategory? _category;

  String get query => _query;
  ProductCategory? get category => _category;
  int get favoriteCount => _favoriteIds.length;

  List<Product> get products {
    final keyword = _query.trim().toLowerCase();
    return _all.where((p) {
      final matchCategory = _category == null || p.category == _category;
      final matchQuery = p.name.toLowerCase().contains(keyword);
      return matchCategory && matchQuery;
    }).toList();
  }

  bool isFavorite(String productId) => _favoriteIds.contains(productId);

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void setCategory(ProductCategory? value) {
    _category = value;
    notifyListeners();
  }

  void toggleFavorite(String productId) {
    if (!_favoriteIds.remove(productId)) _favoriteIds.add(productId);
    notifyListeners();
  }
}
