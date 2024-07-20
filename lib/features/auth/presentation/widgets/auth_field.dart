import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  const AuthField({
    super.key,
    required this.controller,
    required this.hint, 
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hint is missing";
        }
        return null;
      },
    );
  }
}
