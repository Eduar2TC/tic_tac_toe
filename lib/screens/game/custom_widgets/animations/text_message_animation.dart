import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextMessage extends StatefulWidget {
  final String message;
  final double fontSize;
  const TextMessage({super.key, required this.message, required this.fontSize});

  @override
  State<TextMessage> createState() => _TextMessageState();
}

class _TextMessageState extends State<TextMessage>
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
      curve: Curves.fastOutSlowIn,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _controller.reverse();
        });
      }
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _controller.forward();
    });
    super.initState();
  }

  /*@override
  void didChangeDependencies() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _controller.forward();
    });
    super.didChangeDependencies();
  }*/

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Transform.scale(
          scale: _animation.value,
          child: Text(
            widget.message,
            style: GoogleFonts.seymourOne(
              textStyle: TextStyle(
                fontSize: widget.fontSize,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: .2,
              ),
            ),
          ),
        );
      },
    );
  }
}
