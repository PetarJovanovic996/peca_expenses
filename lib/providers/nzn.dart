//psdna;as //dodaj nottify listeners dje trebas

  // void loadItems() async {
  //   final url = Uri.https(
  //       'expenses-acbaa-default-rtdb.firebaseio.com', 'peca_expenses.json');
  //   final response = await http.get(url);
  //   final Map<String, dynamic> listData = jsonDecode(response.body);
  //   List<ExpenseItem> loadedItems = [];
  //   for (final item in listData.entries) {
  //     DateTime dateTime = DateTime.parse(item.value['date']);
  //     final category = categories.entries
  //         .firstWhere(
  //             (catItem) => catItem.value.title == item.value['category'])
  //         .value;

  //     loadedItems.add(ExpenseItem(
  //         id: item.key,
  //         name: item.value['name'],
  //         description: item.value['description'],
  //         amount: item.value['amount'],
  //         date: dateTime,
  //         category: category));
  //   }
  //   loadedItems = expenseItems;
  //   notifyListeners();
  // }

  // void addExpense(context) async {
  //   await Navigator.of(context).pushNamed<ExpenseItem>(
  //     'addnew',
  //   );
  //   loadItems();
  //   notifyListeners();
  // }

//p[dsam]sadasdasdasdas