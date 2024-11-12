import 'package:flutter/material.dart';
import 'package:peca_expenses/providers/add_expense_provider.dart';
import 'package:peca_expenses/providers/filters_provider.dart';
import 'package:peca_expenses/widgets/expense_screen_content.dart';
import 'package:provider/provider.dart';
//import 'package:peca_expenses/models/date.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'filter');
                },
                icon: const Icon(
                  Icons.filter_alt_sharp,
                  size: 40,
                  color: Colors.white,
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
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.filter_alt_off_sharp,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: ExpenseScreenContent(),
        ));
  }
}

//visual overvierw of the users expenses with filtering option
//implement pull to refresh logic for filtering / kada su prikazatni
// da na dugme se automatski resetuje i lista i prikaze svi troskovi
