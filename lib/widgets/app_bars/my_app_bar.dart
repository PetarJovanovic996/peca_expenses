import 'package:flutter/material.dart';

// done: [AddExpenseAppBar] and [EditAppBar] are pretty much the same
// and should not be 2 different widgets, instead try to implement by using 1 widget
// the [Title] for the app bar, can be a param to be passed in constructor.
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const MyAppBar(
      {super.key,
      this.preferredSize = const Size.fromHeight(kToolbarHeight),
      required this.title,
      this.titleStyle});
  final String title;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: titleStyle,

        //dodao style brat da se moze igrati, a nije required macka
      ),
      centerTitle: true,
    );
  }
}
