import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlads_cards/features/home/widgets/cards_box.dart';
import 'package:vlads_cards/features/login/blocs/email_auth_bloc/email_auth_bloc.dart';
import 'package:vlads_cards/widgets/widgets.dart';
import '../../packes_of_words/bloc/english_words_api_bloc/english_words_api_bloc.dart';
import '../widgets/widgets.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
            icon: const Icon(Icons.sign_language_outlined),
            onPressed: () {
              context.read<EmailAuthBloc>().add(SignOut());
              Navigator.pushNamed(context, '/');
            },
          ),
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 285,
                  child: Image.asset('assets/200.webp'),
                ),
              ),
              const SizedBox(height: 80),
              MyButton(
                horizontal: MediaQuery.of(context).size.width / 3,
                onPressed: () {
                  Navigator.pushNamed(context, '/training');
                },
                text: "Start",
              ),
              const SizedBox(height: 40),
              const CardsBox()
            ],
          ),
        ),
      ],
    );
  }
}
