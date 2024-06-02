import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/figures.dart';

class ElementDrawer extends CustomPainter {
  final double size;
  final Paint crossPaint;
  final Paint circlePaint;
  final Figure figure;
  final bgColor;

  ElementDrawer(
      {required this.size, required this.figure, this.bgColor = Colors.white})
      : crossPaint = Paint()
          ..color = bgColor
          ..strokeWidth = size / 10
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
        circlePaint = Paint()
          ..color = bgColor
          ..strokeWidth = size / 10
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

  @override
  void paint(Canvas canvas, Size size) {
    switch (figure) {
      case Figure.cross:
        drawCross(canvas, size);
        break;
      case Figure.circle:
        drawCircle(canvas, size);
        break;
      case Figure.empty:
        null;
        break;
    }
  }

  void drawCross(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.2);
    path.lineTo(size.width * 0.8, size.height * 0.8);
    path.moveTo(size.width * 0.8, size.height * 0.2);
    path.lineTo(size.width * 0.2, size.height * 0.8);
    canvas.drawPath(path, crossPaint);
  }

  void drawCircle(Canvas canvas, Size size) {
    canvas.drawCircle(size.center(Offset.zero),
        size.width / 2 - crossPaint.strokeWidth / 2, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
