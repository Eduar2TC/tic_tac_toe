import 'package:flutter/material.dart';

class WinningLinePainter extends CustomPainter {
  final int start;
  final int end;
  final Animation<double> animation;

  WinningLinePainter(
      {required this.start, required this.end, required this.animation})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final double progress = animation.value;
    final paint = Paint()
      ..color = Colors.purpleAccent
      ..shader = const LinearGradient(
        colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 8.0;

    final startOffset = Offset((start % 3) * size.width / 3 + size.width / 6,
        (start ~/ 3) * size.height / 3 + size.height / 6);
    final endOffset = Offset((end % 3) * size.width / 3 + size.width / 6,
        (end ~/ 3) * size.height / 3 + size.height / 6);

    final midOffset = Offset(
      startOffset.dx + (endOffset.dx - startOffset.dx) * progress,
      startOffset.dy + (endOffset.dy - startOffset.dy) * progress,
    );

    canvas.drawLine(startOffset, midOffset, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
