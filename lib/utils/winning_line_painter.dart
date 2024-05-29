import 'package:flutter/material.dart';

class WinningLinePainter extends CustomPainter {
  final int start;
  final int end;

  WinningLinePainter({required this.start, required this.end});

  @override
  void paint(Canvas canvas, Size size) {
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

    canvas.drawLine(startOffset, endOffset, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
