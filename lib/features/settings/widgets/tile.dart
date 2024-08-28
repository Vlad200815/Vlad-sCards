import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Widget icon;

  const MyTile({
    required this.icon,
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
              color: theme.colorScheme.onTertiary,
              border: Border.all(
                color: theme.colorScheme.onTertiary,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(text, style: theme.textTheme.bodyLarge),
              const SizedBox(width: 50),
              icon
            ],
          ),
        ),
      ),
    );
  }
}
