import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vlads_cards/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vlads_cards/features/login/blocs/email_auth_bloc/email_auth_bloc.dart';
import 'package:vlads_cards/features/login/blocs/facebook_auth_bloc/facebook_auth_bloc.dart';
import 'package:vlads_cards/features/login/blocs/google_auth_bloc/google_auth_bloc.dart';
import 'package:vlads_cards/general_blocs/english_words_api_bloc/english_words_api_bloc.dart';
import 'package:vlads_cards/general_blocs/image_search_api/image_search_api_bloc.dart';
import 'package:vlads_cards/general_blocs/save_words_bloc/save_words_bloc.dart';
import 'package:vlads_cards/general_blocs/what_login_cubit/what_login_cubit.dart';
import 'package:vlads_cards/repositories/save_words/save_words.dart';
import 'package:vlads_cards/repositories/settings/settings_repository.dart';
import 'package:workmanager/workmanager.dart';
import 'general_blocs/theme_change_cubit/theme_change_cubit.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == "reAddRemovedItem" && inputData != null) {
      var removedItem = jsonDecode(inputData['removedItem']);
      var saveLearnWordsKey = inputData['saveLearnWordsKey'];

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? jsonString = preferences.getString(saveLearnWordsKey);

      if (jsonString != null) {
        List<dynamic> myList = jsonDecode(jsonString);
        debugPrint("before add: $myList");
        myList.add(removedItem);
        debugPrint("after add: $myList");
        String updatedJsonString = jsonEncode(myList);
        debugPrint("after jsonEncode: $updatedJsonString");
        await preferences.setString(saveLearnWordsKey, updatedJsonString);

        String? test = preferences.getString(saveLearnWordsKey);
        if (test != null) {
          List<dynamic> jsonData = jsonDecode(test);
          List<Map<String, dynamic>> data =
              jsonData.cast<Map<String, dynamic>>();
          debugPrint("test: ---- $data");
        }
      }
    }
    return Future.value(true);
  });
}

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
      final prefs = await SharedPreferences.getInstance();
      // await prefs.clear(); //delete this line if you do not need it anymore!
      final settingsRepository = SettingsRepository(preferences: prefs);
      final saveWordsRepository = SaveWordsRepository(preferences: prefs);

      Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

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
              create: (context) => ThemeChangeCubit(
                settingsRepository: settingsRepository,
              ),
            ),
            BlocProvider(
              create: (context) => SaveWordsBloc(
                saveWordsRepository: saveWordsRepository,
              ),
            ),
            BlocProvider(
              create: (context) => ImageSearchApiBloc(),
            ),
            BlocProvider(
              create: (context) => WhatLoginCubit(),
            ),
          ],
          child: const MyApp(),
        ),
      );
    },
    (error, stack) => GetIt.I<Talker>().handle(error, stack),
  );
}
