import 'package:flutter/material.dart';
import 'package:peca_expenses/data/category.dart';
import 'package:peca_expenses/models/date.dart';
import 'package:peca_expenses/models/expense_item.dart';
// import 'package:peca_expenses/providers/add_expense_provider.dart';
// import 'package:provider/provider.dart';

import '../data/categories.dart';
// import 'package:peca_expenses/providers/add_expense_provider.dart';
// import 'package:peca_expenses/providers/filters_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:peca_expenses/models/date.dart';

class EditExpenseScreen extends StatefulWidget {
  const EditExpenseScreen({super.key, required this.item});
  final ExpenseItem item;

  @override
  EditExpenseScreenState createState() => EditExpenseScreenState();
}

class EditExpenseScreenState extends State<EditExpenseScreen> {
  // TODO: Refactor entire logic, think how to implement provider for this.
  // TODO: Goal is to remove all [TextEditingController] present
  late String name;
  late String description;
  late String amount;
  late DateTime date;
  late Category category;

  @override
  void initState() {
    super.initState();
    name = widget.item.name;
    description = widget.item.description;
    amount = widget.item.amount;
    date = widget.item.date;
    category = widget.item.category;
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
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              controller: TextEditingController(text: name),
              onChanged: (value) => name = value,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Description'),
              controller: TextEditingController(text: description),
              onChanged: (value) => description = value,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Amount'),
                    controller: TextEditingController(text: '\$$amount'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => amount = value,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: DropdownButtonFormField(
                      value: widget.item.category,
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
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                IconButton(
                  //onChanged: (value) => category = value!

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
                  icon: const Icon(Icons.calendar_month_outlined),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final updatedItem = ExpenseItem(
                  id: widget.item.id,
                  name: name,
                  description: description,
                  amount: amount,
                  date: date,
                  category: category,
                );
                // TODO: No need to parse [updatedItem] on pop(), refactor.
                Navigator.of(context).pop(updatedItem);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
