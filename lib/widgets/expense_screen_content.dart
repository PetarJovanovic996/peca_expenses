import 'package:flutter/material.dart';
import 'package:peca_expenses/providers/add_expense_provider.dart';
//import 'package:peca_expenses/providers/filters_provider.dart';
import 'package:provider/provider.dart';
import 'package:peca_expenses/models/date.dart';

class ExpenseScreenContent extends StatelessWidget {
  const ExpenseScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final allItems = context.watch<AddExpenseProvider>().expenseItems;

    if (context.watch<AddExpenseProvider>().isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (allItems.isEmpty) {
      return const Center(
        child: Text('Add Your Expanses'),
      );
    }
    if (context.watch<AddExpenseProvider>().error != null) {
      return Center(
        child: Text(context.watch<AddExpenseProvider>().error!),
      );
    }

    return ListView.builder(
      itemCount: allItems.length,
      itemBuilder: (ctx, index) => Dismissible(
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          context.read<AddExpenseProvider>().removeItem(allItems[index]);
        },
        key: ValueKey(allItems[index].name),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 206, 182, 190),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                  color: const Color.fromARGB(255, 82, 21, 21), width: 2),
            ),
            child: ListTile(
                title: Text(
                  allItems[index].name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(allItems[index].description),
                    Text(
                      MyDateFormat.formatDate(allItems[index].date),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                leading: Icon(allItems[index].category.icon.icon),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '\$${allItems[index].amount}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        onPressed: () {
                          context
                              .read<AddExpenseProvider>()
                              .editExpense(allItems[index], ctx);
                        },
                        icon: const Icon(Icons.edit)),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
