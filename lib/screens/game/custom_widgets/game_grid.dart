import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/game/game.dart';
import 'package:tic_tac_toe/utils/winning_line_painter.dart';
/*
class GameGrid extends StatelessWidget {
  final int start;
  final int end;

  const GameGrid({super.key, required this.start, required this.end});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        GridView.builder(
          shrinkWrap: true,
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            //element of grid
            return BtnCreator(width: width, height: height, index: index);
          },
        ),
        IgnorePointer(
          child: CustomPaint(
            size: const Size(500, 500),
            painter: WinningLinePainter(start: start, end: end),
          ),
        ),
      ],
    );
  }
}*/
