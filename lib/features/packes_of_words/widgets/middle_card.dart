import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlads_cards/general_blocs/image_search_api/image_search_api_bloc.dart';
import 'package:vlads_cards/general_functions/tts.dart';

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
                    onTap: () async {
                      await speak(words[index]['english']);
                    },
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  words[index]['example'],
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: const Color.fromARGB(255, 94, 94, 94),
                    fontWeight: FontWeight.w500,
                  ),
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
                        child: BlocBuilder<ImageSearchApiBloc,
                            ImageSearchApiState>(
                          builder: (context, state) {
                            if (state is ImageSearchApiSuccess) {
                              return Image.network(
                                state.url,
                              );
                            } else if (state is ImageSearchApiProgress) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Image.asset(
                                "assets/flash-card.png",
                              );
                            }
                          },
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
