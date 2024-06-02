import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/winning_line_painter.dart';

class WinningLineWidget extends StatefulWidget {
  final int start;
  final int end;
  final Size size;
  const WinningLineWidget(
      {super.key, required this.start, required this.end, required this.size});

  @override
  State<WinningLineWidget> createState() => _WinningLineWidgetState();
}

class _WinningLineWidgetState extends State<WinningLineWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _controller.forward();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.size,
      painter: WinningLinePainter(
        start: widget.start,
        end: widget.end,
        animation: _animation,
      ),
    );
  }
}
