import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class CardsListScreen extends StatelessWidget {
  const CardsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            elevation: 3,
            backgroundColor: Colors.white,
            title: Text("Words"),
            automaticallyImplyLeading: true,
            centerTitle: true,
            expandedHeight: 70,
          ),
          SliverList.separated(
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
                              color: Colors.black,
                              text: 'Edit',
                              widget: const Icon(Icons.edit),
                            ),
                            DialogButton(
                              color: Colors.black,
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
          ),
        ],
      ),
    );
  }
}
