import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/element_drawer.dart';

class ChooseSideButton extends StatelessWidget {
  final Figure figure;
  final bool isTapped;
  final VoidCallback onTap;

  const ChooseSideButton({
    super.key,
    required this.figure,
    required this.isTapped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onPanDown: (_) => onTap(),
      child: TextButton(
        onPressed: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: width / 2,
          height: height / 4,
          decoration: BoxDecoration(
            color: isTapped ? Colors.white : Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.elliptical(50, 50),
            ),
          ),
          child: Transform(
            alignment: Alignment.center,
            transform: Transform.scale(
              scale: 0.5,
            ).transform,
            child: CustomPaint(
              painter: ElementDrawer(
                size: 300,
                figure: figure,
                bgColor: isTapped ? Colors.deepPurple : Colors.white,
              ),
              size: const Size(200, 200),
            ),
          ),
        ),
      ),
    );
  }
}
