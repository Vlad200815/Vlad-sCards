import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vlads_cards/repositories/save_words/save_words.dart';
import 'package:workmanager/workmanager.dart';

class SaveWordsRepository implements SaveWordsRepositoryInterface {
  final SharedPreferences preferences;

  SaveWordsRepository({required this.preferences});

  static const _saveLearnWords = "save_learn_words";
  static const _saveKnewWords = "save_knew_words";

  List<Map<String, dynamic>> storageLearn = [];
  List<Map<String, dynamic>> storageKnew = [];

  @override
  Future<void> saveLearnWords(Map<String, dynamic> listMap) async {
    storageLearn.add(listMap);
    try {
      String jsonString = jsonEncode(storageLearn);
      GetIt.I<Talker>().debug("the saveLearnWords: $jsonString");
      await preferences.setString(_saveLearnWords, jsonString);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  Future<void> saveKnewWords(Map<String, dynamic> listMap) async {
    storageKnew.add(listMap);
    try {
      String jsonString = jsonEncode(storageKnew);
      GetIt.I<Talker>().debug("the saveKnewWords: $jsonString");
      await preferences.setString(_saveKnewWords, jsonString);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getLearnWords() async {
    try {
      String? jsonString = preferences.getString(_saveLearnWords);
      if (jsonString != null) {
        List<dynamic> jsonData = jsonDecode(jsonString);
        List<Map<String, dynamic>> data = jsonData.cast<Map<String, dynamic>>();
        GetIt.I<Talker>().debug("data from getLearnWords: $data");
        return data;
      } else {
        return [];
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getKnewWords() async {
    try {
      String? jsonString = preferences.getString(_saveKnewWords);
      if (jsonString != null) {
        List<dynamic> jsonData = jsonDecode(jsonString);
        List<Map<String, dynamic>> data = jsonData.cast<Map<String, dynamic>>();
        GetIt.I<Talker>().debug("it's out data from getKnewWords: $data");
        return data;
      } else {
        GetIt.I<Talker>().debug("we fucked up!");
        return [];
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      rethrow;
    }
  }

  @override
  Future<void> removeLearnWord() async {
    try {
      if (storageLearn.isNotEmpty) {
        storageLearn.removeAt(storageLearn.length - 1);
        // GetIt.I<Talker>().debug("remove from the learn storage $storageLearn");
      }

      String? jsonString = preferences.getString(_saveLearnWords);
      if (jsonString != null) {
        List<dynamic> myList = jsonDecode(jsonString);
        if (myList.isNotEmpty) {
          // GetIt.I<Talker>().debug("Before the removeLearnWords: $myList");
          myList.removeAt(myList.length - 1);
          // GetIt.I<Talker>().debug("After the removeLearnWords: $myList");

          String updatedJsonString = jsonEncode(myList);
          await preferences.setString(_saveLearnWords, updatedJsonString);
        }
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  Future<void> removeKnewWord() async {
    try {
      GetIt.I<Talker>().debug("the knew storage----> $storageLearn");
      if (storageKnew.isNotEmpty) {
        storageKnew.removeAt(storageKnew.length - 1);
        GetIt.I<Talker>()
            .debug("remove from the knew storage----> $storageLearn");
      }

      String? jsonString = preferences.getString(_saveKnewWords);
      if (jsonString != null) {
        List<dynamic> myList = jsonDecode(jsonString);
        if (myList.isNotEmpty) {
          GetIt.I<Talker>().debug("Before the removeKnewWords: $myList");
          myList.removeAt(myList.length - 1);

          String updatedJsonString = jsonEncode(myList);
          GetIt.I<Talker>()
              .debug("After the removeKnewWords: $updatedJsonString");
          await preferences.setString(_saveKnewWords, updatedJsonString);
        }
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  Future<void> removeLearn() async {
    try {
      if (storageLearn.isNotEmpty) {
        storageLearn.removeAt(storageLearn.length - 1);
      }
      String? jsonString = preferences.getString(_saveLearnWords);
      GetIt.I<Talker>()
          .debug("remove from training the jsonString: $jsonString");

      if (jsonString != null) {
        List<dynamic> myList = jsonDecode(jsonString);
        if (myList.isNotEmpty) {
          var removedItem = myList.removeAt(0);

          GetIt.I<Talker>().debug("remove from training: $myList");
          String updatedJsonString = jsonEncode(myList);
          await preferences.setString(_saveLearnWords, updatedJsonString);

          int delayDurationTime = 0;

          if (removedItem['repetition'] == 0) {
            delayDurationTime = 2; // 2 minuts
          } else if (removedItem['repetition'] == 1) {
            delayDurationTime = 2; //60 minuts
          } else if (removedItem['repetition'] == 2) {
            delayDurationTime = 60 * 24;
          } else if (removedItem['repetition'] == 3) {
            delayDurationTime = 60 * 24 * 7;
          } else if (removedItem['repetition'] == 4) {
            delayDurationTime = 2;
          } else if (removedItem['repetition'] == 5) {
            delayDurationTime = 20;
          } else if (removedItem['repetition'] == 6) {
            delayDurationTime = 60;
          } else if (removedItem['repetition'] == 7) {
            delayDurationTime = 60 * 24;
          } else if (removedItem['repetition'] == 8) {
            delayDurationTime = 60 * 24 * 7;
          } else {
            delayDurationTime = 60 * 24 * 7 * 2;
          }

          removedItem["repetition"] += 1;

          await Workmanager().registerOneOffTask(
              "uniqueTaskId_${removedItem['english']}", "reAddRemovedItem",
              inputData: {
                'removedItem': jsonEncode(removedItem),
                'saveLearnWordsKey': _saveLearnWords,
              },
              initialDelay:
                  Duration(seconds: delayDurationTime) //TODO: CORRECT TO MINUTS
              );

          GetIt.I<Talker>().debug(
              "scheduled task to restore item after $delayDurationTime minutes.");
        }
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }
}
