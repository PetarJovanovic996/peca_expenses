import 'package:flutter/material.dart';
import 'package:peca_expenses/providers/expense_provider.dart';
import 'package:peca_expenses/widgets/add_data_fields/select_date_field.dart';

import 'package:peca_expenses/widgets/add_data_fields/amount_text_form_field.dart';
import 'package:peca_expenses/widgets/add_data_fields/category_dropdown_form_field.dart';
import 'package:peca_expenses/widgets/add_data_fields/descr_text_form_field.dart';
import 'package:peca_expenses/widgets/add_data_fields/name_text_form_field.dart';
import 'package:peca_expenses/widgets/app_bars/my_app_bar.dart';
import 'package:peca_expenses/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

// done: Widgets representing screens, should have a suffix "Screen" / "View"
class AddExpenseScreen extends StatelessWidget {
  AddExpenseScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Add New Expense',
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          // iz providera
          child: Column(
            children: [
              const NameTextFormField(),
              //pitanje: nije pitanje, ali ovako da je univerzalno ime za komentar ovaj put :D
              // zeznuh se kod wrapping TextFormField / pa za svako prvo napravih odvojeni widget
              //neka ostane sad da ne brisem - a i urednije je :D

              // Ok je skroz kako si odradio, ove mini wrappere za zasebna polja,
              // al uglavnom je praksa da onda kad si napravio [CustomTextFormField]
              // da ove preostale definises u istom fajlu dje ih koristis.
              // Dakle mozes da prebacis ove [NameTextFormField] i [Descr..] da budu u ovaj fajl

              // Zbog toga sto je tebi glavni widget tu [CustomTextFormField], ovi wrapperi su super
              // i skroz je ok da se tako odradi, samo nema potrebe da ti budu u zaseban fajl i kao zaseban widget

              // dodacu u dnu ovog fajla da vidis primjer, kako da ih prebacis.

              const DescriptionTextFormField(),
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

// TODO: Check example:
// We can define it as a private widget [_] because it's just a helper wrapper,
// specific for this screen, it probably won't be used in this same exact way in other places.
class _NameTextFormField extends StatelessWidget {
  const _NameTextFormField();

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
        keyboardType: TextInputType.text,
        initialValue: context.read<ExpenseProvider>().enteredName,
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
        onChanged: (newValue) {
          context.read<ExpenseProvider>().setEnteredName(newValue);
        });
  }
}
