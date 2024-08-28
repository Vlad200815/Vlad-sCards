import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vlads_cards/features/add_new_word/add_new_word.dart';
import 'package:vlads_cards/general_blocs/english_words_api_bloc/english_words_api_bloc.dart';
import 'package:vlads_cards/general_blocs/theme_change_cubit/theme_change_cubit.dart';
import 'package:vlads_cards/features/packes_of_words/packes_of_words.dart';
import 'package:vlads_cards/features/training/view/training_screen.dart';
import 'package:vlads_cards/theme/theme.dart';
import 'features/cards_list/view/cards_list_screen.dart';
import 'features/home/view/view.dart';
import 'features/login/view/view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeChangeCubit, ThemeChangeState>(
      builder: (context, state) {
        return MaterialApp(
          navigatorObservers: [
            TalkerRouteObserver(
              GetIt.I<Talker>(),
            ),
          ],
          routes: {
            '/': (context) => const WelcomeScreen(),
            '/forgot_pswd': (context) => const ForgotPswdScreen(),
            '/home': (context) => const HomeScreen(),
            '/add_new_word': (context) => const AddNewWordScreen(),
            '/training': (context) => BlocProvider(
                  create: (context) => EnglishWordsApiBloc(),
                  child: const TrainingScreen(),
                ),
            '/packes_of_words_screen': (context) => const WordsPackesScreen(),
            '/packes_of_words_screen/choose_words': (context) =>
                const ChooseWordsScreen(),
            '/cards_list_screen': (context) => const CardsListScreen()
          },
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          theme: state.brightness == Brightness.dark ? darkTheme : lightTheme,
        );
      },
    );
  }
}
