import 'package:flutter/material.dart';

class MiddleCard extends StatelessWidget {
  const MiddleCard({
    required this.english,
    required this.imageHeight,
    required this.imageWidth,
    required this.width,
    required this.height,
    required this.topSizedBox,
    required this.volumnButtonSize,
    super.key,
  });

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
    return Stack(
      children: [
        Container(
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
                "The young fish was really fast",
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
                          'assets/flash-card.png',
                        ),
                      ),
                      Text(
                        "риба",
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
        ),
      ],
    );
  }
}
