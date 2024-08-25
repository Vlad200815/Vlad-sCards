import 'package:flutter/material.dart';

class KnowOrNotContainer extends StatelessWidget {
  final bool visible;
  final Color color;
  final String text;

  const KnowOrNotContainer({
    required this.text,
    required this.color,
    required this.visible,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: color, width: 3.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            text,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
