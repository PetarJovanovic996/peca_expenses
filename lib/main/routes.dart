import 'package:flutter/material.dart';
import 'package:peca_expenses/screens/add_expense.dart';
import 'package:peca_expenses/screens/expenses_screen.dart';
import 'package:peca_expenses/screens/filters_screen.dart';
import 'package:peca_expenses/screens/log_in_screen.dart';
import 'package:peca_expenses/screens/register_screen.dart';

final Map<String, WidgetBuilder> routes = {
  'expenses': (context) => const ExpensesScreen(),
  'filter': (context) => const FiltersScreen(),
  'addnew': (context) => AddExpense(),
  'loginscreen': (context) => LoginScreen(),
  'register': (context) => RegisterScreen()
};
