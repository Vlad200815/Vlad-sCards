import 'package:flutter/material.dart';

class WordContainer extends StatelessWidget {
  final void Function()? onPressed;
  final void Function()? onHear;
  final String englishWord;
  final String ukrainWord;

  const WordContainer({
    required this.onHear,
    required this.ukrainWord,
    required this.englishWord,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 80,
      color: Colors.white,
      child: Row(
        children: [
          const SizedBox(width: 15),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Icon(
                    Icons.battery_3_bar_outlined,
                    color: theme.colorScheme.inversePrimary,
                  ),
                ],
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue[100]),
                child: Image.asset(
                  'assets/google_logo.png',
                  scale: 30,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: onHear,
                  icon: const Icon(
                    Icons.volume_up_outlined,
                    size: 24,
                    color: Colors.blue,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    englishWord,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(ukrainWord, style: theme.textTheme.bodySmall),
                ],
              ),
            ],
          ),
          const SizedBox(width: 150),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.more_vert_outlined,
              color: Colors.grey[600],
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
