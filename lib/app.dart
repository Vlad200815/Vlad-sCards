import 'package:flutter/material.dart';
import 'features/home/view/view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
          surface: Colors.grey[50],
          onPrimary: Colors.green,
          onSecondary: Colors.yellow[700],
          error: Colors.red,
          inverseSurface: Colors.black,
          inversePrimary: Colors.blue,
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
          bodySmall: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
  }
}
