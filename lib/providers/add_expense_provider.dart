// za novi expense

// import 'dart:ffi';

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:peca_expenses/data/categories.dart';
//import 'package:provider/provider.dart';
import 'package:peca_expenses/data/category.dart';
import 'package:peca_expenses/models/date.dart';
import 'package:peca_expenses/models/expense_item.dart';

class AddExpenseProvider extends ChangeNotifier {
  var enteredId = '';
  var enteredName = '';
  var enteredDescription = '';
  var enteredAmount = '';
  DateTime selectedDate = DateTime.now();
  var selectedCategory = categories[Categories.other]!;
  var isSending = false;

  List<ExpenseItem> expenseItems = [];
  var isLoading = true;
  String? error;

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
    isSending = false;
    notifyListeners();
  }

  // done: Always define types! Should be : (BuildContext context)
  void saveValues(BuildContext context) async {
    isSending = true;
    notifyListeners();

    // done: Add try-catch block
    final url = Uri.https(
      'expenses-acbaa-default-rtdb.firebaseio.com',
      'peca_expenses.json',
    );
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'name': enteredName,
            'description': enteredDescription,
            'amount': enteredAmount,
            'date': MyDateFormat.formatDate(selectedDate),
            'category': selectedCategory.title
          },
        ),
      );

      if (response.statusCode >= 400) {
        isSending = false;
        notifyListeners();
        return;
      }

      final Map<String, dynamic> resData = json.decode(response.body);

      final addedItem = ExpenseItem(
        id: resData['name'],
        name: enteredName,
        description: enteredDescription,
        amount: enteredAmount,
        date: selectedDate,
        category: selectedCategory,
      );

      expenseItems.add(addedItem);
      Navigator.of(context).pop(addedItem);
      resetValues();
      isSending = false; // Resetuj isSending
      notifyListeners();
    } catch (errors) {
      isLoading = false;
      notifyListeners();
    }
  }

//LOAD

  void loadItems(BuildContext context) async {
    // done: Add try-catch block
    final url = Uri.https(
        'expenses-acbaa-default-rtdb.firebaseio.com', 'peca_expenses.json');
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        error = 'Failed to load data. Try later';
        isLoading = false;
        notifyListeners();
        return;
        // done: Missing return statement?
      }

      if (response.body == 'null') {
        isLoading = false;
        notifyListeners();
        return;
      }

      final Map<String, dynamic> listData = jsonDecode(response.body);
      List<ExpenseItem> loadedItems = [];
      for (final item in listData.entries) {
        DateTime dateTime = DateTime.parse(item.value['date']);
        final category = categories.entries
            .firstWhere(
                (catItem) => catItem.value.title == item.value['category'])
            .value;

        loadedItems.add(ExpenseItem(
            id: item.key,
            name: item.value['name'],
            description: item.value['description'],
            amount: item.value['amount'],
            date: dateTime,
            category: category));
      }
      expenseItems = loadedItems;
      isLoading = false;

      notifyListeners();

      // print(response.statusCode);
    } catch (errors) {
      error = 'Failed to load data. Try later';
      isLoading = false;
      notifyListeners();
    }
  }
// KRAJ LOADA

  void removeItem(ExpenseItem item) async {
    final index = expenseItems.indexOf(item);
    expenseItems.remove(item);
    notifyListeners();
    final url = Uri.https('expenses-acbaa-default-rtdb.firebaseio.com',
        'peca_expenses/${item.id}.json');

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      expenseItems.insert(index, item);
      notifyListeners();
    }

    notifyListeners();
  }

  //
  //
  //EDIT
  //
  //

// ovdje je UPDATE u firebase

  void updateExpense(ExpenseItem item) async {
    final url = Uri.https(
      'expenses-acbaa-default-rtdb.firebaseio.com',
      'peca_expenses/${item.id}.json',
    );

    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'name': item.name,
          'description': item.description,
          'amount': item.amount,
          'date': MyDateFormat.formatDate(item.date),
          'category': item.category.title,
        },
      ),
    );

    if (response.statusCode >= 400) {
      error = 'Failed to update expense. Try later.';
      notifyListeners();
    } else {
      int index = expenseItems.indexWhere((e) => e.id == item.id);
      if (index != -1) {
        expenseItems[index] = item; // Ažuriraj u firebase
      }
    }
    notifyListeners();
  }

  //KRAJ EDIT I UPDATE
  //
  //
  //
}
