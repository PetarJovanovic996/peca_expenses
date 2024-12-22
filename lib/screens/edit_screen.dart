import 'package:flutter/material.dart';
import 'package:peca_expenses/data/category.dart';
import 'package:peca_expenses/models/date.dart';
import 'package:peca_expenses/models/expense_item.dart';
import 'package:peca_expenses/providers/expense_provider.dart';
import 'package:peca_expenses/widgets/app_bars/my_app_bar.dart';
import 'package:peca_expenses/widgets/custom_text_form_field.dart';
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

  // done: Now we don't need for this.
  // final ExpenseItem item;

  @override
  EditExpenseScreenState createState() => EditExpenseScreenState();
}

class EditExpenseScreenState extends State<EditExpenseScreen> {
  late String name;
  late String description;
  late String amount;
  late DateTime date;
  late Category category;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final index = context.read<ExpenseProvider>().editingIndex!;
    final item = context.read<ExpenseProvider>().expenseItems[index];

    name = item.name;
    description = item.description;
    amount = item.amount;
    date = item.date;
    category = item.category;
  }

  @override
  Widget build(BuildContext context) {
    // dodao zbog button/a
    final index = context.read<ExpenseProvider>().editingIndex!;
    final item = context.read<ExpenseProvider>().expenseItems;
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Edit Expense',
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                initialValue: name,
                keyboardType: TextInputType.text,
                maxLength: 50,
                label: 'Name',
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
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomTextFormField(
                  keyboardType: TextInputType.text,
                  initialValue: description,
                  maxLength: 50,
                  label: 'Description',
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
                    child: CustomTextFormField(
                      label: 'Amount',
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
              if (context.watch<ExpenseProvider>().error != null)
                Text(
                  context.watch<ExpenseProvider>().error.toString(),
                  style: TextStyle(color: Colors.red),
                ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final updatedItem = ExpenseItem(
                      id: item[index].id,
                      name: name,
                      description: description,
                      amount: amount,
                      date: date,
                      category: category,
                    );

                    final updated = await context
                        .read<ExpenseProvider>()
                        .updateExpense(updatedItem);

                    // done: No need to parse [updatedItem] on pop(), refactor.
                    //onda mi se ne prebaci

                    // Navigator.of(context).pop(updatedItem);

                    if (updated && context.mounted) {
                      Navigator.of(context).pop();
                      context.read<ExpenseProvider>().loadItems();
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
