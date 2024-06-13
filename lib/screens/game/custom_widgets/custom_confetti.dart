import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class CustomConfetti extends StatefulWidget {
  const CustomConfetti({super.key});

  @override
  State<CustomConfetti> createState() => _CustomConfettiState();
}

class _CustomConfettiState extends State<CustomConfetti> {
  final _confettiController =
      ConfettiController(duration: const Duration(seconds: 1));
  final starsPath = Path()
    ..moveTo(0, 0)
    ..lineTo(10, 10)
    ..lineTo(20, 10)
    ..lineTo(12, 20)
    ..lineTo(15, 30)
    ..lineTo(0, 24)
    ..lineTo(-15, 30)
    ..lineTo(-12, 20)
    ..lineTo(-20, 10)
    ..lineTo(-10, 10)
    ..close();
  final circlePath = Path()
    ..addOval(Rect.fromCircle(center: const Offset(0, 0), radius: 10));
  final squarePath = Path()
    ..addRect(
        Rect.fromCenter(center: const Offset(0, 0), width: 20, height: 20));

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 600), () {
      _confettiController.play();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int randomParticles = Random().nextInt(40) + 10;
    //random path
    final randomPath = Random().nextBool()
        ? starsPath
        : Random().nextBool()
            ? circlePath
            : squarePath;
    //if randomPath is starsPath, delimit random particles to 20
    if (randomPath == starsPath) {
      randomParticles < 5 ? randomParticles = 10 : randomParticles;
    }
    return ConfettiWidget(
      confettiController: _confettiController,
      blastDirectionality: BlastDirectionality.explosive,
      shouldLoop: false,
      maxBlastForce: 100,
      minBlastForce: 50,
      emissionFrequency: 0.02,
      numberOfParticles: randomParticles,
      gravity: 0.1,
      particleDrag: 0.05,
      createParticlePath: (size) {
        //draw path
        return randomPath;
      },
      colors: const [
        Colors.blue,
        Colors.red,
        Colors.yellow,
        Colors.green,
        Colors.purple,
        Colors.orange,
        Colors.pink,
        Colors.teal,
        Colors.cyan,
        Colors.lime,
        Colors.indigo,
        Colors.amber,
        Colors.brown,
        Colors.grey,
        Colors.deepPurple,
        Colors.lightBlue,
        Colors.lightGreen,
        Colors.deepOrange,
        Colors.blueGrey,
        Colors.black,
      ],
    );
  }
}
