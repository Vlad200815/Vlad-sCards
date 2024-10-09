import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vlads_cards/general_blocs/english_words_api_bloc/english_words_api_bloc.dart';
import 'package:vlads_cards/features/packes_of_words/packes_of_words.dart';
import 'package:vlads_cards/features/packes_of_words/widgets/side_card.dart';
import 'package:vlads_cards/general_blocs/image_search_api/image_search_api_bloc.dart';
import 'package:vlads_cards/general_blocs/save_words_bloc/save_words_bloc.dart';

class ChooseWordsScreen extends StatefulWidget {
  const ChooseWordsScreen({super.key});

  @override
  State<ChooseWordsScreen> createState() => _ChooseWordsScreenState();
}

class _ChooseWordsScreenState extends State<ChooseWordsScreen> {
  final talker = GetIt.I<Talker>();

  List<Map<String, dynamic>> words = [];
  List<Map<String, dynamic>> learnWords = [];
  List<Map<String, dynamic>> knewWords = [];

  int loadedItems = 1;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String level = ModalRoute.of(context)?.settings.arguments as String;
    level = level.toUpperCase();

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: BlocListener<SaveWordsBloc, SaveWordsState>(
        listener: (context, state) {
          if (state is GetLearnWordsSuccess) {
            learnWords = state.words;
          }
        },
        child: BlocListener<EnglishWordsApiBloc, EnglishWordsApiState>(
          listener: (context, state) {
            if (state is EnglishWordsApiSuccess) {
              setState(() {
                words = List<Map<String, dynamic>>.from(
                  state.response.data["words"],
                );
                talker.warning("words: $words");
              });

              if (learnWords.isEmpty) {
                learnWords.add(
                  {
                    "english": "add something",
                    "ukrainian": "",
                    "example": "",
                  },
                );
                learnWords.add(
                  {
                    "english": "add something",
                    "ukrainian": "",
                    "example": "",
                  },
                );
                learnWords.add(
                  {
                    "english": "add something",
                    "ukrainian": "",
                    "example": "",
                  },
                );
              }
            }
            if (knewWords.isEmpty) {
              knewWords.add(
                {
                  "english": "add something",
                  "ukrainian": "",
                  "example": "",
                },
              );
              knewWords.add(
                {
                  "english": "add something",
                  "ukrainian": "",
                  "example": "",
                },
              );
              knewWords.add(
                {
                  "english": "add something",
                  "ukrainian": "",
                  "example": "",
                },
              );
            }
          },
          child: BlocBuilder<EnglishWordsApiBloc, EnglishWordsApiState>(
            builder: (context, state) {
              if (state is EnglishWordsApiSuccess) {
                context.read<ImageSearchApiBloc>().add(
                      OnSearchImageEvent(
                        query: words[0]['english'],
                      ),
                    );

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20, top: 35),
                      color: theme.colorScheme.onPrimaryFixed,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              CupertinoIcons.chevron_back,
                              color: theme.colorScheme.inversePrimary,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.book_circle,
                                color: Colors.blue[300],
                                size: 30,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "$level Words",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.water_drop_rounded,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    //FIRST CARD

                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          child: DragTarget<Map<String, dynamic>>(
                            builder: (context, candidateData, rejectedData) {
                              return Draggable(
                                data: learnWords.last,
                                childWhenDragging: learnWords.isNotEmpty
                                    ? Material(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SideCard(
                                          ukrainian:
                                              learnWords[learnWords.length - 2]
                                                  ["ukrainian"],
                                          example:
                                              learnWords[learnWords.length - 2]
                                                  ["example"],
                                          english:
                                              learnWords[learnWords.length - 2]
                                                  ["english"],
                                          imageWidth: 35,
                                          imageHeight: 35,
                                          volumnButtonSize: 20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              140,
                                          height: 160,
                                        ),
                                      )
                                    : const SizedBox(
                                        child: Center(
                                          child: Text(
                                            "No words have been added yet",
                                          ),
                                        ),
                                      ),
                                feedback: learnWords.isNotEmpty
                                    ? Material(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SideCard(
                                          ukrainian:
                                              learnWords.last["ukrainian"],
                                          example: learnWords.last["example"],
                                          english: learnWords.last["english"],
                                          imageWidth: 35,
                                          imageHeight: 35,
                                          volumnButtonSize: 20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              140,
                                          height: 160,
                                        ),
                                      )
                                    : const SizedBox(
                                        child: Center(
                                          child: Text(
                                            "No words have been added yet",
                                          ),
                                        ),
                                      ),
                                child: learnWords.isNotEmpty
                                    ? Material(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SideCard(
                                          ukrainian:
                                              learnWords.last["ukrainian"],
                                          example: learnWords.last["example"],
                                          english: learnWords.last["english"],
                                          imageWidth: 35,
                                          imageHeight: 35,
                                          volumnButtonSize: 20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              140,
                                          height: 160,
                                        ),
                                      )
                                    : const SizedBox(),
                              );
                            },
                            onAcceptWithDetails: (card) {
                              setState(() {
                                knewWords.remove(card.data);
                                context
                                    .read<SaveWordsBloc>()
                                    .add(OnRemoveKnewWords());
                                learnWords.add(card.data);

                                context
                                    .read<SaveWordsBloc>()
                                    .add(OnSaveLearnWords(listMap: card.data));
                                words.remove(card.data);
                              });
                            },
                          ),
                        ),
                        Positioned(
                          bottom: -25,
                          child: Container(
                            width: 130,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 215, 242, 255),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.auto_awesome_motion,
                                  color: Color.fromARGB(255, 0, 175, 6),
                                  size: 35,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Learn",
                                  style: theme.textTheme.bodySmall!.copyWith(
                                    color: const Color.fromARGB(255, 0, 175, 6),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    //MIDDLE CARD
                    const SizedBox(height: 35),

                    Draggable<Map<String, dynamic>>(
                      data: words.first,
                      childWhenDragging: Material(
                        child: words.length > 1
                            ? MiddleCard(
                                loadedItmes: loadedItems,
                                words: words,
                                imagePath: "assets/flash-card.png",
                                imageHeight: 55,
                                imageWidth: 55,
                                width: MediaQuery.of(context).size.width - 60,
                                height: 200,
                                topSizedBox: 50,
                                volumnButtonSize: 25,
                              )
                            : const SizedBox(
                                child: Text("Set MiddleCard whithout texts"),
                              ),
                      ),
                      feedback: Material(
                        borderRadius: BorderRadius.circular(15),
                        child: MiddleCard(
                          loadedItmes: loadedItems,
                          words: words,
                          imagePath: "assets/flash-card.png",
                          imageHeight: 55,
                          imageWidth: 55,
                          topSizedBox: 50,
                          volumnButtonSize: 25,
                          width: MediaQuery.of(context).size.width - 60,
                          height: 200,
                        ),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(15),
                        child: MiddleCard(
                          loadedItmes: loadedItems,
                          words: words,
                          imagePath: "assets/flash-card.png",
                          imageHeight: 55,
                          imageWidth: 55,
                          topSizedBox: 50,
                          volumnButtonSize: 25,
                          width: MediaQuery.of(context).size.width - 60,
                          height: 200,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    //LAST CARD
                    const SizedBox(height: 30),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        Positioned(
                          top: -25,
                          child: Container(
                            width: 130,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 226, 245, 255),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                  size: 35,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Knew",
                                  style: theme.textTheme.bodySmall!.copyWith(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          child: DragTarget<Map<String, dynamic>>(
                            builder: (context, candidateData, rejectedData) {
                              return Draggable(
                                data: knewWords.last,
                                childWhenDragging: Material(
                                  borderRadius: BorderRadius.circular(15),
                                  child: knewWords.isNotEmpty
                                      ? SideCard(
                                          ukrainian:
                                              knewWords[knewWords.length - 2]
                                                  ['ukrainian'],
                                          example:
                                              knewWords[knewWords.length - 2]
                                                  ['example'],
                                          english:
                                              knewWords[knewWords.length - 2]
                                                  ['english'],
                                          imageWidth: 35,
                                          imageHeight: 35,
                                          volumnButtonSize: 20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              140,
                                          height: 160,
                                        )
                                      : const SizedBox(),
                                ),
                                feedback: Material(
                                  borderRadius: BorderRadius.circular(15),
                                  child: knewWords.isNotEmpty
                                      ? SideCard(
                                          ukrainian:
                                              knewWords.last['ukrainian'],
                                          example: knewWords.last['example'],
                                          english: knewWords.last['english'],
                                          imageWidth: 35,
                                          imageHeight: 35,
                                          volumnButtonSize: 20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              140,
                                          height: 160,
                                        )
                                      : const SizedBox(),
                                ),
                                child: knewWords.isNotEmpty
                                    ? Material(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SideCard(
                                          ukrainian:
                                              knewWords.last['ukrainian'],
                                          example: knewWords.last['example'],
                                          english: knewWords.last['english'],
                                          imageWidth: 35,
                                          imageHeight: 35,
                                          volumnButtonSize: 20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              140,
                                          height: 160,
                                        ),
                                      )
                                    : const SizedBox(),
                              );
                            },
                            onAcceptWithDetails: (card) {
                              setState(() {
                                learnWords.remove(card.data);
                                context
                                    .read<SaveWordsBloc>()
                                    .add(OnRemoveLearWords());
                                knewWords.add(card.data);
                                context
                                    .read<SaveWordsBloc>()
                                    .add(OnSaveKnewWords(listMap: card.data));
                                GetIt.I<Talker>()
                                    .debug("Result == ${card.data}");

                                words.remove(card.data);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (state is EnglishWordsApiSuccess) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Wait a bit",
                        style: TextStyle(fontSize: 25),
                      ),
                      Image.asset("assets/man.webp"),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
