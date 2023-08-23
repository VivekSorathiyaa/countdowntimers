import 'dart:async';
import 'dart:developer';

import 'package:dev_digital/view/widget/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RxList<TimerWidget> timerWidgetList = <TimerWidget>[].obs;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6F8),
      appBar: AppBar(
        title: const Text('Count down timers'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: timerWidgetList.length,
                itemBuilder: (context, index) => timerWidgetList[index],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              timerWidgetList.add(TimerWidget());
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black),
                child: const Center(
                  child: Text(
                    "Add Timer",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
