import 'package:flutter/material.dart';
import 'package:peca_expenses/main/routes.dart';
import 'package:peca_expenses/models/date.dart';
import 'package:peca_expenses/models/expense_item.dart';
import 'package:peca_expenses/providers/expense_provider.dart';

import 'package:provider/provider.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({required this.index, super.key});

  final int index;

  // done: Instead of passing index to each [ExpenseListItem] and then reading again the
  // provider's value, you can pass the object itself.
  // done: Refactor

  // done: There is also a cleaner way. Google [Provider.value] and try to figure out
  // how that can be fit here. If you use Provider.value, the right way, there is no need
  // to pass anything to [ExpenseListItem]

  @override
  Widget build(BuildContext context) {
    // done: Just a note: This should not be watch!
    // TIP: When writing logic, always try to write [context.read] first,
    // and if it's needed then use [watch]. Here we don't need watch.

    final expenseItem = Provider.of<ExpenseItem>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 206, 182, 190),
        borderRadius: BorderRadius.circular(15.0),
        border:
            Border.all(color: const Color.fromARGB(255, 82, 21, 21), width: 2),
      ),
      child: ListTile(
          title: Text(
            expenseItem.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(expenseItem.description),
              Text(
                MyDateFormat.formatDate(expenseItem.date),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          leading: Icon(expenseItem.category.icon.icon),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '\$${expenseItem.amount}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () {
                    //: Follow new logic, first check [editExpense] comments,
                    // I will update [edit_screen] and [add_expense_provider] by adding
                    // int? editingIndex;

                    context.read<ExpenseProvider>().setEditingIndex(index);

                    Navigator.of(context).pushNamed(Routes.editExpense);

                    // CHECK COMMENTS IN THE editExpense, this is the right way to do it
                    // context
                    //     .read<AddExpenseProvider>()
                    //     .editExpense(itemsToDisplay[index], ctx);
                  },
                  icon: const Icon(Icons.edit)),
            ],
          )),
    );
  }
}
