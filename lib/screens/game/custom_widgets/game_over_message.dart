import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/custom_confetti.dart';

class GameOverMessage extends StatefulWidget {
  const GameOverMessage({super.key, required this.message});
  final String message;

  @override
  State<GameOverMessage> createState() => _GameOverMessageState();
}

class _GameOverMessageState extends State<GameOverMessage> {
  final String winner = '¡You Win! 🏆';
  bool isAnimated = false;

  @override
  void initState() {
    super.initState();
    //fix delay problems in game over message (game screen)
    Future.delayed(const Duration(milliseconds: 1600), () {
      setState(() {
        isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isAnimated
        ? TweenAnimationBuilder(
            duration: const Duration(milliseconds: 1000),
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
                          widget.message,
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
                        widget.message == winner
                            ? const CustomConfetti()
                            : Container(),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Container();
  }
}
