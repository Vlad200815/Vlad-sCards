import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:path/path.dart';

import '../widgets/widgets.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  late List<GlobalKey<FlipCardState>> cardKeys;
  late List<Map<String, String>> cardsList;

  @override
  void initState() {
    cardsList = [
      {
        'front': "Hello",
        'back': "Привіт",
        'example':
            "used to express a greeting, answer a telephone, or attract attention",
      },
      {
        "front": "Goodbye",
        'back': "До по",
        'example':
            "used to express a greeting, answer a telephone, or attract attention",
      },
      {
        'front': 'Please',
        'back': 'Будь ласка',
        'example':
            "used to express a greeting, answer a telephone, or attract attention",
      },
      {
        'front': 'Thank you',
        'back': 'Дякую',
        'example':
            "used to express a greeting, answer a telephone, or attract attention",
      },
      {
        'front': 'Sorry',
        'back': 'Вибачте',
        'example':
            "used to express a greeting, answer a telephone, or attract attention",
      },
    ];

    cardKeys =
        List.generate(cardsList.length, (index) => GlobalKey<FlipCardState>());
    super.initState();
  }

  void resetCard(int index) {
    if (cardKeys[index].currentState != null && index < cardKeys.length) {
      cardKeys[index].currentState?.controller?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> cards = List.generate(
      cardsList.length,
      (int index) {
        return FlipCard(
          key: cardKeys[index],
          fill: Fill
              .fillBack, // Fill the back side of the card to make in the same size as the front.
          direction: FlipDirection.HORIZONTAL, // default
          side: CardSide.FRONT, // The side to initially display.
          front: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/flash-card.png',
                  scale: 4,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.volume_up_outlined,
                        color: theme.colorScheme.onPrimary,
                        size: 30,
                      ),
                      onPressed: () {
                        //play sound of the word
                      },
                    ),
                    Text(
                      cardsList[index]['front']!,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          back: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/flash-card.png',
                  scale: 4,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.volume_up_outlined,
                        color: theme.colorScheme.onPrimary,
                        size: 24,
                      ),
                      onPressed: () {
                        //play sound of the word
                      },
                    ),
                    Text(
                      cardsList[index]['front']!,
                      style: theme.textTheme.bodySmall!
                          .copyWith(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
                Text(
                  cardsList[index]['back']!,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: 24,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 25),
                  child: Divider(
                    color: Color.fromARGB(255, 217, 217, 217),
                    height: 2,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.volume_up_outlined,
                    color: theme.colorScheme.onPrimary,
                    size: 30,
                  ),
                  onPressed: () {
                    //play sound of the word
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
                          style:
                              theme.textTheme.bodySmall!.copyWith(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    List<int> know = [];

    List<int> dontKnow = [];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          const SizedBox(height: 25),
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
          Flexible(
            child: CardSwiper(
              isLoop: false,
              numberOfCardsDisplayed: 1,
              cardsCount: cardsList.length,
              cardBuilder:
                  (context, index, percentThresholdX, percentThresholdY) {
                return cards[index];
              },
              onSwipe: (previousIndex, currentIndex, direction) {
                resetCard(previousIndex);
                if (direction.name == 'right') {
                  know.add(currentIndex ?? 0);
                  print("know: $know");
                } else if (direction.name == 'left') {
                  dontKnow.add(currentIndex ?? 0);
                  print("dontKnow $dontKnow");
                }

                return true;
              },
              allowedSwipeDirection: const AllowedSwipeDirection.only(
                left: true,
                right: true,
                up: false,
                down: false,
              ),
              onEnd: () {
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
          ),
        ],
      ),
    );
  }
}
