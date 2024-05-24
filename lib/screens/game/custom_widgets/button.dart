import 'dart:developer';

import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Color fontColor;
  final Color borderColor;
  final Color backgroundColor;
  final String text;
  final VoidCallback?
      onPressed; //execute optional function when button is pressed
  const Button({
    super.key,
    required this.fontColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    this.onPressed,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  String get textBtn => widget.text;
  late Color currentFontColor;

  @override
  void initState() {
    currentFontColor = widget.fontColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        setState(() {
          currentFontColor = Colors.deepPurple;
        });
      },
      onPanCancel: () {
        setState(() {
          currentFontColor = widget.fontColor;
        });
      },
      child: TextButton(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(200, 60)),
          backgroundColor: WidgetStateProperty.all(widget.backgroundColor),
          overlayColor: WidgetStateProperty.all(
            widget.backgroundColor == Colors.transparent
                ? Colors.white.withOpacity(0.8)
                : Colors.transparent,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.white, width: 1),
            ),
          ),
        ),
        onPressed: () {
          widget.onPressed!();
          log(textBtn);
        },
        child: Text(textBtn,
            style: TextStyle(
              fontSize: 20,
              color: currentFontColor,
            )),
      ),
    );
  }
}
