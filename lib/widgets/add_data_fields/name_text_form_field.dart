import 'package:flutter/material.dart';

import 'package:peca_expenses/providers/expense_provider.dart';
import 'package:peca_expenses/widgets/custom_text_form_field.dart';

import 'package:provider/provider.dart';

class NameTextFormField extends StatelessWidget {
  const NameTextFormField({super.key});

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
