import 'package:flutter/material.dart';

class AddExpenseAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const AddExpenseAppBar(
      {super.key, this.preferredSize = const Size.fromHeight(kToolbarHeight)});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.all(70.0),
        child: Text('Add New Expense'),
      ),
    );
  }
}
