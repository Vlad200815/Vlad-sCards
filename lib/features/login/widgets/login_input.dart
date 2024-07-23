import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const LoginInput({
    this.suffixIcon,
    required this.prefixIcon,
    required this.hintText,
    required this.obscureText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
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
