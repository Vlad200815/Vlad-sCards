import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final String text;
  final String hint;
  final Color? textColor;

  const Box({
    super.key,
    required this.text,
    required this.hint,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 110,
      height: 70,
      decoration: BoxDecoration(
        color: theme.colorScheme.onTertiary,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              hint,
              style: TextStyle(
                color: textColor,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
