import 'package:flutter/material.dart';

import 'package:peca_expenses/data/categories.dart';
import 'package:peca_expenses/providers/expense_provider.dart';

import 'package:provider/provider.dart';

class CategoryDropdownFormField extends StatelessWidget {
  const CategoryDropdownFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: context.watch<ExpenseProvider>().selectedCategory,
      items: [
        for (final category in categories.entries)
          DropdownMenuItem(
              value: category.value,
              child: Row(
                children: [
                  Icon(
                    category.value.icon.icon,
                    color: const Color.fromARGB(255, 43, 5, 18),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(category.value.title),
                ],
              ))
      ],
      onChanged: (newValue) {
        context.read<ExpenseProvider>().setSelectedCategory(newValue!);
      }, // iz providera
    );
  }
}
