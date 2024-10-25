import 'package:flutter/material.dart';

import 'package:peca_expenses/models/category.dart';

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
