import 'dart:async';
import 'package:flutter/material.dart';

class ProgressWidget extends StatefulWidget {
  final ValueNotifier<bool> isProgressRunning;
  ProgressWidget({super.key, ValueNotifier<bool>? isProgressRunning})
      : isProgressRunning = isProgressRunning ?? ValueNotifier(false);

  @override
  ProgressWidgetState createState() => ProgressWidgetState();
}

class ProgressWidgetState extends State<ProgressWidget> {
  final ValueNotifier<double> valueProgress = ValueNotifier(0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startProgress();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startProgress() {
    const interval = Duration(milliseconds: 100);
    const total = 30;
    resetProgress();
    //widget.isProgressRunning.value = true;
    _timer = Timer.periodic(interval, (timer) {
      final progress = 1 - timer.tick / (total * 10);
      valueProgress.value = progress;
      if (progress == 0) {
        timer.cancel();
        widget.isProgressRunning.value = false;
      }
    });
  }

  void resetProgress() {
    valueProgress.value = 0;
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isProgressRunning,
      builder: (context, isRunning, _) {
        if (isRunning) {
          startProgress();
        } else {
          resetProgress();
        }
        return ValueListenableBuilder<double>(
          valueListenable: valueProgress,
          builder: (context, value, _) {
            bool isValueLessThan15 = value < 0.5;
            bool isValueLessThan10 = value < 0.33;
            Color progressColor = Colors.green;
            if (isValueLessThan15) {
              progressColor = Colors.yellow;
            }
            if (isValueLessThan10) {
              progressColor = Colors.red;
            }
            return Stack(
              alignment: Alignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: value > 0
                      ? CircularProgressIndicator(
                          key: const ValueKey<int>(1),
                          value: value,
                          backgroundColor: Colors.deepPurpleAccent,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(progressColor),
                        )
                      : Container(
                          key: const ValueKey<int>(2),
                        ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 100,
                  ),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: value > 0
                      ? Text(
                          key: const ValueKey<int>(3),
                          '${(value * 30).toStringAsFixed(0)} s',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        )
                      : const Text(
                          key: ValueKey<int>(4),
                          '-',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
