import 'package:flutter/material.dart';

class ValueTextAnimation extends StatelessWidget {
  const ValueTextAnimation({
    super.key,
    required this.valueNotifier,
  });

  final ValueNotifier<int> valueNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (context, valueNotifier, _) => Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder(
            key: ValueKey('old_$valueNotifier'),
            tween: Tween<double>(begin: 0, end: 30),
            curve: Curves.linear,
            duration: const Duration(milliseconds: 500),
            builder: (context, value, _) => Transform.translate(
              offset: Offset(0, value),
              child: Opacity(
                opacity: 1 - (value.abs() / 30),
                child: Text(
                  (valueNotifier - 1).toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          TweenAnimationBuilder(
            key: ValueKey('new_$valueNotifier'),
            tween: Tween<double>(begin: -30, end: 0),
            curve: Curves.elasticOut,
            duration: const Duration(milliseconds: 2000),
            builder: (context, value, _) => Transform.translate(
              offset: Offset(0, value),
              child: Opacity(
                opacity: 1 - (value.abs() / 80),
                child: _,
              ),
            ),
            child: Text(
              valueNotifier.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
