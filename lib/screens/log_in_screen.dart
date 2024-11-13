// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

//import 'package:peca_expenses/data/categories.dart';
//import 'package:peca_expenses/providers/add_expense_provider.dart';
//import 'package:peca_expenses/providers/filters_provider.dart';
import 'package:provider/provider.dart';
//import 'package:peca_expenses/models/date.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:peca_expenses/providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: context.read<AuthProvider>().email,
                onChanged: (newValue) {
                  context.read<AuthProvider>().setEmail(newValue);
                },
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (newValue) {
                  if (newValue == null ||
                      newValue.isEmpty ||
                      newValue.trim().length <= 1) {
                    return 'Invalid E-mail adress';
                  }
                  return null;
                },
              ),
              const Padding(padding: EdgeInsets.all(8)),
              TextFormField(
                initialValue: context.read<AuthProvider>().password,
                onChanged: (newValue) {
                  context.read<AuthProvider>().setPassword(newValue);
                },
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (newValue) {
                  if (newValue == null ||
                      newValue.isEmpty ||
                      newValue.trim().length <= 4) {
                    return 'Invalid password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        try {
                          await context
                              .read<AuthProvider>()
                              .signInWithEmailPassword(
                                context.read<AuthProvider>().email,
                                context.read<AuthProvider>().password,
                              );
                          if (!context.mounted) {
                            return;
                          }
                          Navigator.pushReplacementNamed(context, 'expenses');

                          // Otići na home ekran
                        } catch (error) {
                          //login error
                          //odje pokazuje gresku
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login failed')));
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'register');
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
