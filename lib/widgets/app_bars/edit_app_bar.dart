import 'package:flutter/material.dart';

// TODO: [AddExpenseAppBar] and [EditAppBar] are pretty much the same
// and should not be 2 different widgets, instead try to implement by using 1 widget
// the [Title] for the app bar, can be a param to be passed in constructor.
class EditAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const EditAppBar(
      {super.key, this.preferredSize = const Size.fromHeight(kToolbarHeight)});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Padding(
        // TODO: Never use this much padding, there is a different way to implement this.
        padding: EdgeInsets.all(80.0),
        child: Text('Edit Expense'),
      ),
    );
  }
}
