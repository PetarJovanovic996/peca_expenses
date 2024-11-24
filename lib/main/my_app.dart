import 'package:flutter/material.dart';

import 'package:peca_expenses/main/my_theme.dart';
import 'package:peca_expenses/main/routes.dart';
import 'package:peca_expenses/providers/add_expense_provider.dart';
import 'package:peca_expenses/providers/auth_provider.dart';
import 'package:peca_expenses/providers/filters_provider.dart';

import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ExpenseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FiltersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        )
      ],
      child: MaterialApp(
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        title: 'Named Routes',
        onGenerateRoute: MyRouter.onGenerateRoute,
        // initialRoute: 'expenses',
        //'loginscreen', //dodati logIn skrin i kao initial
        //
        //
        // routes: routes,
      ),
    );
  }
}
