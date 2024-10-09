import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vlads_cards/general_blocs/image_search_api/image_search_api_bloc.dart';
import 'package:vlads_cards/general_functions/generall_functions.dart';
import '../../../general_blocs/save_words_bloc/save_words_bloc.dart';
import '../widgets/widgets.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  List<GlobalKey<FlipCardState>> cardKeys = [];
  List<Map<String, dynamic>> cardsList = [];
  List<String> query = [];
  List<String> readded = [];

  int added = 0;

  bool isRight = false;
  bool isLeft = false;

  final Talker talker = GetIt.I<Talker>();

  @override
  void initState() {
    context.read<SaveWordsBloc>().add(OnGetLearnWords());
    super.initState();
  }

  void resetCard(int index) {
    if (cardKeys[index].currentState != null && index < cardKeys.length) {
      cardKeys[index].currentState?.controller?.reset();
    }
  }

  int cardsExistingLength(int cardsIndex) {
    if (cardsIndex == 2) {
      return 2;
    } else if (cardsIndex == 1) {
      return 1;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //List variables, actually it is all cards
    List<Widget> cards = List.generate(
      cardsList.length,
      (int index) {
        query.add(cardsList[index]['english']);

        GetIt.I<Talker>().debug("query: $query");
        return FlipCard(
          key: cardKeys[index],
          fill: Fill
              .fillBack, // Fill the back side of the card to make in the same size as the front.
          direction: FlipDirection.HORIZONTAL, // default
          side: CardSide.FRONT,
          // The side to initially display.
          front: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.onTertiary,
              border: Border.all(
                color: Colors.grey.shade200,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(pi * 1 / -1 / 9),
                      child: KnowOrNotContainer(
                        text: "Understand",
                        color: const Color.fromARGB(255, 11, 171, 16),
                        visible: isRight,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 8.2),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(pi * 1 / 9),
                      child: KnowOrNotContainer(
                        text: "Learn Again",
                        color: Colors.red,
                        visible: isLeft,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<ImageSearchApiBloc, ImageSearchApiState>(
                      builder: (context, state) {
                        if (state is ImageSearchApiSuccess) {
                          return SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.network(
                              state.url,
                              scale: 4,
                            ),
                          );
                        } else if (state is ImageSearchApiProgress) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.asset(
                              'assets/flash-card.png',
                              scale: 4,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.volume_up_outlined,
                            color: theme.colorScheme.primary,
                            size: 30,
                          ),
                          onPressed: () async {
                            //play sound of the word
                            await speak(cardsList[index]['english']!);
                          },
                        ),
                        Text(
                          cardsList[index]['english']!,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          back: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.onTertiary,
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(pi * 1 / -1 / 9),
                      child: KnowOrNotContainer(
                        text: "Understand",
                        color: const Color.fromARGB(255, 11, 171, 16),
                        visible: isRight,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 8.2),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(pi * 1 / 9),
                      child: KnowOrNotContainer(
                        text: "Learn Again",
                        color: Colors.red,
                        visible: isLeft,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 7),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<ImageSearchApiBloc, ImageSearchApiState>(
                      builder: (context, state) {
                        if (state is ImageSearchApiSuccess) {
                          return SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.network(
                              state.url,
                              scale: 4,
                            ),
                          );
                        } else if (state is ImageSearchApiProgress) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.asset(
                              'assets/flash-card.png',
                              scale: 4,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.volume_up_outlined,
                            color: theme.colorScheme.primary,
                            size: 24,
                          ),
                          onPressed: () async {
                            //play sound of the word
                            await speak(cardsList[index]['english']!);
                          },
                        ),
                        Text(
                          cardsList[index]['english']!,
                          style: theme.textTheme.bodySmall!
                              .copyWith(fontSize: 18, color: Colors.grey),
                        ),
                        const SizedBox(width: 24),
                      ],
                    ),
                    Text(
                      cardsList[index]['ukrainian'] ?? 'N/A',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 24,
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 60.0, vertical: 25),
                      child: Divider(
                        color: Color.fromARGB(255, 217, 217, 217),
                        height: 2,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.volume_up_outlined,
                        color: theme.colorScheme.primary,
                        size: 30,
                      ),
                      onPressed: () async {
                        //play sound of the word
                        await speak(cardsList[index]['example']!);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              cardsList[index]['example']!,
                              style: theme.textTheme.bodySmall!
                                  .copyWith(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    //END OF LIST VAR

    //All Screen
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_left_rounded, size: 30),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              const SizedBox(width: 220),
              IconButton(
                icon: const Icon(
                  Icons.water_drop_sharp,
                  size: 30,
                  color: Colors.blue,
                ),
                onPressed: () {},
              ),
            ],
          ),
          BlocListener<SaveWordsBloc, SaveWordsState>(
            listener: (context, state) async {
              if (state is GetLearnWordsSuccess) {
                setState(() {
                  cardsList = List<Map<String, dynamic>>.from(state.words);
                });
                if (cardsList.isNotEmpty) {
                  context.read<ImageSearchApiBloc>().add(
                      OnSearchImageEvent(query: cardsList.first['english']));
                }

                cardKeys = List.generate(
                  cardsList.length,
                  (index) => GlobalKey<FlipCardState>(),
                );
              }
            },
            child: BlocBuilder<SaveWordsBloc, SaveWordsState>(
              builder: (context, state) {
                if (state is GetLearnWordsSuccess) {
                  if (cardsList.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 8,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "There are not cards to learn",
                                style: TextStyle(fontSize: 25),
                              ),
                              Image.asset("assets/cat.webp")
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Flexible(
                    child: CardSwiper(
                      isLoop: false,
                      numberOfCardsDisplayed:
                          cardsExistingLength(cardsList.length),
                      cardsCount: cardsList.length,
                      cardBuilder: (context, index, percentThresholdX,
                          percentThresholdY) {
                        return cards[index];
                      },
                      onSwipe: (previousIndex, currentIndex, direction) {
                        resetCard(previousIndex);
                        if (direction.name == 'right') {
                          setState(() {
                            isRight = false;
                            isLeft = false;

                            context
                                .read<SaveWordsBloc>()
                                .add(OnRemoveTrainingLearWords());
                            if (currentIndex != null) {
                              added++;
                              context
                                  .read<ImageSearchApiBloc>()
                                  .add(OnSearchImageEvent(query: query[added]));
                            }
                          });
                        } else if (direction.name == 'left') {
                          setState(() {
                            isRight = false;
                            isLeft = false;

                            cardsList.add(cardsList[previousIndex]);
                            cardKeys.add(GlobalKey<FlipCardState>());

                            GetIt.I<Talker>().debug(
                                "cardsList.previouseIndex ${cardsList[previousIndex]}");

                            if (currentIndex != null) {
                              readded.add(cardsList[currentIndex]['english']);
                              GetIt.I<Talker>().debug("readded: $readded");
                              added++;
                              context
                                  .read<ImageSearchApiBloc>()
                                  .add(OnSearchImageEvent(query: query[added]));
                            } else if (currentIndex == null) {
                              added = 0;
                            }
                          });
                        }
                        return true;
                      },
                      onSwipeDirectionChange:
                          (horizontalDirection, verticalDivider) {
                        if (horizontalDirection == CardSwiperDirection.right) {
                          setState(() {
                            isRight = true;
                            isLeft = false;
                          });
                        } else if (horizontalDirection ==
                            CardSwiperDirection.left) {
                          setState(() {
                            isLeft = true;
                            isRight = false;
                          });
                        } else {
                          setState(() {
                            isLeft = false;
                            isRight = false;
                          });
                        }
                      },
                      allowedSwipeDirection: const AllowedSwipeDirection.only(
                        left: true,
                        right: true,
                        up: false,
                        down: false,
                      ),
                      maxAngle: 90,
                      onEnd: () {
                        query.clear();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const FinalAlert(
                              title: "Well done, keep moving",
                              content: Text(
                                  "Another porshen of cards will be ready in just a few minuts"),
                              finalMessage: "Yes Sir!",
                            );
                          },
                        );
                      },
                    ),
                  );
                } else if (state is GetLearnWordsProgress) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 2.3),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text("Something went wrong..."));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
