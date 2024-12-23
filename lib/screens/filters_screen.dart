import 'package:flutter/material.dart';

import 'package:peca_expenses/providers/expense_provider.dart';

import 'package:peca_expenses/providers/filters_provider.dart';
import 'package:provider/provider.dart';
import 'package:peca_expenses/models/date.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: TextButton.icon(
          onPressed: () {
            context.read<FiltersProvider>().clearFilters();
          },
          label: const Text(
            'Clear all Filters',
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(
            Icons.filter_alt_off_sharp,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Use Your Filter'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<FiltersProvider>().setTodaysDate();

                  Navigator.of(context).pop();
                },
                child: Text('Today'),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<FiltersProvider>().setThisWeek();
                  context.read<FiltersProvider>().filterByCurrentWeek(
                      context.read<ExpenseProvider>().expenseItems);
                  Navigator.of(context).pop();
                },
                child: Text('This Week'),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<FiltersProvider>().setThisMonth();
                  context.read<FiltersProvider>().filterByCurrentMonth(
                      context.read<ExpenseProvider>().expenseItems);
                  Navigator.of(context).pop();
                },
                child: Text('This Month'),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text((context.watch<FiltersProvider>().selectedDate != null)
                  ? MyDateFormat.formatDate(
                      context.watch<FiltersProvider>().selectedDate!)
                  : 'Enter your Date'),
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
                    context.read<FiltersProvider>().setSelectedDate(pickedDate);
                    context.read<FiltersProvider>().filterByDate(
                        context.read<ExpenseProvider>().expenseItems);
                    //
                    //
                    //ovo
                  }
                },
                icon: const Icon(Icons.edit_calendar_sharp),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text((context.watch<FiltersProvider>().fromDate != null &&
                      context.watch<FiltersProvider>().toDate != null)
                  ? '${MyDateFormat.formatDate(
                      context.watch<FiltersProvider>().fromDate!,
                    )} - ${MyDateFormat.formatDate(
                      context.watch<FiltersProvider>().toDate!,
                    )}'
                  : 'Set your Data Range'),
              IconButton(
                onPressed: () async {
                  final pickedDate = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2027),
                  );
                  if (pickedDate != null) {
                    if (!context.mounted) {
                      return;
                    }
                    context
                        .read<FiltersProvider>()
                        .setStartDate(pickedDate.start);
                    context.read<FiltersProvider>().setEndDate(pickedDate.end);
                    context.read<FiltersProvider>().filterByRange(
                        context.read<ExpenseProvider>().expenseItems);
                  }
                },
                icon: const Icon(Icons.calendar_month_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
