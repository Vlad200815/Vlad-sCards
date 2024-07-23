import 'package:flutter/material.dart';

class SpetialButton extends StatelessWidget {
  final Widget widget;
  final String text;

  const SpetialButton({
    required this.text,
    required this.widget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 7,
        ),
        child: Ink(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 35, child: widget),
              const SizedBox(width: 20),
              Text(text, style: theme.textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
