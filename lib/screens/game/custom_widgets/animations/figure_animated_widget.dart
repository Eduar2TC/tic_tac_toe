import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/animations/element_drawer_animated.dart';
import 'package:tic_tac_toe/utils/figures.dart';

class FigureAnimationWidget extends StatefulWidget {
  final double size;
  final Figure figure;
  const FigureAnimationWidget(
      {super.key, required this.size, required this.figure});

  @override
  FigureAnimationWidgetState createState() => FigureAnimationWidgetState();
}

class FigureAnimationWidgetState extends State<FigureAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(widget.size, widget.size),
        painter: ElementDrawerAnimated(
          size: widget.size,
          animation: _animation,
          figure: widget.figure,
        ));
  }
}
