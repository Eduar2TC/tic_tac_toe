import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/custom_confetti.dart';

class GameOverMessage extends StatelessWidget {
  const GameOverMessage({super.key, required this.message});
  final String message;
  final String winner = '¡You Win! 🏆';
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1200),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.elasticOut,
      builder: (context, value, _) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.seymourOne(
                      textStyle: const TextStyle(
                        fontSize: 40,
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .2,
                      ),
                    ),
                  ),
                  message == winner ? const CustomConfetti() : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
