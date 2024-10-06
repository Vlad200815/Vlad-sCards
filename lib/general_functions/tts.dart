import 'package:flutter_tts/flutter_tts.dart';

final FlutterTts flutterTts = FlutterTts();

Future<void> speak(String word) async {
  await flutterTts.setLanguage("en-US");
  await flutterTts.setVolume(1.0);
  // await flutterTts.setSpeechRate(0.7);
  await flutterTts.speak(word);
}
