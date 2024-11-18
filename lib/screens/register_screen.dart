import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peca_expenses/providers/auth_provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            await context
                                .read<AuthProvider>()
                                .registerWithEmailPassword(
                                  context.read<AuthProvider>().email,
                                  context.read<AuthProvider>().password,
                                );
                            if (!context.mounted) {
                              return;
                            }
                            Navigator.pushReplacementNamed(
                                context, 'login-screen');
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Registration failed')));
                          }
                        }
                      },
                      child: const Text('Register'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, 'loginscreen');
                          context.read<AuthProvider>().resetValues();
                        },
                        child: const Text('Go back'))
                  ],
                ),
              ]),
            )));
  }
}
