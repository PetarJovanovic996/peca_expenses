import 'package:flutter/material.dart';

class EditAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const EditAppBar(
      {super.key, this.preferredSize = const Size.fromHeight(kToolbarHeight)});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.all(80.0),
        child: Text('Edit Expense'),
      ),
    );
  }
}
