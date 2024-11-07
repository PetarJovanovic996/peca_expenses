import 'package:peca_expenses/data/category.dart';

// done: When naming a model, use single instance names,
// done: e.g [ExpenseItem], instead of [ExpenseItems]
class ExpenseItem {
  const ExpenseItem({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
  });

  final String id;
  final String name;
  final String description;
  final String amount;
  final DateTime date;
  final Category category;
}
