import 'package:flutter/material.dart';

import 'package:peca_expenses/data/category.dart';

// Categories.food: Category(
//     title: 'Food',
//     icon: Icon(
//       Icons.local_pizza_outlined,
//     ),
//   ),

// This can be refactored to be:
// Category(
//     title: Categories.food,
//     icon: Icon(
//       Icons.local_pizza_outlined,
//     ),
//   ),

// When searching for a specific category, you can look up by title matching the enum.
const categories = {
  Categories.food: Category(
    title: 'Food',
    icon: Icon(Icons.local_pizza_outlined),
  ),
  Categories.bills: Category(
    title: 'Bills',
    icon: Icon(Icons.electrical_services),
  ),
  Categories.rent: Category(
    title: 'Rent',
    icon: Icon(Icons.house),
  ),
  Categories.sport: Category(
    title: 'Sport',
    icon: Icon(Icons.sports_gymnastics_sharp),
  ),
  Categories.clothes: Category(
    title: 'Clothes',
    icon: Icon(Icons.shopping_bag_outlined),
  ),
  Categories.nightOut: Category(
    title: 'Night Out',
    icon: Icon(Icons.wine_bar_rounded),
  ),
  Categories.other: Category(
    title: 'Other',
    icon: Icon(Icons.radio_button_unchecked_rounded),
  ),
};

// Categories.food => Categories.food
// Categories.food.name => food,

// final categories2 = [
//   Category(
//     title: Categories.food.name,
//     icon: Icon(Icons.local_pizza_outlined),
//   ),
//   Category(
//     title: Categories.bills.name,
//     icon: Icon(Icons.electrical_services),
//   ),
//   Category(
//     title: Categories.rent.name,
//     icon: Icon(Icons.house),
//   ),
//   Category(
//     title: Categories.sport.name,
//     icon: Icon(Icons.sports_gymnastics_sharp),
//   ),
//   Category(
//     title: Categories.clothes.name,
//     icon: Icon(Icons.shopping_bag_outlined),
//   ),
//   Category(
//     title: Categories.nightOut.name,
//     icon: Icon(Icons.wine_bar_rounded),
//   ),
//   Category(
//     title: Categories.other.name,
//     icon: Icon(Icons.radio_button_unchecked_rounded),
//   ),
// ];
