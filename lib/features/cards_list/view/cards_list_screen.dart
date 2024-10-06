import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlads_cards/general_blocs/save_words_bloc/save_words_bloc.dart';

import '../widgets/widgets.dart';

class CardsListScreen extends StatelessWidget {
  const CardsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (Route<dynamic> route) => false,
              ),
              icon: const Icon(
                CupertinoIcons.chevron_back,
              ),
            ),
            elevation: 3,
            backgroundColor: theme.colorScheme.onPrimaryFixed,
            title: const Text("Words"),
            automaticallyImplyLeading: true,
            centerTitle: true,
            expandedHeight: 70,
          ),
          BlocBuilder<SaveWordsBloc, SaveWordsState>(
            builder: (context, state) {
              return SliverList.separated(
                itemCount: 20,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey[300],
                  height: 2,
                ),
                itemBuilder: (context, index) {
                  return WordContainer(
                    onHear: () {},
                    englishWord: "hello",
                    ukrainWord: 'привіт',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 80.0,
                            ),
                            child: AlertDialog(
                              actions: [
                                DialogButton(
                                  onTap: () {},
                                  color: theme.colorScheme.inversePrimary,
                                  text: 'Edit',
                                  widget: const Icon(Icons.edit),
                                ),
                                DialogButton(
                                  color: theme.colorScheme.inversePrimary,
                                  onTap: () {},
                                  text: 'Reset',
                                  widget: const Icon(Icons.restore_outlined),
                                ),
                                DialogButton(
                                  color: Colors.red,
                                  onTap: () {},
                                  text: 'Delete',
                                  widget: const Icon(
                                    Icons.delete_forever_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
