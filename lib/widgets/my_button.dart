import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double horizontal;
  final void Function()? onPressed;
  final String text;

  const MyButton({
    required this.horizontal,
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: 20,
        ),
        onPressed: onPressed,
        color: theme.colorScheme.onPrimary,
        child: Text(
          text,
          style: theme.textTheme.bodyLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
