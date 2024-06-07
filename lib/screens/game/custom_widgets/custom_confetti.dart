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
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 600), () {
      _confettiController.play();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final randomParticles = Random().nextInt(50) + 10;
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
      /*createParticlePath: (size) {
        //draw star is too slow
        return Path()
          ..moveTo(size.width / 2, size.height / 2)
          ..lineTo(size.width / 2 + 10, size.height / 2 + 10)
          ..lineTo(size.width / 2 + 20, size.height / 2 + 10)
          ..lineTo(size.width / 2 + 12, size.height / 2 + 20)
          ..lineTo(size.width / 2 + 15, size.height / 2 + 30)
          ..lineTo(size.width / 2, size.height / 2 + 24)
          ..lineTo(size.width / 2 - 15, size.height / 2 + 30)
          ..lineTo(size.width / 2 - 12, size.height / 2 + 20)
          ..lineTo(size.width / 2 - 20, size.height / 2 + 10)
          ..lineTo(size.width / 2 - 10, size.height / 2 + 10)
          ..close();
      },*/
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
