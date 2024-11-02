import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final String image;
  final List<Color> colors = [
    Color(0xFFF6625E),
    Color(0xFF836DB8),
    Color(0xFFDECB9C),
    Colors.white,
  ];
  final String price;
  double rating;
  bool isFavourite;
  bool isPopular;
  final String category; // New field for category

  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    this.price = '',
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    this.category = 'uncategorized', // Default value if not provided
  });

  void setIsFavorite(bool favorite) {
    isFavourite = favorite;
  }
}

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
