import 'package:flutter/material.dart';
import 'features/home/view/view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 94, 255),
          brightness: Brightness.light,
          surface: const Color.fromARGB(255, 244, 250, 253),
          onPrimary: Colors.blue,
          onSecondary: Colors.yellow[700],
          error: Colors.red,
          inversePrimary: Colors.green,
          outline: Colors.grey[400],
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
