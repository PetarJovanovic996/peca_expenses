import 'package:flutter/material.dart';

import 'package:peca_expenses/providers/add_expense_provider.dart';

import 'package:peca_expenses/widgets/expense_screen_content.dart';
import 'package:peca_expenses/widgets/my_app_bar.dart';

import 'package:peca_expenses/widgets/my_navigation_bar.dart';
import 'package:provider/provider.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExpenseProvider>().loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // done: Extract BottomNavBar and AppBar to separate files/ widgets
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

      bottomNavigationBar: MyNavigationBar(),
      appBar: MyAppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: ExpenseScreenContent(),
      ),
    );
  }
}

//visual overvierw of the users expenses with filtering option
//implement pull to refresh logic for filtering / kada su prikazatni
// da na dugme se automatski resetuje i lista i prikaze svi troskovi
