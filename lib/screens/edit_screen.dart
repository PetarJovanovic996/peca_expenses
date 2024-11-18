import 'package:flutter/material.dart';
import 'package:peca_expenses/data/category.dart';
import 'package:peca_expenses/models/date.dart';
import 'package:peca_expenses/models/expense_item.dart';
import 'package:peca_expenses/providers/add_expense_provider.dart';
import 'package:provider/provider.dart';
// import 'package:peca_expenses/providers/add_expense_provider.dart';
// import 'package:provider/provider.dart';

import '../data/categories.dart';
// import 'package:peca_expenses/providers/add_expense_provider.dart';
// import 'package:peca_expenses/providers/filters_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:peca_expenses/models/date.dart';

class EditExpenseScreen extends StatefulWidget {
  const EditExpenseScreen({
    super.key,
  });

  // TODO: Now we don't need for this.
  // final ExpenseItem item;

  @override
  EditExpenseScreenState createState() => EditExpenseScreenState();
}

class EditExpenseScreenState extends State<EditExpenseScreen> {
  // done: Refactor entire logic, think how to implement provider for this.
  // done: Goal is to remove all [TextEditingController] present
  late String name;
  late String description;
  late String amount;
  late DateTime date;
  late Category category;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final index = context.read<AddExpenseProvider>().editingIndex!;
    final item = context.read<AddExpenseProvider>().expenseItems[index];

    name = item.name;
    description = item.description;
    amount = item.amount;
    date = item.date;
    category = item.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(80.0),
          child: Text('Edit Expense'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
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
                onChanged: (value) => name = value,
              ),

              // done: Unnecessary column
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  initialValue: description,
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
                  onChanged: (value) => description = value,
                ),
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
                      initialValue: amount,
                      validator: (newValue) {
                        if (newValue == null ||
                            newValue.isEmpty ||
                            int.tryParse(newValue) == null ||
                            int.tryParse(newValue)! <= 0) {
                          return 'Invalid input';
                        }
                        return null;
                      },
                      onChanged: (value) => amount = value,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                        value: category,
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
                              ),
                            )
                        ],
                        onChanged: (value) => category = value!),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    MyDateFormat.formatDate(date),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != date) {
                        setState(() {
                          date = pickedDate;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Color.fromARGB(255, 43, 5, 18),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final updatedItem = ExpenseItem(
                      // TODO: id should not be added when creating new object, firebase will add it for you
                      // id: id,
                      name: name,
                      description: description,
                      amount: amount,
                      date: date,
                      category: category,
                    );

                    final updated = await context
                        .read<AddExpenseProvider>()
                        .updateExpense(updatedItem);

                    // TODO: No need to parse [updatedItem] on pop(), refactor.
                    //onda mi se ne prebaci

                    // Navigator.of(context).pop(updatedItem);

                    if (updated && context.mounted) {
                      Navigator.of(context).pop();
                      context.read<AddExpenseProvider>().loadItems(context);
                    }
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
