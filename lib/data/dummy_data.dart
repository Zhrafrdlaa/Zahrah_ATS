import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../models/product.dart';

/// Sumber data statis (dummy)
class DummyData {
  DummyData._();

  static const String _latteImage =
      'https://images.unsplash.com/photo-1660229496744-1c772fabc06a?fm=jpg&q=70&w=800&auto=format&fit=crop';
  static const String _matchaImage =
      'https://images.unsplash.com/photo-1749280447307-31a68eb38673?fm=jpg&q=70&w=800&auto=format&fit=crop';
  static const String _croissantImage =
      'https://images.unsplash.com/photo-1702090888946-d330cd452f5e?fm=jpg&q=70&w=800&auto=format&fit=crop';

  static const List<AppUser> users = [
    AppUser(
      name: 'Zara',
      email: 'zara@email.com',
      password: 'latte123',
    ),
  ];

  static const List<Product> products = [
    Product(
      id: 'p1',
      name: 'Caffè Latte',
      description:
          'Espresso mantap berpadu dengan steamed milk lembut dan microfoam halus khas racikan barista CoffeePoint. Sentuhan karamel alami dengan aftertaste manis yang memanjakan.',
      basePrice: 22000,
      category: ProductCategory.espresso,
      rating: 4.9,
      reviewCount: '1.2k',
      icon: Icons.local_cafe,
      tint: Color(0xFFC98A4B),
      imageUrl: _latteImage,
    ),
    Product(
      id: 'p2',
      name: 'Americano',
      description: 'Ekstrak espresso murni segar beraroma, disajikan dengan air dingin.',
      basePrice: 18000,
      category: ProductCategory.espresso,
      rating: 4.7,
      reviewCount: '860',
      icon: Icons.coffee,
      tint: Color(0xFF6B4226),
    ),
    Product(
      id: 'p3',
      name: 'Matcha Latte',
      description: 'Matcha premium Uji dengan susu creamy dan manis seimbang.',
      basePrice: 24000,
      category: ProductCategory.nonCoffee,
      rating: 4.8,
      reviewCount: '640',
      icon: Icons.emoji_food_beverage,
      tint: Color(0xFF7FA66B),
      imageUrl: _matchaImage,
    ),
    Product(
      id: 'p4',
      name: 'Croissant Mentega',
      description: 'Pastry renyah dengan mentega asli, dipanggang setiap pagi.',
      basePrice: 20000,
      category: ProductCategory.pastry,
      rating: 4.6,
      reviewCount: '410',
      icon: Icons.bakery_dining,
      tint: Color(0xFFD9A25B),
      imageUrl: _croissantImage,
    ),
    Product(
      id: 'p5',
      name: 'Es Kopi Susu',
      description: 'Kopi susu gula aren khas CoffeePoint, segar dan mudah dinikmati.',
      basePrice: 21000,
      category: ProductCategory.espresso,
      rating: 4.8,
      reviewCount: '2.1k',
      icon: Icons.icecream,
      tint: Color(0xFF9B6B43),
    ),
    Product(
      id: 'p6',
      name: 'Chocolate Hazelnut',
      description: 'Cokelat pekat berpadu aroma hazelnut dengan susu hangat.',
      basePrice: 23000,
      category: ProductCategory.nonCoffee,
      rating: 4.5,
      reviewCount: '300',
      icon: Icons.local_drink,
      tint: Color(0xFF5A3A2A),
    ),
  ];

  /// Pilihan waktu ambil (dalam menit dari sekarang).
  static const List<int> pickupMinutes = [15, 30, 45, 60];
}
