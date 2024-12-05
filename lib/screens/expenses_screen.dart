import 'package:flutter/material.dart';

import 'package:peca_expenses/providers/expense_provider.dart';

import 'package:peca_expenses/widgets/expense_screen_content.dart';
import 'package:peca_expenses/widgets/app_bars/main_app_bar.dart';

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
      bottomNavigationBar: MyNavigationBar(),
      appBar: MainAppBar(),
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
