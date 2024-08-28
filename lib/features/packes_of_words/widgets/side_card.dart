import 'package:flutter/material.dart';

import '../../general_blocs/english_words_api_bloc/english_words_api_bloc.dart';

class SideCard extends StatelessWidget {
  const SideCard({
    required this.ukrainian,
    required this.example,
    required this.imagePath,
    required this.english,
    required this.imageHeight,
    required this.imageWidth,
    required this.width,
    required this.height,
    required this.topSizedBox,
    required this.volumnButtonSize,
    super.key,
  });

  final String ukrainian;
  final String example;
  final String imagePath;
  final String english;
  final double width;
  final double height;
  final double topSizedBox;
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
          SizedBox(height: topSizedBox),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.volume_up_outlined,
                  color: theme.colorScheme.onPrimary,
                  size: volumnButtonSize,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                english,
                style: theme.textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Text(
            example,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall!.copyWith(
              color: Colors.grey[400],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: imageWidth,
                    height: imageHeight,
                    child: Image.asset(
                      imagePath,
                    ),
                  ),
                  Text(
                    ukrainian,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
