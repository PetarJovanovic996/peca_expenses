import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final String? Function(String?)? validator;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final int? maxLength;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.validator,
    required this.onChanged,
    required this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLength: maxLength,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefix: label == 'Amount' ? const Text('\$') : null,
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
