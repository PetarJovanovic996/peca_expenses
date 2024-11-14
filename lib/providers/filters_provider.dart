//import 'dart:ffi';

import 'package:flutter/material.dart';

//import 'package:peca_expenses/data/categories.dart';

//import 'package:provider/provider.dart';
//import 'package:peca_expenses/models/category.dart';
import 'package:peca_expenses/models/expense_item.dart';
//import 'package:peca_expenses/models/filter_item.dart';
//import 'package:peca_expenses/screens/add_expense.dart';

//import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class FiltersProvider with ChangeNotifier {
  DateTime? fromDate;
  DateTime? toDate;
  DateTime? selectedDate;

  List<ExpenseItem> filteredExpenses = [];

  // done: Not a good idea to use
  // context.read<AddExpenseProvider>().expenseItems
  // in a different provider, refactor to pass the [expenseItems] as a method parameter

  void filterByRange(List<ExpenseItem> expenseItems) {
    filteredExpenses = expenseItems.where((expense) {
      bool isInRange = (fromDate == null || expense.date.isAfter(fromDate!)) &&
          (toDate == null || expense.date.isBefore(toDate!));

      return isInRange;
    }).toList();

    notifyListeners();
  }

  void filterByDate(List<ExpenseItem> expenseItems) {
    filteredExpenses = expenseItems.where((expense) {
      bool isExactDate =
          selectedDate != null && expense.date.isAtSameMomentAs(selectedDate!);

      return isExactDate;
    }).toList();

    notifyListeners();
  }

  // void filterExpenses(List<ExpenseItem> expenseItems) {
  //   filteredExpenses = expenseItems.where((expense) {
  //     bool isInRange = (fromDate == null || expense.date.isAfter(fromDate!)) &&
  //         (toDate == null || expense.date.isBefore(toDate!));
  //     bool isExactDate =
  //         selectedDate != null && expense.date.isAtSameMomentAs(selectedDate!);

  //     return isInRange || isExactDate;
  //   }).toList();

  //   notifyListeners();
  // }

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
    filteredExpenses.clear();

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
