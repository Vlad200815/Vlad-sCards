import 'package:flutter/material.dart';

class WordInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final void Function()? onEditingComplete;
  final bool? enabled;

  const WordInput({
    required this.enabled,
    required this.onEditingComplete,
    required this.hintText,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: TextField(
            enableSuggestions: true,
            enabled: enabled,
            autocorrect: true,
            onEditingComplete: onEditingComplete,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              // hintStyle: TextStyle(color: theme.colorScheme.onPrimary),
              fillColor: theme.colorScheme.onPrimary,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
      ),
    );
  }
}
