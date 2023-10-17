import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelTitle;
  final String hintText;
  final bool enabled;
  final bool isObscure;
  final TextInputType keyboardType;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelTitle,
    required this.hintText,
    this.enabled = true,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Empty field';
        }
        return null;
      },
      keyboardType: keyboardType,
      obscureText: isObscure,
      controller: controller,
      cursorColor: Colors.blue.shade700,
      autocorrect: false,
      enableSuggestions: true,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelTitle,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.black)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
