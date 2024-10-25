import 'package:flutter/material.dart';
import 'package:peca_expenses/providers/add_expense_provider.dart';
import 'package:peca_expenses/providers/filters_provider.dart';
import 'package:peca_expenses/screens/add_expense.dart';
import 'package:peca_expenses/screens/filters_screen.dart';
import 'package:peca_expenses/screens/expenses_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddExpenseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FiltersProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Named Routes',
        initialRoute: 'expenses',
        routes: {
          // 'loginscreen': (context) => const LogInScreen(), // dodati logIn skrin i kao initial
          'expenses': (context) => const ExpensesScreen(),
          'filter': (context) => const FiltersScreen(),
          'addnew': (context) => AddExpense(),
        },
      ),
    );
  }
}
