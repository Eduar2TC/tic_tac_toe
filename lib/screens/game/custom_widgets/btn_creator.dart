import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/element_drawer.dart';

class BtnCreator extends StatefulWidget {
  const BtnCreator({
    super.key,
    required this.width,
    required this.height,
    required this.index,
    required this.figureNotifier,
    this.onPress,
  });

  final double width;
  final double height;
  final int index;
  final ValueNotifier<Figure> figureNotifier;
  final VoidCallback? onPress;

  @override
  BtnCreatorState createState() => BtnCreatorState();
}

class BtnCreatorState extends State<BtnCreator> {
  final ValueNotifier<Figure> _figureNotifier =
      ValueNotifier<Figure>(Figure.empty);

  void iaButtonPress() {
    _figureNotifier.value = Figure.circle;
  }

  void playerButtonPress() {
    _figureNotifier.value = Figure.cross;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Figure>(
      valueListenable: widget.figureNotifier,
      builder: (context, figure, _) {
        return GameButton(
          width: widget.width,
          height: widget.height,
          figure: figure,
          rightBorder:
              widget.index != 2 && widget.index != 5 && widget.index != 8,
          bottomBorder: widget.index < 6,
          onPress: widget.onPress ?? () {},
        );
      },
    );
  }
}

class GameButton extends StatelessWidget {
  final Figure figure;
  final bool rightBorder;
  final bool bottomBorder;
  final double width;
  final double height;
  final VoidCallback onPress;

  const GameButton({
    super.key,
    required this.figure,
    this.rightBorder = true,
    this.bottomBorder = true,
    required this.width,
    required this.height,
    required this.onPress,
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
        child: CustomPaint(
          painter: ElementDrawer(size: 100, figure: figure),
          size: const Size(100, 100),
          isComplex: true,
          willChange: true,
        ),
      ),
    );
  }
}
