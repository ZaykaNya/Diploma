import 'dart:ui';

import 'package:diplom/models/log.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/material.dart';

class AverageDashboard extends StatefulWidget {
  final List<UserLog> logs;

  const AverageDashboard({Key? key, required this.logs}) : super(key: key);

  @override
  State<AverageDashboard> createState() => _AverageDashboardState();
}

class _AverageDashboardState extends State<AverageDashboard> {
  double _dailyProgress = 0;

  @override
  void initState() {
    countDailyProgress();
    super.initState();
  }

  void countDailyProgress() {
    double progress = 50;

    for(UserLog userLog in widget.logs) {
      progress += int.parse(userLog.seconds.toString());
    }

    setState(() {
      _dailyProgress = progress.roundToDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          widget: Text('$_dailyProgress %',
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
                          value: _dailyProgress,
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
              child: const Text("Файно, візьми паляничку!",
                  style: TextStyle(
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
                            const TextSpan(text: "5"),
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
                            const TextSpan(text: "2"),
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
