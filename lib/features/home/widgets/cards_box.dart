import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardsBox extends StatelessWidget {
  const CardsBox({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/cards_list_screen'),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: 280,
            height: 60,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              border: Border.all(
                color: theme.colorScheme.inversePrimary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Show all the cards",
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.inversePrimary,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  CupertinoIcons.chevron_down,
                  color: theme.colorScheme.inversePrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
