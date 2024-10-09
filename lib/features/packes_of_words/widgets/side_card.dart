import 'package:flutter/material.dart';
import 'package:vlads_cards/general_functions/tts.dart';

class SideCard extends StatelessWidget {
  const SideCard({
    required this.ukrainian,
    required this.example,
    required this.english,
    required this.imageHeight,
    required this.imageWidth,
    required this.width,
    required this.height,
    required this.volumnButtonSize,
    super.key,
  });

  final String ukrainian;
  final String example;
  final String english;
  final double width;
  final double height;
  final double volumnButtonSize;
  final double imageWidth;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: topSizedBox),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await speak(english);
                },
                child: Icon(
                  Icons.volume_up_outlined,
                  color: theme.colorScheme.primary,
                  size: volumnButtonSize,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                english,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                ukrainian,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: const Color.fromARGB(255, 94, 94, 94),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              example,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall!.copyWith(
                color: const Color.fromARGB(255, 94, 94, 94),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
