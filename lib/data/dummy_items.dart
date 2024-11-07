import 'package:peca_expenses/data/categories.dart';
import 'package:peca_expenses/models/expense_item.dart';
import 'package:peca_expenses/data/category.dart';

final expenseItems = [
  ExpenseItem(
      id: '1',
      name: 'Beef',
      description: 'Expensive',
      amount: '',
      date: DateTime.now(),
      category: categories[Categories.food]!),
  ExpenseItem(
      id: '2',
      name: 'Shirt',
      description: 'For job',
      amount: '4',
      date: DateTime.now(),
      category: categories[Categories.clothes]!),
  ExpenseItem(
      id: '3',
      name: 'Gym',
      description: '3 times a week',
      amount: '',
      date: DateTime.now(),
      category: categories[Categories.sport]!),
];
