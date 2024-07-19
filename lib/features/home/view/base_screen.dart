import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          floating: true,
          centerTitle: true,
          title: Text(
            "Vlad'sCards",
            style: theme.textTheme.titleLarge,
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Box(
                      text: "383",
                      hint: "Вчити",
                      textColor: theme.colorScheme.onPrimary,
                    ),
                    Box(
                      text: "111",
                      hint: "Знаю",
                      textColor: theme.colorScheme.inversePrimary,
                    ),
                    Box(
                      text: "237",
                      hint: "Навчився",
                      textColor: theme.colorScheme.onSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
