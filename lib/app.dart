import 'package:flutter/material.dart';
import 'package:vlads_cards/features/add_new_word/add_new_word.dart';
import 'package:vlads_cards/features/packes_of_words/packes_of_words.dart';
import 'package:vlads_cards/features/packes_of_words/view/choose_words_screen.dart';
import 'package:vlads_cards/features/training/view/training_screen.dart';
import 'features/home/view/view.dart';
import 'features/login/view/view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/forgot_pswd': (context) => const ForgotPswdScreen(),
        '/home': (context) => const HomeScreen(),
        '/add_new_word': (context) => const AddNewWordScreen(),
        '/training': (context) => const TrainingScreen(),
        '/packes_of_words_screen': (context) => const WordsPackesScreen(),
        '/packes_of_words_screen/choose_words': (context) =>
            const ChooseWordsScreen(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 94, 255),
          brightness: Brightness.light,
          surface: const Color.fromARGB(255, 244, 250, 253),
          onPrimary: Colors.blue,
          onSecondary: Colors.yellow[700],
          error: Colors.red,
          inversePrimary: const Color.fromARGB(255, 95, 220, 101),
          scrim: const Color.fromARGB(255, 224, 243, 255),
          onPrimaryFixed: Colors.grey[350],
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
          bodySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
