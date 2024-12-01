import 'package:flutter/material.dart';
import 'package:peca_expenses/main/routes.dart';
import 'package:peca_expenses/models/expense_item.dart';
import 'package:peca_expenses/providers/expense_provider.dart';
import 'package:peca_expenses/providers/filters_provider.dart';
import 'package:provider/provider.dart';
import 'package:peca_expenses/models/date.dart';

class ExpenseScreenContent extends StatelessWidget {
  const ExpenseScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final filteredItems = context.watch<FiltersProvider>().filteredExpenses;
    final allItems = context.watch<ExpenseProvider>().expenseItems;
    final isLoading = context.watch<ExpenseProvider>().isLoading;
    final hasError = context.watch<ExpenseProvider>().error != null;

    final List<ExpenseItem> itemsToDisplay =
        filteredItems.isNotEmpty ? filteredItems : allItems;

    final isEmpty = itemsToDisplay.isEmpty;

    if (isLoading) {
      // Just for cleaner code extract to custom widget, example given at the bottom of this file.

      return const _LoadingWidget();
    }

    if (isEmpty) {
      // Just for cleaner code extract to custom widget, example given at the bottom of this file.
      // Similarly as for _LoadingWidget
      return const _EmptyWidget();
    }

    if (hasError) {
      // Just for cleaner code extract to custom widget, example given at the bottom of this file.
      // Similarly as for _LoadingWidget
      return const _ErrorWidget();
    }

    // Example how we can achieve the same logic, and have it be more clear to someone who
    // looks at the code for the first time

    // final isLoading = context.watch<AddExpenseProvider>().isLoading;
    // final isEmpty = itemsToDisplay.isEmpty;
    // final hasError = context.watch<AddExpenseProvider>().error != null;
    //
    // if (isLoading) return const _LoadingWidget();
    // if (isEmpty) return const _EmptyWidget();
    // if (hasError) return const _ErrorWidget();

    return ListView.builder(
      itemCount: itemsToDisplay.length,
      // TODO: It's always a good idea to show an icon when using dismissable,
      // since it may not be intuitive to the user what action is being done
      // Example: Check swiping left/right on gmail app when in inbox to see what I mean
      itemBuilder: (ctx, index) => Dismissible(
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          context.read<ExpenseProvider>().removeItem(itemsToDisplay[index]);
        },
        // key: ValueKey(itemsToDisplay[index].name),
        // TODO: To resolve the bug when deleting an expense item, we need to ensure,
        // every key is unique, we can use the following simplest solution
        // Since names can be the same for 2 different expenses, the above code won't work,
        // Example: Code will break if we add 2 expenses with the same name, and then try to delete one of them
        key: UniqueKey(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          // TODO: Extract single list item as a separate widget

          // Example of a clean itemBuilder would be :
          // itemBuilder: (context, index) => SingleExpenseItem(expenseItem: items[index]);
          child: Container(
            // TODO: No need for parent widget [Padding] when we have Container here,
            // which has "padding" param
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

                          context
                              .read<ExpenseProvider>()
                              .setEditingIndex(index);

                          Navigator.of(context).pushNamed(Routes.editExpense);

                          // CHECK COMMENTS IN THE editExpense, this is the right way to do it
                          // context
                          //     .read<AddExpenseProvider>()
                          //     .editExpense(itemsToDisplay[index], ctx);
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

// Example loading widget, we can declare it as private widget because it will only be used here
class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Add Your Expanses'),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(context.watch<ExpenseProvider>().error!),
    );
  }
}
