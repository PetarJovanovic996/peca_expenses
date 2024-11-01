import 'package:flutter/material.dart';

import 'package:peca_expenses/models/category.dart';

// TODO: Simpler way is to create a list of categories, instead of a map
// TODO: e.g
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
    icon: Icon(
      Icons.local_pizza_outlined,
    ),
  ),
  Categories.bills: Category(
    title: 'Bills',
    icon: Icon(
      Icons.electrical_services,
    ),
  ),
  Categories.rent: Category(
    title: 'Rent',
    icon: Icon(
      Icons.house,
    ),
  ),
  Categories.sport: Category(
    title: 'Sport',
    icon: Icon(
      Icons.sports_gymnastics_sharp,
    ),
  ),
  Categories.clothes: Category(
    title: 'Clothes',
    icon: Icon(
      Icons.shopping_bag_outlined,
    ),
  ),
  Categories.nightOut: Category(
    title: 'Night Out',
    icon: Icon(
      Icons.wine_bar_rounded,
    ),
  ),
  Categories.other: Category(
    title: 'Other',
    icon: Icon(
      Icons.radio_button_unchecked_rounded,
    ),
  ),
};
