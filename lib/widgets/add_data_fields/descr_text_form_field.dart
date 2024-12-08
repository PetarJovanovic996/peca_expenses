import 'package:flutter/material.dart';

import 'package:peca_expenses/providers/expense_provider.dart';
import 'package:peca_expenses/widgets/custom_text_form_field.dart';

import 'package:provider/provider.dart';

// done: Never short words in half, it can lead to decrease in readability in bigger projects.
// It's always better to use full name, even if it's long. It's better to make it be self-explanatory as much as possible.

// done: For example, whenever you are in a situation that the name or anything is not self-explanatory
// Try to add comments in your code for future uses and for other developers who work on project.
// You can use either [//] for basic comments or [///] for "documentation" comments. Example shown below.

class DescriptionTextFormField extends StatelessWidget {
  /// Used in [AddExpenseScreen], representing the description text field.
  const DescriptionTextFormField({super.key});

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
