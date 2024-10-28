import 'package:flutter/material.dart';

import 'package:peca_expenses/data/categories.dart';
import 'package:peca_expenses/providers/add_expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:peca_expenses/models/date.dart';

class AddExpense extends StatelessWidget {
  AddExpense({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              TextFormField(
                initialValue: context.watch<AddExpenseProvider>().enteredName,
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
              Column(
                children: [
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
                ],
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
                                  Icon(category.value.icon.icon),
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
                    MyDateFormat().formatDate(
                        context.watch<AddExpenseProvider>().selectedDate),
                    // iz providera
                    style: const TextStyle(fontSize: 16),
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
                    icon: const Icon(Icons.calendar_month_outlined),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                      context.read<AddExpenseProvider>().resetValues();
                    },
                    //iz providera
                    child: const Text('Reset'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<AddExpenseProvider>().saveValues(context);
                      }
                    }, // iz providera
                    child: const Text('Add expense'),
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
