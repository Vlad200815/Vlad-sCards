import 'package:flutter/material.dart';
import '../home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: theme.colorScheme.onPrimary,
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: TextStyle(),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.view_carousel_rounded), label: "Cards"),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded), label: "New words"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settinsg")
        ],
      ),
    );
  }
}
