import 'package:flutter/material.dart';

enum ProductCategory {
  espresso('Espresso-Based'),
  nonCoffee('Non-Coffee'),
  pastry('Pastry');

  const ProductCategory(this.label);
  final String label;
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.icon,
    required this.tint,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String description;
  final int basePrice;
  final ProductCategory category;
  final double rating;
  final String reviewCount;
  final IconData icon;
  final Color tint;

  /// URL foto produk. Jika null / gagal dimuat, tampil placeholder gradient.
  final String? imageUrl;

  bool get isDrink => category != ProductCategory.pastry;
}
