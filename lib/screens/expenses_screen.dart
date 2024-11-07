import 'package:flutter/material.dart';
import 'package:peca_expenses/models/expense_item.dart';
import 'package:peca_expenses/providers/add_expense_provider.dart';
import 'package:peca_expenses/providers/filters_provider.dart';
import 'package:peca_expenses/screens/edit_screen.dart';
import 'package:provider/provider.dart';
import 'package:peca_expenses/models/date.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AddExpenseProvider>().loadItems(context);
  }
//
//
//edit
//
//

  void _editExpense(ExpenseItem item) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => EditExpenseScreen(item: item),
      ),
    )
        .then((updatedItem) {
      if (updatedItem != null) {
        context.read<AddExpenseProvider>().updateExpense(updatedItem);
      }
    });
  }
  //
  //EDIT
  //
  //

  @override
  Widget build(BuildContext context) {
    // TODO: Refactor needed. Instead of using Widget content, declare a separate Widget,
    // TODO: e.g [ExpensesScreenContent]
    // By using custom widgets instead of variables we increase performance and cleaner code.
    Widget content = const Center(
      child: Text('Add Your Expanses'),
    );

    final allItems = context.watch<AddExpenseProvider>().expenseItems;

    // done: Better to use [watch], because [isLoading] is a variable which is changing
    if (context.watch<AddExpenseProvider>().isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (allItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: allItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            context.read<AddExpenseProvider>().removeItem(allItems[index]);
          },
          key: ValueKey(allItems[index].name),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              padding: const EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 171, 168, 168),
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                    color: const Color.fromARGB(255, 82, 21, 21), width: 2),
              ),
              // TODO: Refactor single list item, to a custom widget.
              child: ListTile(

                  //EDIT
                  //EDIT
                  // onTap: () => _editExpense(allItems[index]),
                  //EDIT
                  //EDIT
                  title: Text(
                    allItems[index].name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(allItems[index].description),
                      Text(
                        MyDateFormat.formatDate(allItems[index].date),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  leading: Icon(allItems[index].category.icon.icon),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '\$${allItems[index].amount}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            _editExpense(allItems[index]);
                          },
                          icon: const Icon(Icons.edit)),
                    ],
                  )),
            ),
          ),
        ),
      );
      // } else if (filteredItems.isNotEmpty) {
      //   content = ListView.builder(
      //     itemCount: filteredItems.length,
      //     itemBuilder: (ctx, index) => ListTile(
      //       title: Text(filteredItems[index].name),
      //       subtitle: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(filteredItems[index].description),
      //           Text(MyDateFormat().formatDate(filteredItems[index].date)),
      //         ],
      //       ),
      //       leading: Icon(filteredItems[index].category.icon.icon),
      //       trailing: Text('\$${filteredItems[index].amount}'),
      //     ),
      //   );
    }

    // TODO: Use watch instead, error is a variable which changes in value.
    if (context.read<AddExpenseProvider>().error != null) {
      content = Center(
        child: Text(context.watch<AddExpenseProvider>().error!),
      );
    }

    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 46, 43, 43),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'filter');
                },
                icon: const Icon(
                  Icons.filter_alt_sharp,
                  size: 40,
                ),
              ),
              const SizedBox(
                width: 120,
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, 'addnew');
                },
                label: const Text(
                  'Add new Expense',
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.add_box_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Center(
            child: Text(
              'My Expenses',
              style: TextStyle(fontSize: 32),
            ),
          ),
          actions: [
            const SizedBox(
              width: 50,
            ),
            TextButton.icon(
              onPressed: () {
                context.read<FiltersProvider>().clearFilters();
              },
              label: const Text(
                'Clear all Filters',
                style: TextStyle(color: Colors.black),
              ),
              icon: const Icon(
                Icons.filter_alt_off_sharp,
                color: Colors.black,
              ),
            ),
          ],
        ),

        //
        //
        // OVDJE POCINJE LISTA

        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: content,
        ));
  }
}

//visual overvierw of the users expenses with filtering option
//implement pull to refresh logic for filtering / kada su prikazatni
// da na dugme se automatski resetuje i lista i prikaze svi troskovi
