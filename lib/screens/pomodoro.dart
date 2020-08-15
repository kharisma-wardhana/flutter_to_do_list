import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Pomodoro extends StatefulWidget {
  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  double currPercent = 1;
  static int timeInMinutes = 25;
  int seconds = timeInMinutes * 60;
  int pauseTime = 5;
  Color progressColor = Color(0xFF3F84E5);
  bool isTimerRunning = false;
  Timer timer;

  startTimer() {
    print("start");
    timeInMinutes = 25;
    int times = timeInMinutes * 60;
    double secPercent = (times / 100);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print("checkTime $times");
      setState(() {
        print("setState Checked");
        isTimerRunning = true;
        if (times > 0) {
          times--;
          if (times <= 120) {
            progressColor = Color(0xFFF55D3E);
          }
          if (times % 60 == 0) {
            timeInMinutes--;
          }
          if (times % secPercent == 0) {
            if (currPercent > 0) {
              currPercent -= 0.01;
            } else {
              currPercent = 0;
            }
          }
        } else {
          currPercent = 1;
          timeInMinutes = 25;
          progressColor = Color(0xFF3F84E5);
          isTimerRunning = false;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Pomodoro App",
              style: TextStyle(color: Color(0xFFFBFBFF), fontSize: 25),
            ),
          ),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF134611), Color(0xFF23967F)],
                    begin: FractionalOffset(0.5, 1))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: CircularPercentIndicator(
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: currPercent,
                    animateFromLastPercent: true,
                    animation: true,
                    radius: 360,
                    lineWidth: 20,
                    progressColor: progressColor,
                    center: Text(
                      "$timeInMinutes",
                      style: TextStyle(
                        color: Color(0xFFFBFBFF),
                        fontSize: 80,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 80),
                Expanded(
                    child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFFBFBFF),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Belajar",
                                      style: TextStyle(
                                          color: Color(0xFF150578),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "$timeInMinutes",
                                            style: TextStyle(fontSize: 70),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("menit",
                                              style: TextStyle(fontSize: 20))
                                        ])
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Istirahat",
                                      style: TextStyle(
                                          color: Color(0xFF150578),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "$pauseTime",
                                            style: TextStyle(fontSize: 70),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("menit",
                                              style: TextStyle(fontSize: 20))
                                        ])
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 28),
                          child: RaisedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "Mulai Belajar",
                                style: TextStyle(
                                    color: Color(0xFFFBFBFF), fontSize: 20),
                              ),
                            ),
                            color: Color(0xFFF55D3E),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            onPressed: () {
                              startTimer();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
          )),
    );
  }
}
