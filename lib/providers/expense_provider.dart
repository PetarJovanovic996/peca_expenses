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

class ExpenseProvider extends ChangeNotifier {
  var enteredId = '';
  var enteredName = '';
  var enteredDescription = '';
  var enteredAmount = '';
  DateTime selectedDate = DateTime.now();
  // var selectedCategory = categories2.last;
  var selectedCategory = categories[Categories.other]!;
  var isSending = false;

  // Example: how to update the Editing navigation and logic ;

  int? editingIndex;

  void setEditingIndex(int index) {
    editingIndex = index;
    notifyListeners();
  }

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

  // done: Follow new implementation, read down below,
  // context no longer needed here.
  Future<bool> saveValues() async {
    isSending = true;
    notifyListeners();

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
        return false;
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

      // No longer needed.
      // if (!context.mounted) {
      //   return false;
      // }

      // done: Follow the new implementation.
      // CHECK [add_expense] where we call saveValues
      // Note the function is no longer [void] it's a [bool]

      // If the saving of a new expense is successful we return true else return false;
      // Based on this we will handle the navigation, in the UI part.

      // Navigator.of(context).pop(addedItem);
      resetValues();
      isSending = false; // Resetuj isSending
      notifyListeners();
      return true;
    } catch (errors) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

//LOAD
  // done: Remove this context, as it is not used anywhere in the method call
  void loadItems() async {
    // isLoading = true;
    // notifyListeners();
    final url = Uri.https(
        'expenses-acbaa-default-rtdb.firebaseio.com', 'peca_expenses.json');
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        error = 'Failed to load data. Try later';
        isLoading = false;
        notifyListeners();
        return;
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
    } catch (errors) {
      error = 'Failed to load data. Try later';
      isLoading = false;
      notifyListeners();
    }
  }
// KRAJ LOADA

  // done: Add try-catch in every place we have API communication, i.e HTTP requests.
  Future<void> removeItem(ExpenseItem item) async {
    try {
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
    } catch (e) {
      error = 'Failed to remove data. Try later';
      notifyListeners();
    }
  }

// ovdje je UPDATE u firebase

  Future<bool> updateExpense(ExpenseItem item) async {
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
      return false;
    } else {
      // final niz = [1, 2, 3, 4]
      // niz.insert(2, 10);
      // [1, 2, 10, 3, 4]

      expenseItems[editingIndex!] = item;

      notifyListeners();
      return true;
    }
  }
}
