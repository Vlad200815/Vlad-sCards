import 'package:flutter/material.dart';

class MyBotton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const MyBotton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 3.7,
          vertical: 10,
        ),
        onPressed: onPressed,
        color: theme.colorScheme.onPrimary,
        child: Text(
          text,
          style: theme.textTheme.bodyLarge,
        ),
      ),
    );
  }
}