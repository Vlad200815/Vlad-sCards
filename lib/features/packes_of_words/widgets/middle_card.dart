import 'package:flutter/material.dart';

class MiddleCard extends StatelessWidget {
  const MiddleCard({
    required this.loadedItmes,
    required this.words,
    required this.imagePath,
    required this.imageHeight,
    required this.imageWidth,
    required this.width,
    required this.height,
    required this.topSizedBox,
    required this.volumnButtonSize,
    super.key,
  });

  final int loadedItmes;
  final List<Map<String, dynamic>> words;
  final String imagePath;
  final double width;
  final double height;
  final double topSizedBox;
  final double volumnButtonSize;
  final double imageWidth;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    int loadedItems = loadedItmes;

    final theme = Theme.of(context);
    List<Widget> cards = List.generate(
      loadedItems,
      (int index) {
        index = 3;
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
                      color: theme.colorScheme.primary,
                      size: volumnButtonSize,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    words[index]["english"],
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Text(
                words[index]['example'],
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: const Color.fromARGB(255, 94, 94, 94),
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
                        words[index]['ukrainian'],
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: const Color.fromARGB(255, 94, 94, 94),
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
      },
    );

    return Stack(children: cards);
  }
}
