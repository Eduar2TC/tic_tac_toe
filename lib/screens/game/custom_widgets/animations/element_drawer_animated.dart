import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/figures.dart';

class ElementDrawerAnimated extends CustomPainter {
  final double size;
  final Paint elementPaint;
  final Animation<double> animation;
  final Figure figure;

  ElementDrawerAnimated({
    required this.size,
    required this.animation,
    required this.figure,
    Color bgColor = Colors.white,
  })  : elementPaint = Paint()
          ..color = bgColor
          ..strokeWidth = size / 6
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
        super(repaint: animation);

  void drawCircle(Canvas canvas, Size size) {
    final double endAngle = animation.value * 2 * pi;

    canvas.drawArc(
      Rect.fromCircle(
        center: size.center(Offset.zero),
        radius: size.width / 2 - elementPaint.strokeWidth / 2,
      ),
      0,
      endAngle,
      false,
      elementPaint,
    );
  }

  void drawCross(Canvas canvas, Size size) {
    final double progress = animation.value;
    final double line1xStart = size.width * 0.2;
    final double line1yStart = size.height * 0.2;
    final double line1xEnd = line1xStart + (size.width * 0.6 * progress);
    final double line1yEnd = line1yStart + (size.height * 0.6 * progress);

    final double line2xStart = size.width * 0.8;
    final double line2yStart = size.height * 0.2;
    final double line2xEnd = line2xStart - (size.width * 0.6 * progress);
    final double line2yEnd = line1yStart + (size.height * 0.6 * progress);

    canvas.drawLine(
      Offset(line1xStart, line1yStart),
      Offset(line1xEnd, line1yEnd),
      elementPaint,
    );
    canvas.drawLine(
      Offset(line2xStart, line2yStart),
      Offset(line2xEnd, line2yEnd),
      elementPaint,
    );
  }

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
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
