import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:peca_expenses/firebase_options.dart';
import 'package:peca_expenses/providers/add_expense_provider.dart';
import 'package:peca_expenses/providers/filters_provider.dart';
import 'package:peca_expenses/screens/add_expense.dart';
import 'package:peca_expenses/screens/filters_screen.dart';
import 'package:peca_expenses/screens/expenses_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// TODO: Define theme in a separate file
final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

// TODO: Good practice is to have main.dart only contain main method
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// TODO: Extract MyApp to separate file
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
        // TODO: For larger apps with 20+ routes, it's a better practice to define
        // TODO: routes in a separate file e.g [routes.dart]
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
