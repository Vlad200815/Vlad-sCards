import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vlads_cards/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vlads_cards/features/login/blocs/email_auth_bloc/email_auth_bloc.dart';
import 'package:vlads_cards/features/login/blocs/facebook_auth_bloc/facebook_auth_bloc.dart';
import 'package:vlads_cards/features/login/blocs/google_auth_bloc/google_auth_bloc.dart';
import 'package:vlads_cards/general_blocs/english_words_api_bloc/english_words_api_bloc.dart';
import 'general_blocs/theme_change_cubit/theme_change_cubit.dart';
import 'firebase_options.dart';

void main() async {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker started...');
  // await DatabaseService().deleteExistingDatabase();
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
  );

  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GoogleAuthBloc(),
            ),
            BlocProvider(
              create: (context) => EmailAuthBloc(),
            ),
            BlocProvider(
              create: (context) => FacebookAuthBloc(),
            ),
            BlocProvider(
              create: (context) => EnglishWordsApiBloc(),
            ),
            BlocProvider(
              create: (context) => ThemeChangeCubit(),
            ),
          ],
          child: const MyApp(),
        ),
      );
    },
    (error, stack) => GetIt.I<Talker>().handle(error, stack),
  );
}
