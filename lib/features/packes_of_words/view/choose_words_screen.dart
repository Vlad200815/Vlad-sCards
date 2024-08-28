import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vlads_cards/features/general_blocs/english_words_api_bloc/english_words_api_bloc.dart';
import 'package:vlads_cards/features/packes_of_words/packes_of_words.dart';
import 'package:vlads_cards/features/packes_of_words/widgets/side_card.dart';

class ChooseWordsScreen extends StatefulWidget {
  const ChooseWordsScreen({super.key});

  @override
  State<ChooseWordsScreen> createState() => _ChooseWordsScreenState();
}

class _ChooseWordsScreenState extends State<ChooseWordsScreen> {
  List<Map<String, dynamic>> words = [];

  List<Map<String, String>> know = [];
  List<Map<String, String>> dontKnow = [];
  final talker = GetIt.I<Talker>();
  int loadedItems = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (loadedItems < words.length) {
            setState(() {
              loadedItems = loadedItems + 5;
              talker.debug(loadedItems);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: theme.colorScheme.surface,
      body: BlocListener<EnglishWordsApiBloc, EnglishWordsApiState>(
        listener: (context, state) {
          if (state is EnglishWordsApiSuccess) {
            setState(() {
              words = List<Map<String, dynamic>>.from(
                state.response.data["words"],
              );
            });
          }
        },
        child: BlocBuilder<EnglishWordsApiBloc, EnglishWordsApiState>(
          builder: (context, state) {
            if (state is EnglishWordsApiSuccess) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 20, top: 35),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.chevron_back,
                            color: Colors.black,
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
                              "A1 Words",
                              style: theme.textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.water_drop_rounded,
                            color: Colors.blue[300],
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
                          color: theme.colorScheme.inversePrimary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        child: DragTarget<Map<String, String>>(
                          builder: (context, candidateData, rejectedData) {
                            return Draggable(
                              data: words.first,
                              feedback: Material(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SideCard(
                                    ukrainian: "ukranian",
                                    example: "exaple",
                                    english: "english",
                                    imagePath: "assets/flash-card.png",
                                    imageWidth: 35,
                                    imageHeight: 35,
                                    volumnButtonSize: 20,
                                    topSizedBox: 30,
                                    width:
                                        MediaQuery.of(context).size.width - 140,
                                    height: 160,
                                  )),
                              child: words.isEmpty
                                  ? const SizedBox()
                                  : Material(
                                      borderRadius: BorderRadius.circular(15),
                                      child: SideCard(
                                        ukrainian: "ukrianian",
                                        example: "example",
                                        imagePath: "assets/flash-card.png",
                                        english: words.first["english"]!,
                                        imageWidth: 35,
                                        imageHeight: 35,
                                        volumnButtonSize: 20,
                                        topSizedBox: 30,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                140,
                                        height: 160,
                                      ),
                                    ),
                            );
                          },
                          onAcceptWithDetails: (card) {
                            setState(() {
                              dontKnow.remove(card.data);
                              know.add(card.data);
                              words.remove(card.data);

                              talker.debug("know: $know");
                              talker.debug("dontKnow: $dontKnow");
                              talker.debug("words: $words");
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

                  Draggable(
                    data: state.response.data['words'],
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
                          color: theme.colorScheme.onPrimaryFixed,
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
                        child: DragTarget<Map<String, String>>(
                          builder: (context, candidateData, rejectedData) {
                            return Draggable(
                              data: words.first,
                              feedback: Material(
                                borderRadius: BorderRadius.circular(15),
                                child: SideCard(
                                  ukrainian: "ukrianian",
                                  example: "example",
                                  imagePath: "assets/flash-card.png",
                                  english: words.first["english"]!,
                                  imageWidth: 35,
                                  imageHeight: 35,
                                  volumnButtonSize: 20,
                                  topSizedBox: 30,
                                  width:
                                      MediaQuery.of(context).size.width - 140,
                                  height: 160,
                                ),
                              ),
                              child: words.isEmpty
                                  ? const SizedBox()
                                  : Material(
                                      borderRadius: BorderRadius.circular(15),
                                      child: SideCard(
                                        ukrainian: "ukrianian",
                                        example: "example",
                                        imagePath: "assets/flash-card.png",
                                        english: words.first["english"]!,
                                        imageWidth: 35,
                                        imageHeight: 35,
                                        volumnButtonSize: 20,
                                        topSizedBox: 30,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                140,
                                        height: 160,
                                      ),
                                    ),
                            );
                          },
                          onAcceptWithDetails: (card) {
                            setState(() {
                              know.remove(card.data);
                              dontKnow.add(card.data);
                              words.remove(card.data);

                              talker.debug("know: $know");
                              talker.debug("dontKnow: $dontKnow");
                              talker.debug("words: $words");
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
              return const Center(child: Text("Something went wrong..."));
            }
          },
        ),
      ),
    );
  }
}
