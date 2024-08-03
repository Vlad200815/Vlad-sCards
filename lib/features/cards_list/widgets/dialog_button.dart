import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final Widget? widget;
  final String text;
  final Function()? onTap;
  final Color? color;

  const DialogButton({
    required this.color,
    required this.onTap,
    required this.text,
    required this.widget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            const SizedBox(width: 6),
            widget!,
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
