import 'package:flutter/material.dart';
import 'package:peca_expenses/main/routes.dart';
import 'package:peca_expenses/providers/filters_provider.dart';
import 'package:provider/provider.dart';
import 'package:peca_expenses/providers/auth_provider.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const MainAppBar(
      {super.key, this.preferredSize = const Size.fromHeight(kToolbarHeight)});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Center(
        child: Text(
          'My Expenses',
        ),
      ),
      actions: [
        const SizedBox(
          width: 50,
        ),
        TextButton.icon(
          onPressed: () {
            context.read<FiltersProvider>().clearFilters();
          },
          label: const Text(
            'Clear all Filters',
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(
            Icons.filter_alt_off_sharp,
            color: Colors.white,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () async {
            await context.read<AuthProvider>().signOut();
            if (!context.mounted) {
              return;
            }
            // done: Google [Navigator.pushAndRemoveUntil] method
            // done: Update navigator syntax

            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.loginScreen, (Route<dynamic> route) => false);
          },
        ),
      ],
    );
  }
}
