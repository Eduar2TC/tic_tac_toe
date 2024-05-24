import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/button.dart';
import 'package:tic_tac_toe/utils/element_drawer.dart';

class PlayMode extends StatelessWidget {
  const PlayMode({super.key});
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height / 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.values[5],
            children: [
              CustomPaint(
                painter: ElementDrawer(size: 300, figure: Figure.cross),
                size: const Size(200, 200),
              ),
              CustomPaint(
                painter: ElementDrawer(size: 300, figure: Figure.circle),
                size: const Size(200, 200),
              ),
            ],
          ),
          SizedBox(
            height: height / 4,
          ),
          const Text(
            'Choose a play mode',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: height / 30,
          ),
          Button(
            fontColor: Colors.white,
            backgroundColor: Colors.transparent,
            borderColor: Colors.white,
            text: 'With IA',
            onPressed: () {
              //move to page ChooseSide
              Navigator.pushNamed(context, '/choose_side');
            },
          ),
          SizedBox(
            height: height / 50,
          ),
          const Button(
            fontColor: Colors.white,
            backgroundColor: Colors.transparent,
            borderColor: Colors.white,
            text: 'With a friend',
          ),
        ],
      ),
    );
  }
}
