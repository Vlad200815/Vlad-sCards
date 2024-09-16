import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vlads_cards/repositories/save_words/save_words.dart';

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
  Future<void> removeLearnWord(Map<String, dynamic> word) async {
    try {
      String? jsonString = preferences.getString(_saveLearnWords);
      if (jsonString != null) {
        List<dynamic> myList = jsonDecode(jsonString);
        if (myList.isNotEmpty) {
          myList.remove(word);
          String updatedJsonString = jsonEncode(myList);
          await preferences.setString(_saveLearnWords, updatedJsonString);
        }
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  Future<void> removeKnewWord(Map<String, dynamic> word) async {
    //TODO: fix this function it does not want to remove cards properly
    try {
      String? jsonString = preferences.getString(_saveKnewWords);
      if (jsonString != null) {
        List<dynamic> myList = jsonDecode(jsonString);
        if (myList.isNotEmpty) {
          GetIt.I<Talker>().debug("Before the removeKnewWords: $myList");
          myList.remove(word);
          GetIt.I<Talker>().debug("After the removeKnewWords: $myList");

          String updatedJsonString = jsonEncode(myList);
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
      String? jsonString = preferences.getString(_saveLearnWords);
      if (jsonString != null) {
        List<dynamic> myList = jsonDecode(jsonString);
        if (myList.isNotEmpty) {
          myList.removeAt(0);
          GetIt.I<Talker>().debug("remove from training: $myList");
          String updatedJsonString = jsonEncode(myList);

          await preferences.setString(_saveLearnWords, updatedJsonString);
        }
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  // @override
  // Future<List<Map<String, dynamic>>> getDoNotKnowWords() async {
  //   try {
  //     String? jsonString = preferences.getString(_saveDoNotKnowWords);

  //     if (jsonString != null) {
  //       GetIt.I<Talker>().debug(jsonString);
  //       List<dynamic> jsonList = jsonDecode(jsonString);
  //       List<Map<String, dynamic>> wordsList =
  //           jsonList.cast<Map<String, dynamic>>();
  //       return jsonString as List<Map<String, dynamic>>;
  //     } else {
  //       return [];
  //     }
  //   } catch (e, st) {
  //     GetIt.I<Talker>().handle(e, st);
  //     rethrow;
  //   }
  // }

  // @override
  // Future<void> saveDoNotKnowWords(Map<String, dynamic> listMap) async {
  //   try {
  //     String jsonString = jsonEncode(listMap);
  //     await preferences.setString(_saveDoNotKnowWords, jsonString);
  //     GetIt.I<Talker>().debug(jsonString);
  //   } catch (e, st) {
  //     GetIt.I<Talker>().handle(e, st);
  //   }
  // }

  // @override
  // Future<void> saveKnewWords(Map<String, dynamic> listMap) async {
  //   try {
  //     String jsonString = jsonEncode(listMap);
  //     await preferences.setString(_knew, jsonString);
  //     GetIt.I<Talker>().debug(jsonString);
  //   } catch (e, st) {
  //     GetIt.I<Talker>().handle(e, st);
  //   }
  // }

  // @override
  // Future<List<Map<String, dynamic>>> getKnowWords() async {
  //   List<Map<String, dynamic>> words = [];
  //   try {
  //     String? jsonString = preferences.getString(_saveKnowWords);

  //     if (jsonString != null) {
  //       GetIt.I<Talker>().debug(jsonString);
  //       Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  //       words.add(jsonMap);
  //       GetIt.I<Talker>().debug(jsonString);
  //       return words;
  //     } else {
  //       return [];
  //     }
  //   } catch (e, st) {
  //     GetIt.I<Talker>().handle(e, st);
  //     rethrow;
  //   }
  // }

  // @override
  // Future<List<Map<String, dynamic>>> getKnewWords() async {
  //   String? jsonString = preferences.getString(_knew);
  //   if (jsonString != null) {
  //     List<Map<String, dynamic>> knewWords = jsonDecode(jsonString);
  //     return knewWords;
  //   } else {
  //     return [];
  //   }
  // }

  // @override
  // Future<void> removeDoNotKnowWord(Map<String, dynamic> word) async {
  //   String? words = preferences.getString(_saveDoNotKnowWords);
  //   if (words != null) {
  //     List<dynamic> list = jsonDecode(words);
  //     if (list.isNotEmpty) {
  //       list.removeAt(0);
  //       await preferences.setString(_saveDoNotKnowWords, jsonEncode(list));
  //     }
  //   }
  // }

  // @override
  // Future<void> removeKnowWord(Map<String, dynamic> word) async {
  //   String? words = preferences.getString(_saveKnowWords);
  //   if (words != null) {
  //     List<dynamic> list = jsonDecode(words);
  //     if (list.isNotEmpty) {
  //       list.removeAt(0);
  //       await preferences.setString(_saveKnowWords, jsonEncode(list));
  //     }
  //   }
  //  }
}
