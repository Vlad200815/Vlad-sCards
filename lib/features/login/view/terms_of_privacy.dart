import 'package:flutter/material.dart';

class TermsOfPrivacyScreen extends StatelessWidget {
  const TermsOfPrivacyScreen({super.key});

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
          Image.asset("assets/dance_cat.webp"),
        ],
      ),
    );
  }
}
