import 'package:flutter/material.dart';

// TODO: Enum is not a model, separate it into a different file
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
