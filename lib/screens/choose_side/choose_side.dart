import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/choose_side/custom_widgets/choose_side_button.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/button.dart';
import 'package:tic_tac_toe/utils/figures.dart';

class ChooseSide extends StatefulWidget {
  const ChooseSide({super.key});
  @override
  State<ChooseSide> createState() => _ChooseSideState();
}

class _ChooseSideState extends State<ChooseSide> {
  bool isButtonOTapped = false;
  bool isButtonXTapped = false;

  late Figure figure; // user's chosen figure
  Color buttonBorderColor = Colors.white;
  @override
  void initState() {
    super.initState();
    figure = Figure.empty;
  }

  void changeBorderColor(Color color) {
    setState(() {
      buttonBorderColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

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
            children: [
              const Text(
                'Choose a side',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: height / 10,
              ),
              ChooseSideButton(
                figure: Figure.circle,
                isTapped: isButtonOTapped,
                onTap: () {
                  setState(() {
                    isButtonOTapped = !isButtonOTapped;
                    isButtonOTapped
                        ? figure = Figure.circle
                        : figure = Figure.empty;
                    //deactivate buttonX button
                    if (isButtonXTapped) isButtonXTapped = false;
                  });
                },
              ),
              SizedBox(
                height: height / 20,
              ),
              ChooseSideButton(
                figure: Figure.cross,
                isTapped: isButtonXTapped,
                onTap: () {
                  setState(() {
                    isButtonXTapped = !isButtonXTapped;
                    isButtonXTapped
                        ? figure = Figure.cross
                        : figure = Figure.empty;
                    //deactivate buttonO button
                    if (isButtonOTapped) isButtonOTapped = false;
                  });
                },
              ),
              SizedBox(
                height: height / 30,
              ),
              Button(
                fontColor: Colors.white,
                backgroundColor: Colors.transparent,
                borderColor: buttonBorderColor,
                text: 'Start game',
                onPressed: figure == Figure.cross || figure == Figure.circle
                    ? () {
                        changeBorderColor(Colors.white);
                        log('figure: $figure');
                        Navigator.pushNamed(
                          context,
                          '/game',
                          arguments: figure,
                        );
                      }
                    : () {
                        null;
                        changeBorderColor(Colors.red);
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
