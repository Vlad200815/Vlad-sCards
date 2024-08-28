import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../general_blocs/english_words_api_bloc/english_words_api_bloc.dart';

class WordsPackesScreen extends StatelessWidget {
  const WordsPackesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String englishLevel(int index) {
      if (index <= 2) {
        return 'A$index';
      } else if (index <= 4 && index > 2) {
        return 'B${index - 2}';
      } else if (index <= 5 && index > 4) {
        return 'C${index - 4}';
      } else {
        return '';
      }
    }

    String englishTextLevel(int index) {
      if (index == 1) {
        return "Begginer";
      } else if (index == 2) {
        return "Pre-Intermidiat";
      } else if (index == 3) {
        return "Intermidiat";
      } else if (index == 4) {
        return "Upper-Intermidiat";
      } else if (index == 5) {
        return "Advance";
      } else {
        return "";
      }
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 130.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Text("Choose level"),
              ),
              background: Image.asset(
                'assets/flash-card-2.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisExtent: 200,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                index = index + 1;
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: InkWell(
                    onTap: () {
                      context
                          .read<EnglishWordsApiBloc>()
                          .add(OnEnlishWordsApiEvent());
                      Navigator.pushNamed(
                          context, '/packes_of_words_screen/choose_words');
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          color: Colors.teal[100 * ((index + 1) % 9)],
                          border: Border.all(
                            color: theme.colorScheme.onPrimaryFixed,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          '${englishLevel(index)} ${englishTextLevel(index)}',
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
