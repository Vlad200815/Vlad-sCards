import 'package:flutter/material.dart';

class Flame extends StatelessWidget {
  const Flame({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          "assets/flame.webp",
          scale: 10,
        ),
        Text(
          "500",
          style: TextStyle(
            color: theme.colorScheme.inversePrimary,
          ),
        ),
      ],
    );
  }
}
