import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vlads_cards/features/cards_list/view/view.dart';

class CardsBox extends StatelessWidget {
  const CardsBox({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CardsListScreen(),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: 280,
            height: 60,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: theme.colorScheme.outline,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  CupertinoIcons.chevron_down,
                ),
                const SizedBox(width: 12),
                Text(
                  "Показати всі кардки",
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(width: 12),
                const Icon(
                  CupertinoIcons.chevron_down,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
