import 'package:flutter/material.dart';

import 'package:peca_expenses/data/categories.dart';
import 'package:peca_expenses/providers/add_expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:peca_expenses/models/date.dart';

// TODO: Widgets representing screens, should have a suffix "Screen" / "View"
class AddExpense extends StatelessWidget {
  AddExpense({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: Improve code readability
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(70.0),
          child: Text('Add New Expense'),
        ),
      ),
      //
      //
      // ovdje pocinje dodavanje novog
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          // iz providera
          child: Column(
            children: [
              // TODO: Create a widget to serve as a wrapper for all [TextFormField],
              // TODO: refactor everywhere where it's used.
              //veci mi je to posa :D
              // Get it done lil' nigga. :D
              TextFormField(
                initialValue: context.read<AddExpenseProvider>().enteredName,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (newValue) {
                  if (newValue == null ||
                      newValue.isEmpty ||
                      newValue.trim().length <= 1 ||
                      newValue.trim().length > 50) {
                    return 'Invalid input';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  context.read<AddExpenseProvider>().setEnteredName(newValue);
                },
              ),
              // TODO: [context.watch]?
              TextFormField(
                initialValue:
                    context.watch<AddExpenseProvider>().enteredDescription,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Description'),
                ),
                validator: (newValue) {
                  if (newValue == null ||
                      newValue.isEmpty ||
                      newValue.trim().length <= 1 ||
                      newValue.trim().length > 50) {
                    return 'Invalid input';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  context
                      .read<AddExpenseProvider>()
                      .setEnteredDescription(newValue); // iz providera
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Amount'),
                        prefix: Text('\$'),
                      ),
                      keyboardType: TextInputType.number,
                      // TODO: [context.watch]?
                      initialValue: context
                          .watch<AddExpenseProvider>()
                          .enteredAmount, // iz providera
                      validator: (newValue) {
                        if (newValue == null ||
                            newValue.isEmpty ||
                            int.tryParse(newValue) == null ||
                            int.tryParse(newValue)! <= 0) {
                          return 'Invalid input';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        context
                            .read<AddExpenseProvider>()
                            .setEnteredAmount(newValue); // iz providera
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                      value:
                          context.watch<AddExpenseProvider>().selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Icon(
                                    category.value.icon.icon,
                                    color: const Color.fromARGB(255, 43, 5, 18),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(category.value.title),
                                ],
                              ))
                      ],
                      onChanged: (newValue) {
                        context
                            .read<AddExpenseProvider>()
                            .setSelectedCategory(newValue!);
                      }, // iz providera
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    MyDateFormat.formatDate(
                        context.watch<AddExpenseProvider>().selectedDate),
                    // iz providera
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().toLocal(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        if (!context.mounted) {
                          return;
                        }
                        context
                            .read<AddExpenseProvider>()
                            .setSelectedDate(pickedDate);
                      }
                    },
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Color.fromARGB(255, 43, 5, 18),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    // TODO: Here we use [context.watch] since isSending will update it's value
                    // and based on it's new value we need to re-render this button and update it's logic
                    onPressed: context.read<AddExpenseProvider>().isSending
                        ? null
                        : () {
                            _formKey.currentState?.reset();
                            context.read<AddExpenseProvider>().resetValues();
                          },
                    //iz providera
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Color.fromARGB(255, 43, 5, 18)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    // TODO: Check comment above
                    onPressed: context.read<AddExpenseProvider>().isSending
                        ? null
                        : () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final addCompleted = await context
                                  .read<AddExpenseProvider>()
                                  .saveValues();

                              // If added new expense successfully pop only.
                              if (addCompleted && context.mounted) {
                                // No need to pop the new item with Navigator,
                                // The new item which was added is added in line 108 [add_expense_provider],
                                // Then, the [context.watch] in the [expenses_screen] ListView.builder will handle the updating for us,
                                Navigator.of(context).pop();
                              }

                              // else handle error, etc.
                            }
                          }, // iz providera
                    child: context.read<AddExpenseProvider>().isSending
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Add expense'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
