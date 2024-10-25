// za novi expense

// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:peca_expenses/data/categories.dart';
//import 'package:provider/provider.dart';
import 'package:peca_expenses/models/category.dart';
import 'package:peca_expenses/models/expense_item.dart';

// SA PECOM KAKO RESETOVAT CATEGORY DA SE VRATI NA OTHER
// I KAKO RESETOVAT KALENDAR

class AddExpenseProvider extends ChangeNotifier {
  var enteredId = '';
  var enteredName = '';
  var enteredDescription = '';
  var enteredAmount = '';
  DateTime selectedDate = DateTime.now();
  var selectedCategory = categories[Categories.other]!;

  final List<ExpenseItem> expenseItems = [];

  void setEnteredName(String newValue) {
    enteredName = newValue;
    notifyListeners();
  }

  void setEnteredDescription(String newValue) {
    enteredDescription = newValue;
    notifyListeners();
  }

  void setEnteredAmount(String newValue) {
    enteredAmount = newValue;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void setSelectedCategory(Category newValue) {
    selectedCategory = newValue;
    notifyListeners();
  }

  void resetValues() {
    enteredId = '';
    enteredName = '';
    enteredDescription = '';
    enteredAmount = '';
    selectedDate = DateTime.now();
    selectedCategory = categories[Categories.other]!;
    notifyListeners();
  }

  void saveValues(context) {
    ExpenseItem newValues = ExpenseItem(
        id: enteredId,
        name: enteredName,
        description: enteredDescription,
        amount: enteredAmount,
        date: selectedDate,
        category: selectedCategory);
    expenseItems.add(newValues);
    Navigator.of(context).pop();
    resetValues();
    notifyListeners();
  }

  void addExpense(context) async {
    final newExpense = await Navigator.of(context).pushNamed<ExpenseItem>(
      'addnew',
    );

    if (newExpense == null) {
      return;
    }
    expenseItems.add(newExpense);
    notifyListeners();
  }

  void removeItem(ExpenseItem item) {
    expenseItems.remove(item);
    notifyListeners();
  }
}
