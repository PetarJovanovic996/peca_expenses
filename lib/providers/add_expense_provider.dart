// za novi expense

// import 'dart:ffi';

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:peca_expenses/data/categories.dart';
//import 'package:provider/provider.dart';
import 'package:peca_expenses/models/category.dart';
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

  void saveValues(context) async {
    isSending = true;
    final url = Uri.https(
      'expenses-acbaa-default-rtdb.firebaseio.com',
      'peca_expenses.json',
    );
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'name': enteredName,
          'description': enteredDescription,
          'amount': enteredAmount,
          'date': MyDateFormat().formatDate(selectedDate),
          'category': selectedCategory.title
        },
      ),
    );

    final Map<String, dynamic> resData = json.decode(
      response.body,
    );
    Navigator.of(context).pop(ExpenseItem(
        id: resData['name'],
        name: enteredName,
        description: enteredDescription,
        amount: enteredAmount,
        date: selectedDate,
        category: selectedCategory));
    resetValues();

    notifyListeners();
  }

//psdna;as //dodaj nottify listeners dje trebas

  void loadItems() async {
    final url = Uri.https(
        'expenses-acbaa-default-rtdb.firebaseio.com', 'peca_expenses.json');
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      error = 'Failed to load data. Try later';
      notifyListeners();
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
  }

  void addExpense(context) async {
    final newItem = await Navigator.of(context).pushNamed<ExpenseItem>(
      'addnew',
    );
    if (newItem == null) {
      return;
    }
    expenseItems.add(newItem);

    notifyListeners();
  }

//p[dsam]sadasdasdasdas
  void removeItem(ExpenseItem item) {
    expenseItems.remove(item);
    notifyListeners();
  }
}
