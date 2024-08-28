import 'package:flutter/material.dart';
import 'package:vlads_cards/features/packes_of_words/packes_of_words.dart';
import '../../settings/view/view.dart';
import '../home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: bottomBarIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_new_word');
              },
              shape: const CircleBorder(),
              backgroundColor: theme.colorScheme.primary,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: bottomBarIndex == 0
          ? const BaseScreen()
          : bottomBarIndex == 1
              ? const WordsPackesScreen()
              : const SettingsScreen(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              bottomBarIndex = value;
              debugPrint(bottomBarIndex.toString());
            });
          },
          elevation: 3,
          // fixedColor: theme.colorScheme.onPrimary,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          backgroundColor: theme.colorScheme.onSecondary,
          items: [
            BottomNavigationBarItem(
              icon: bottomBarIndex == 0
                  ? Icon(
                      Icons.view_carousel_rounded,
                      color: theme.colorScheme.primary,
                    )
                  : Icon(
                      Icons.view_carousel_rounded,
                      color: Colors.grey[200],
                    ),
              label: "Cards",
            ),
            BottomNavigationBarItem(
              icon: bottomBarIndex == 1
                  ? Icon(
                      Icons.menu_book_rounded,
                      color: theme.colorScheme.primary,
                    )
                  : Icon(
                      Icons.menu_book_rounded,
                      color: Colors.grey[200],
                    ),
              label: "New Words",
            ),
            BottomNavigationBarItem(
              icon: bottomBarIndex == 2
                  ? Icon(
                      Icons.settings,
                      color: theme.colorScheme.primary,
                    )
                  : Icon(
                      Icons.settings,
                      color: Colors.grey[200],
                    ),
              label: "Settinsg",
            ),
          ],
        ),
      ),
    );
  }
}
