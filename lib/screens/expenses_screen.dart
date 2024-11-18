import 'package:flutter/material.dart';
import 'package:peca_expenses/providers/add_expense_provider.dart';
import 'package:peca_expenses/providers/filters_provider.dart';
import 'package:peca_expenses/widgets/expense_screen_content.dart';
import 'package:provider/provider.dart';
import 'package:peca_expenses/providers/auth_provider.dart';

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
      // TODO: Extract BottomNavBar and AppBar to separate files/ widgets
      // The goal is to once someone opens a file, that he can instantly see what is happening
      // in the widget tree. So good example would be something like :

      // return Scaffold(
      //     bottomNavigationBar: MyNavigationBar(),
      //     appBar: MyAppBar(),
      //     body: const Padding(
      //         padding: EdgeInsets.only(top: 20.0),
      //         child: ExpenseScreenContent(),
      //       ),
      // )
      // This way we can see right away what's supposed to render and the entire screen is easy to read.

      // Also, in bigger apps, bottom app bars and app bars are generally used in more than 1 screen,
      // so it's always a good idea to have them extracted in a separate widget.

      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                // TODO: Use new syntax : [Navigator.of(context).pushNamed] instead
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
                // Here is a good example of what I explained in the [routes] file,
                // someone can write "addNew" next time they are trying to navigate to this screen,
                // and this will cause a bug in the code.

                Navigator.pushNamed(context, 'add-new');
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
          //
          //todo
          //
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await context.read<AuthProvider>().signOut();
              if (!context.mounted) {
                return;
              }
              // TODO: Google [Navigator.pushAndRemoveUntil] method
              // TODO: Update navigator syntax
              Navigator.pushReplacementNamed(
                  context, 'login-screen'); // Usmeravamo na login ekran
            },
          ),
          //
          //aloo
          //
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: ExpenseScreenContent(),
      ),
    );
  }
}

//visual overvierw of the users expenses with filtering option
//implement pull to refresh logic for filtering / kada su prikazatni
// da na dugme se automatski resetuje i lista i prikaze svi troskovi
