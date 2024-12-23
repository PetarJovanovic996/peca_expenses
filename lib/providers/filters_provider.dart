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

  bool get isFilterActive {
    return fromDate != null || toDate != null || selectedDate != null;
  }

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

  void filterByCurrentWeek(List<ExpenseItem> expenseItems) {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;

    DateTime startOfWeek = now.subtract(Duration(days: currentWeekday - 1));

    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    filteredExpenses = expenseItems.where((expense) {
      bool isInCurrentWeek =
          expense.date.isAfter(startOfWeek) && expense.date.isBefore(endOfWeek);
      return isInCurrentWeek;
    }).toList();

    notifyListeners();
  }

  void filterByCurrentMonth(List<ExpenseItem> expenseItems) {
    DateTime now = DateTime.now();

    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth =
        DateTime(now.year, now.month + 1, 1).subtract(Duration(days: 1));

    filteredExpenses = expenseItems.where((expense) {
      bool isInCurrentMonth =
          expense.date.isAfter(startOfMonth.subtract(Duration(days: 1))) &&
              expense.date.isBefore(endOfMonth.add(Duration(days: 1)));
      return isInCurrentMonth;
    }).toList();

    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;

    notifyListeners();
  }

  void setTodaysDate() {
    selectedDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    notifyListeners();
  }

  void setThisWeek() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;
    fromDate = now.subtract(Duration(days: currentWeekday - 1));
    toDate = fromDate!.add(Duration(days: 6));
    notifyListeners();
  }

  void setThisMonth() {
    DateTime now = DateTime.now();
    fromDate = DateTime(now.year, now.month, 1);
    toDate = DateTime(now.year, now.month + 1, 1).subtract(Duration(days: 1));
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
