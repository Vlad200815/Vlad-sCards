import 'package:flutter/material.dart';

class ForgotPswdScreen extends StatelessWidget {
  const ForgotPswdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "This page is in progress...",
            style: TextStyle(fontSize: 25),
          ),
          Image.asset("assets/kiss_cat.webp"),
        ],
      ),
    );
  }
}
