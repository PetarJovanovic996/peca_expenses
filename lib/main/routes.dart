import 'package:flutter/material.dart';
import 'package:peca_expenses/screens/add_expense_screen.dart';
import 'package:peca_expenses/screens/edit_screen.dart';
import 'package:peca_expenses/screens/expenses_screen.dart';
import 'package:peca_expenses/screens/filters_screen.dart';
import 'package:peca_expenses/screens/log_in_screen.dart';
import 'package:peca_expenses/screens/register_screen.dart';

// Routes always separate words by -
// add-new, login-screen
//pitanje: Samo potvrda
//Treba li mi onda ovo routes {}...
// final Map<String, WidgetBuilder> routes = {
//   'expenses': (context) => const ExpensesScreen(),
//   'filter': (context) => const FiltersScreen(),
//   'add-new': (context) => AddExpenseScreen(),
//   'login-screen': (context) => LoginScreen(),
//   'register': (context) => RegisterScreen()
// };
// This is good but when routing to named routes, we can make typos when typing,
// and so there is even a better way to do it:

// Instead of using
// Navigator.of(context).pushNamed('expenses')

// we can use
// Navigator.of(context).pushNamed(Routes.expenses)

// this way only Routes class hold the concrete string, and serves as single source of truth
// meaning, if we want to update the name of a route, we only update in one single place
// instead of the entire code where we pushed to that route.

// done: Replace all hardcoded route names in project with these
class Routes {
  static const String expenses = 'expenses';
  static const String filter = 'filter';
  static const String addNew = 'add-new';
  static const String loginScreen = 'login-screen';
  static const String register = 'register';
  static const String editExpense = 'edit-expense';
}

// BONUS:

// Rather than declaring routes by their names and create mappings, we can utilize
// [onGenerateRoute] method. Check [my_app.dart] to see how the implementation works.
// I will refactor and comment out current implementation to show how this could work.

class MyRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return switch (routeSettings.name) {
          (Routes.expenses) => const ExpensesScreen(),
          (Routes.filter) => const FiltersScreen(),
          (Routes.addNew) => AddExpenseScreen(),
          (Routes.loginScreen) => LoginScreen(),
          (Routes.register) => RegisterScreen(),
          (Routes.editExpense) => const EditExpenseScreen(),
          // Default route
          _ => const ExpensesScreen(),
        };
      },
    );
  }
}
