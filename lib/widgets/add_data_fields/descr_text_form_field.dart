import 'package:flutter/material.dart';

import 'package:peca_expenses/providers/expense_provider.dart';
import 'package:peca_expenses/widgets/custom_text_form_field.dart';

import 'package:provider/provider.dart';

class DescrTextFormField extends StatelessWidget {
  const DescrTextFormField({super.key});

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
