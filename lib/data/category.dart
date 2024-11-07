import 'package:flutter/material.dart';

enum Categories {
  food,
  bills,
  rent,
  sport,
  clothes,
  nightOut,
  other,
}

class Category {
  const Category({required this.title, required this.icon});

  final String title;
  final Icon icon;
}
