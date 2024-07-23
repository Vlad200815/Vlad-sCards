import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final RegExp validationRegExp;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const LoginInput({
    required this.controller,
    required this.keyboardType,
    this.suffixIcon,
    required this.validationRegExp,
    required this.prefixIcon,
    required this.hintText,
    required this.obscureText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value != null && validationRegExp.hasMatch(value)) {
          return null;
        }
        return "Enter a valid ${hintText.toLowerCase()}";
      },
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 16, color: Colors.grey[400]),
        filled: true,
      ),
    );
  }
}
