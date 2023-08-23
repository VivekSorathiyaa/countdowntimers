import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerWidget extends StatefulWidget {
  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  RxInt seconds = 0.obs;
  RxInt previousSecond = 0.obs;
  RxBool isRunning = false.obs;
  Timer? _timer;

  void startTimer() {
    seconds.value = previousSecond.value;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        isRunning.value = false;
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  void toggleTimer() {
    if (isRunning.value) {
      isRunning.value = false;
      if (_timer != null) {
        _timer!.cancel();
      }
    } else {
      isRunning.value = true;
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 10.0,
              color: Color(0xffE9E9E9),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xffE9E9E9),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Obx(
                  () => TextField(
                    onChanged: (value) {
                      if (value != null && value.isNotEmpty) {
                        previousSecond.value = int.tryParse(value) ?? 0;
                      }
                    },
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: 'Seconds',
                      labelStyle:
                          const TextStyle(fontSize: 12, color: Colors.black),
                      fillColor: const Color(0xffF7F7F7),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                    ),
                    enabled: !isRunning.value,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Obx(
                      () => Text(
                        Duration(seconds: seconds.value)
                            .toString()
                            .split('.')
                            .first,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              Expanded(
                flex: 3,
                child: GestureDetector(
                    onTap: toggleTimer,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black),
                      child: Center(
                        child: Obx(
                          () => Text(
                            isRunning.value
                                ? 'Pause'
                                : seconds <= 0
                                    ? 'Start'
                                    : 'Resume',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
