import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/choose_side/choose_side.dart';
import 'package:tic_tac_toe/screens/game/game.dart';
import 'package:tic_tac_toe/screens/play_mode/play_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        //define the colors scheme primary and secondary
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
        //define font sizes
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 40,
            color: Colors.black,
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          displaySmall: TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
        ),
      ),
      home: Scaffold(
        appBar: null,
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.deepPurpleAccent,
                Colors.deepPurple,
                Colors.deepPurple.shade900,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const PlayMode(),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/play_mode': (context) => const PlayMode(),
        '/choose_side': (context) => const ChooseSide(),
        '/game': (context) => const Game(),
      },
    );
  }
}
