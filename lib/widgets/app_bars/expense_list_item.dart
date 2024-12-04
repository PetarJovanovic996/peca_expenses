import 'package:flutter/material.dart';
import 'package:peca_expenses/main/routes.dart';
import 'package:peca_expenses/models/date.dart';
import 'package:peca_expenses/models/expense_item.dart';
import 'package:peca_expenses/providers/expense_provider.dart';
import 'package:peca_expenses/providers/filters_provider.dart';

import 'package:provider/provider.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final filteredItems = context.watch<FiltersProvider>().filteredExpenses;
    final allItems = context.watch<ExpenseProvider>().expenseItems;

    final List<ExpenseItem> itemsToDisplay =
        filteredItems.isNotEmpty ? filteredItems : allItems;
    return Container(
      // done: No need for parent widget [Padding] when we have Container here,
      // which has "padding" param

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
            itemsToDisplay[index].name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemsToDisplay[index].description),
              Text(
                MyDateFormat.formatDate(itemsToDisplay[index].date),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          leading: Icon(itemsToDisplay[index].category.icon.icon),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '\$${itemsToDisplay[index].amount}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () {
                    // TODO: Follow new logic, first check [editExpense] comments,
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
