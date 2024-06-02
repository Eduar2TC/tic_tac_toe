import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/animations/figure_animated_widget.dart';
import 'package:tic_tac_toe/utils/figures.dart';

class GameButton extends StatelessWidget {
  final Figure? figure;
  final bool rightBorder;
  final bool bottomBorder;
  final double width;
  final double height;
  final VoidCallback onPress;

  const GameButton({
    super.key,
    this.rightBorder = true,
    this.bottomBorder = true,
    required this.width,
    required this.height,
    required this.onPress,
    this.figure = Figure.empty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / 3,
      height: height / 3,
      decoration: BoxDecoration(
        border: Border(
          right: rightBorder
              ? const BorderSide(color: Colors.white, width: 10)
              : BorderSide.none,
          bottom: bottomBorder
              ? const BorderSide(color: Colors.white, width: 10)
              : BorderSide.none,
        ),
      ),
      child: TextButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          backgroundColor: Colors.transparent,
        ),
        onPressed: onPress,
        child: FigureAnimationWidget(size: 100, figure: figure!),
      ),
    );
  }
}
