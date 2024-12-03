import 'package:flutter/material.dart';
import 'package:peca_expenses/providers/expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:peca_expenses/models/date.dart';

class SelectDateField extends StatelessWidget {
  const SelectDateField({super.key});

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
