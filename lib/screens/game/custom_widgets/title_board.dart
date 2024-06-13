import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/animations/value_text_animation.dart';
import 'package:tic_tac_toe/screens/game/progress_time.dart';

class TitleBoard extends StatelessWidget {
  const TitleBoard({
    super.key,
    required this.width,
    required this.height,
    required this.playerTurnsWon,
    required this.iaTurnsWon,
    required this.isProgressRunning,
  });

  final double width;
  final double height;
  final ValueNotifier<int> playerTurnsWon;
  final ValueNotifier<int> iaTurnsWon;
  final ValueNotifier<bool> isProgressRunning;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.values[5],
      children: [
        const Text(
          'You',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Container(
          width: width / 3,
          height: height / 20,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.values[5],
            children: [
              ValueTextAnimation(valueNotifier: playerTurnsWon),
              Stack(
                children: [
                  ScaleTransition(
                    scale: const AlwaysStoppedAnimation(0.7),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ProgressWidget(
                        isProgressRunning: isProgressRunning,
                      ),
                    ),
                  ),
                ],
              ),
              ValueTextAnimation(valueNotifier: iaTurnsWon),
            ],
          ),
        ),
        const Text(
          'IA',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
