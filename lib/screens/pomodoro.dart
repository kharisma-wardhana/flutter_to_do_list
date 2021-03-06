import 'dart:async';

import 'package:dicoding_todo/theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wakelock/wakelock.dart';

class Pomodoro extends StatefulWidget {
  final String taskTitle;
  Pomodoro({Key key, this.taskTitle}) : super(key: key);

  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  static int timeInMinutes = 25;
  double currPercent = 1;
  int seconds = timeInMinutes * 60;
  int pauseTime = 5;
  Color progressColor = kSecondaryColor;
  bool isTimerRunning = false;
  Timer timer;
  String btnLearn = 'Start';

  startTimer() {
    timeInMinutes = 25;
    int times = timeInMinutes * 60;
    double secPercent = (times / 100);

    if (isTimerRunning) {
      setState(() {
        Wakelock.disable();
        timer.cancel();
        currPercent = 1;
        timeInMinutes = 25;
        isTimerRunning = false;
        progressColor = kSecondaryColor;
        btnLearn = 'Start';
      });
    }

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (times > 0) {
          isTimerRunning = !isTimerRunning;
          Wakelock.enable();
          times--;
          if (times <= 120) {
            progressColor = kPrimaryColor;
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
          btnLearn = 'End';
        } else {
          currPercent = 1;
          timeInMinutes = 25;
          progressColor = kSecondaryColor;
          isTimerRunning = false;
          timer.cancel();
          Wakelock.disable();
          btnLearn = 'Start';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeigth = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pomdoro App'),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: Container(
          width: screenWidth,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [kPrimaryLightColor, kPrimaryColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: screenHeigth / 2,
                child: CircularPercentIndicator(
                  reverse: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: currPercent,
                  animateFromLastPercent: true,
                  animation: true,
                  animationDuration: 300,
                  radius: 360,
                  lineWidth: 30,
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
              SizedBox(height: screenHeigth / 30),
              Expanded(
                  child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.taskTitle,
                              style: TextStyle(color: kTextColor, fontSize: 20),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeigth / 50,
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: renderFocusTime(),
                              ),
                              Expanded(
                                child: renderRestTime(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeigth / 50,
                        ),
                        renderButton()
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget renderFocusTime() {
    return Column(
      children: <Widget>[
        Text(
          "Focus Time",
          style: TextStyle(
              color: kTextColor, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            "$timeInMinutes",
            style: TextStyle(fontSize: 70, color: kTextColor),
          ),
          SizedBox(
            width: 5,
          ),
          Text("minutes", style: TextStyle(fontSize: 20, color: kTextColor))
        ])
      ],
    );
  }

  Widget renderRestTime() {
    return Column(
      children: <Widget>[
        Text(
          "Rest Time",
          style: TextStyle(
              color: kTextColor, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            "$pauseTime",
            style: TextStyle(fontSize: 70, color: kTextColor),
          ),
          SizedBox(
            width: 5,
          ),
          Text("minutes", style: TextStyle(fontSize: 20, color: kTextColor))
        ])
      ],
    );
  }

  Widget renderButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: RaisedButton(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            btnLearn,
            style: TextStyle(color: Color(0xFFFBFBFF), fontSize: 20),
          ),
        ),
        color: kSecondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          startTimer();
        },
      ),
    );
  }
}
