import 'package:flutter/material.dart';
import 'package:peca_expenses/providers/expense_provider.dart';
import 'package:peca_expenses/widgets/add_data_fields/select_date_field.dart';
import 'package:peca_expenses/widgets/app_bars/add_expense_app_bar.dart';
import 'package:peca_expenses/widgets/add_data_fields/amount_text_form_field.dart';
import 'package:peca_expenses/widgets/add_data_fields/category_dropdown_form_field.dart';
import 'package:peca_expenses/widgets/add_data_fields/descr_text_form_field.dart';
import 'package:peca_expenses/widgets/add_data_fields/name_text_form_field.dart';
import 'package:provider/provider.dart';

// done: Widgets representing screens, should have a suffix "Screen" / "View"
class AddExpenseScreen extends StatelessWidget {
  AddExpenseScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // done: Improve code readability
    return Scaffold(
      appBar: const AddExpenseAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          // iz providera
          child: Column(
            children: [
              const NameTextFormField()
              //pitanje: nije pitanje, ali ovako da je univerzalno ime za komentar ovaj put :D
              // zeznuh se kod wrapping TextFormField / pa za svako prvo napravih odvojeni widget
              //neka ostane sad da ne brisem - a i urednije je :D

              // done: Create a widget to serve as a wrapper for all [TextFormField],
              // done: refactor everywhere where it's used.
              //veci mi je to posa :D
              // Get it done lil' nigga. :D
              ,
              // done: [context.watch]?
              const DescrTextFormField(),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: AmountTextFormField(),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: CategoryDropdownFormField(),
                  )
                ],
              ),
              const SelectDateField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    // done: Here we use [context.watch] since isSending will update it's value
                    // and based on it's new value we need to re-render this button and update it's logic
                    onPressed: context.watch<ExpenseProvider>().isSending
                        ? null
                        : () {
                            _formKey.currentState?.reset();
                            context.read<ExpenseProvider>().resetValues();
                          },
                    //iz providera
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Color.fromARGB(255, 43, 5, 18)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    // done: Check comment above
                    onPressed: context.watch<ExpenseProvider>().isSending
                        ? null
                        : () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final addCompleted = await context
                                  .read<ExpenseProvider>()
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
                    child: context.read<ExpenseProvider>().isSending
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
