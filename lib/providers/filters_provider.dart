//import 'dart:ffi';

import 'package:flutter/material.dart';
//import 'package:peca_expenses/data/categories.dart';

//import 'package:provider/provider.dart';
//import 'package:peca_expenses/models/category.dart';
import 'package:peca_expenses/models/expense_item.dart';
//import 'package:peca_expenses/models/filter_item.dart';
//import 'package:peca_expenses/screens/add_expense.dart';
import 'package:peca_expenses/providers/add_expense_provider.dart';

//import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiltersProvider with ChangeNotifier {
  DateTime? fromDate;
  DateTime? toDate;
  DateTime? selectedDate;

  List<ExpenseItems> filteredExpenses = [];

  // TODO: Not a good idea to use
  // context.read<AddExpenseProvider>().expenseItems
  // in a different provider, refactor to pass the [expenseItems] as a method parameter
  void filterExpenses(BuildContext context) {
    final allExpenses = context.read<AddExpenseProvider>().expenseItems;

    filteredExpenses = allExpenses.where((expense) {
      bool isAfterStart = fromDate == null || expense.date.isAfter(fromDate!);
      bool isBeforeEnd = toDate == null || expense.date.isBefore(toDate!);
      bool isExactDate = selectedDate != null && expense.date.isAtSameMomentAs(selectedDate!);

      return (isAfterStart && isBeforeEnd) || isExactDate;
    }).toList();

    notifyListeners();
  }

  // imam listu
  // pravi se bool kad je true ide exp item
  //kad je false ide filters
  // pravi se void funk u kojoj se dopunjava lista
  //funk filterExpenses da bude void ... umj return ide filterexpense= ...
  // na ui se pozivam na tu novu listu if is true na nju, if else expensesList

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void setStartDate(DateTime startDate) {
    fromDate = startDate;
    notifyListeners();
  }

  void setEndDate(DateTime endDate) {
    toDate = endDate;
    notifyListeners();
  }

  void clearFilters() {
    fromDate = null;
    toDate = null;
    selectedDate = null;
    notifyListeners();
  }
}

// }

// Filtering examples:
//
//- Users can see expenses filtered by DateRange
//or by Date.
//- Users can see expenses for the current day.
// - Users can see expenses for the current week.
// - Users can see expenses for the current month.
// - Users can see expenses data represented through graphs.
//- For graphs utilize https://pub.dev/packages/fl_chart
//- Users can filter the expenses by categories.
