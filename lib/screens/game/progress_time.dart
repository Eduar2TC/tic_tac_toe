import 'dart:async';

import 'package:flutter/material.dart';

class ProgressWidget extends StatefulWidget {
  final ValueNotifier<bool> isProgressRunning;
  const ProgressWidget({super.key, required this.isProgressRunning});

  @override
  ProgressWidgetState createState() => ProgressWidgetState();
}

class ProgressWidgetState extends State<ProgressWidget> {
  final ValueNotifier<double> progressNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    startProgress();
  }

  void startProgress() {
    const interval = Duration(milliseconds: 100);
    const total = 30;
    widget.isProgressRunning.value = true;
    Timer.periodic(interval, (timer) {
      final progress = 1 - timer.tick / (total * 10);
      progressNotifier.value = progress;
      if (progress == 0) {
        timer.cancel();
        widget.isProgressRunning.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isProgressRunning,
      builder: (context, isRunning, _) {
        if (isRunning) {
          startProgress();
        }
        return ValueListenableBuilder(
          valueListenable: progressNotifier,
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
                value > 0
                    ? CircularProgressIndicator(
                        value: value,
                        backgroundColor: Colors.deepPurpleAccent,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(progressColor),
                      )
                    : Container(),
                value > 0
                    ? Text(
                        '${(value * 30).toStringAsFixed(0)} s',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      )
                    : const Text(
                        '-',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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
