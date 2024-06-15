import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.obscureText = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14.0, horizontal: 13.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            // borderSide: BorderSide.none,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
