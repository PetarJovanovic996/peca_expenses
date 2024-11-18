import 'package:equatable/equatable.dart';
import 'package:peca_expenses/data/category.dart';

class ExpenseItem extends Equatable {
  const ExpenseItem({
    this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
  });

  final String? id;
  final String name;
  final String description;
  final String amount;
  final DateTime date;
  final Category category;

  @override
  List<Object?> get props => [id, name, description, amount, date, category];
}
