import 'package:peca_expenses/data/categories.dart';
import 'package:peca_expenses/models/expense_item.dart';
import 'package:peca_expenses/models/category.dart';

final expenseItems = [
  ExpenseItems(
      id: '1',
      name: 'Beef',
      description: 'Expensive',
      amount: '',
      date: DateTime.now(),
      category: categories[Categories.food]!),
  ExpenseItems(
      id: '2',
      name: 'Shirt',
      description: 'For job',
      amount: '4',
      date: DateTime.now(),
      category: categories[Categories.clothes]!),
  ExpenseItems(
      id: '3',
      name: 'Gym',
      description: '3 times a week',
      amount: '',
      date: DateTime.now(),
      category: categories[Categories.sport]!),
];
