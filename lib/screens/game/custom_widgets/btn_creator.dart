import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/game_button.dart';
import 'package:tic_tac_toe/utils/figures.dart';

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
          key: ValueKey(figure),
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
