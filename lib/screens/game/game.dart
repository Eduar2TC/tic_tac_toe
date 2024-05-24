import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/button.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/title_board.dart';
import 'package:tic_tac_toe/utils/element_drawer.dart';

class Game extends StatelessWidget {
  const Game({super.key});
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    //make grid of buttons
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.deepPurpleAccent,
              Colors.deepPurple,
              Colors.deepPurple.shade900,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitleBoard(width: width, height: height),
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
              SizedBox(
                height: height / 20,
              ),
              const Button(
                fontColor: Colors.white,
                backgroundColor: Colors.transparent,
                borderColor: Colors.white,
                text: 'Restart',
              ),
              SizedBox(
                height: height / 50,
              ),
              const Button(
                fontColor: Colors.deepPurple,
                backgroundColor: Colors.white,
                borderColor: Colors.white,
                text: 'End game',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BtnCreator extends StatefulWidget {
  const BtnCreator({
    super.key,
    required this.width,
    required this.height,
    required this.index,
  });

  final double width;
  final double height;
  final int index;

  @override
  BtnCreatorState createState() => BtnCreatorState();
}

class BtnCreatorState extends State<BtnCreator> {
  final ValueNotifier<Figure> _figureNotifier =
      ValueNotifier<Figure>(Figure.empty);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Figure>(
      valueListenable: _figureNotifier,
      builder: (context, figure, child) {
        return buildButton(
          figure: figure,
          rightBorder:
              widget.index != 2 && widget.index != 5 && widget.index != 8,
          bottomBorder: widget.index < 6,
        );
      },
    );
  }

  Widget buildButton({
    required Figure figure,
    bool rightBorder = true,
    bool bottomBorder = true,
  }) {
    return Container(
      width: widget.width / 3,
      height: widget.height / 3,
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
        onPressed: () {
          _figureNotifier.value = _figureNotifier.value == Figure.empty
              ? Figure.cross
              : Figure.empty;
        },
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
