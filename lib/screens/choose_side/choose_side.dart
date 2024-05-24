import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/choose_side/custom_widgets/choose_side_button.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/button.dart';
import 'package:tic_tac_toe/utils/element_drawer.dart';

class ChooseSide extends StatefulWidget {
  const ChooseSide({super.key});
  @override
  State<ChooseSide> createState() => _ChooseSideState();
}

class _ChooseSideState extends State<ChooseSide> {
  bool isButtonOTapped = false;
  bool isButtonXTapped = false;
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
                borderColor: Colors.white,
                text: 'Start game',
                onPressed: () {
                  Navigator.pushNamed(context, '/game');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
