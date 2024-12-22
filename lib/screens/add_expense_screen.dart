import 'package:flutter/material.dart';
import 'package:peca_expenses/providers/expense_provider.dart';
import 'package:peca_expenses/widgets/app_bars/my_app_bar.dart';
import 'package:peca_expenses/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:peca_expenses/models/date.dart';
import 'package:peca_expenses/data/categories.dart';

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
              const _NameTextFormField(),
              // Ok je skroz kako si odradio, ove mini wrappere za zasebna polja,
              // al uglavnom je praksa da onda kad si napravio [CustomTextFormField]
              // da ove preostale definises u istom fajlu dje ih koristis.
              // Dakle mozes da prebacis ove [NameTextFormField] i [Descr..] da budu u ovaj fajl

              // Zbog toga sto je tebi glavni widget tu [CustomTextFormField], ovi wrapperi su super
              // i skroz je ok da se tako odradi, samo nema potrebe da ti budu u zaseban fajl i kao zaseban widget

              // dodacu u dnu ovog fajla da vidis primjer, kako da ih prebacis.

              const _DescriptionTextFormField(),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: _AmountTextFormField(),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _CategoryDropdownFormField(),
                  )
                ],
              ),
              const _SelectDateField(),
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

// done: Check example:
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

class _DescriptionTextFormField extends StatelessWidget {
  const _DescriptionTextFormField();

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      keyboardType: TextInputType.text,
      initialValue: context.read<ExpenseProvider>().enteredDescription,
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
      onChanged: (newValue) {
        context
            .read<ExpenseProvider>()
            .setEnteredDescription(newValue); // iz providera
      },
    );
  }
}

class _SelectDateField extends StatelessWidget {
  const _SelectDateField();

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(MyDateFormat.formatDate(
              context.watch<ExpenseProvider>().selectedDate)),
          // iz providera

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
                context.read<ExpenseProvider>().setSelectedDate(pickedDate);
              }
            },
            icon: const Icon(
              Icons.calendar_month_outlined,
              color: Color.fromARGB(255, 43, 5, 18),
            ),
          )
        ]);
  }
}

class _CategoryDropdownFormField extends StatelessWidget {
  const _CategoryDropdownFormField();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: context.watch<ExpenseProvider>().selectedCategory,
      items: [
        // for (final category in categories2)
        for (final category in categories.entries)
          DropdownMenuItem(
              // value: category,
              value: category.value,
              child: Row(
                children: [
                  Icon(
                    // category.icon.icon,
                    category.value.icon.icon,
                    color: const Color.fromARGB(255, 43, 5, 18),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(category.value.title),
                  // Text(toFirstUpperLetter(category.title)),
                ],
              ))
      ],
      onChanged: (newValue) {
        context.read<ExpenseProvider>().setSelectedCategory(newValue!);
      }, // iz providera
    );
  }
}

// String toFirstUpperLetter(String input) {
//   String firstLetter = input.substring(0, 1);
//   return firstLetter.toUpperCase() + input.substring(1);
// }

class _AmountTextFormField extends StatelessWidget {
  const _AmountTextFormField();

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      label: 'Amount',
      keyboardType: TextInputType.number,
      // done: [context.watch]?
      initialValue:
          context.read<ExpenseProvider>().enteredAmount, // iz providera
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
            .read<ExpenseProvider>()
            .setEnteredAmount(newValue); // iz providera
      },
    );
  }
}
