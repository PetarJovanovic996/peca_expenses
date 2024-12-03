import 'package:flutter/material.dart';

import 'package:peca_expenses/providers/expense_provider.dart';
import 'package:peca_expenses/widgets/custom_text_form_field.dart';

import 'package:provider/provider.dart';

class AmountTextFormField extends StatelessWidget {
  const AmountTextFormField({super.key});

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
