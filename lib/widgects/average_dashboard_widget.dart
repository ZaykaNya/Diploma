import 'dart:ui';

import 'package:diplom/models/log.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/material.dart';

class AverageDashboard extends StatefulWidget {
  final List<UserLog> logs;
  final List<UserLog> userLogs;
  final List<dynamic> courses;

  const AverageDashboard({Key? key, required this.logs, required this.userLogs, required this.courses}) : super(key: key);

  @override
  State<AverageDashboard> createState() => _AverageDashboardState();
}

class _AverageDashboardState extends State<AverageDashboard> with TickerProviderStateMixin {
  bool _loaded = false;
  late AnimationController controller;
  double _weeklyProgress = 0;
  int _completedCourses = 0;
  int _inProgressCourses = 0;
  String _message = "Lets learn something new today";

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
      setState(() {});
    });
    super.initState();
    initWidgetState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void initWidgetState() async {
    final prefs = await SharedPreferences.getInstance();

    final bool? averageDashboardUserSame = prefs.getBool('averageDashboardUserSame');

    final double? weeklyProgress = prefs.getDouble('weeklyProgress');
    final int? completedCourses = prefs.getInt('completedCourses');
    final int? inProgressCourses = prefs.getInt('inProgressCourses');
    final String? message = prefs.getString('message');

    if(weeklyProgress != null && completedCourses != null && inProgressCourses != null && message != null && averageDashboardUserSame == true) {
      setState(() {
        _weeklyProgress = weeklyProgress;
        _completedCourses = completedCourses;
        _inProgressCourses = inProgressCourses;
        _message = message;
        _loaded = true;
      });
    } else {
      final Calculator calculator = Calculator();
      List coursesProgress = calculator.countCompletedCourses(widget.courses, widget.userLogs);

      setState(() {
        _weeklyProgress = calculator.countWeeklyProgress(widget.logs);
        _completedCourses = coursesProgress[0];
        _inProgressCourses = coursesProgress[1];
        _message = calculator.getDailyProgressMessage(_weeklyProgress);
        _loaded = true;
      });

      await prefs.setDouble('weeklyProgress', _weeklyProgress);
      await prefs.setInt('completedCourses', _completedCourses);
      await prefs.setInt('inProgressCourses', _inProgressCourses);
      await prefs.setString('message', _message);
      await prefs.setBool('averageDashboardUserSame', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(!_loaded) {
      return Container(
        height: MediaQuery.of(context).size.height / 2,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              value: controller.value,
            ),
            const Padding(padding: EdgeInsets.only(top: 8)),
            const Text(
              'Loading...',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(93, 92, 99, 1)),
            ),
          ],
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            height: 10,
            thickness: 10,
            color: Color.fromRGBO(218, 220, 239, 1),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Text("Average score",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(93, 92, 99, 1)))),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SfRadialGauge(axes: <RadialAxis>[
                    RadialAxis(
                      radiusFactor: 0.8,
                      minimum: 0,
                      maximum: 100,
                      showLabels: false,
                      showTicks: false,
                      annotations: [
                        GaugeAnnotation(
                            widget: Text('$_weeklyProgress %',
                                style: const TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(93, 92, 99, 1))),
                            angle: 90,
                            positionFactor: 0.1)
                      ],
                      axisLineStyle: const AxisLineStyle(
                          cornerStyle: CornerStyle.bothCurve,
                          color: Color.fromRGBO(235, 235, 235, 1),
                          thickness: 30),
                      pointers: [
                        RangePointer(
                            value: _weeklyProgress,
                            cornerStyle: CornerStyle.bothCurve,
                            width: 30,
                            sizeUnit: GaugeSizeUnit.logicalPixel,
                            gradient: const SweepGradient(colors: <Color>[
                              Color.fromRGBO(80, 69, 153, 1),
                              Color.fromRGBO(56, 179, 158, 1),
                              Color.fromRGBO(41, 245, 41, 1),
                            ], stops: <double>[
                              0.2,
                              0.7,
                              0.9
                            ])),
                      ],
                    ),
                  ])
                ],
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -35.0, 0.0),
                child: Text(_message,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(93, 92, 99, 1))),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(134, 137, 235, 1)),
                            children: [
                              TextSpan(text: "$_completedCourses"),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(4, 0, 0, 5),
                                  child: Image.asset(
                                      'assets/images/checkmark_icon.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text("Completed",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(140, 138, 149, 1))),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(right: 48)),
                    const VerticalDivider(
                      width: 2,
                      thickness: 2,
                      color: Color.fromRGBO(235, 235, 235, 1),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 48)),
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(30, 176, 159, 1)),
                            children: [
                              TextSpan(text: "$_inProgressCourses"),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(4, 0, 0, 5),
                                  child: Image.asset(
                                      'assets/images/pencil_icon.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text("In progress",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(140, 138, 149, 1))),
                      ],
                    )
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 32)),
            ],
          )
        ],
      );
    }
  }
}
