import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class StatisticWidget extends StatefulWidget {
  final int courseProgress;
  const StatisticWidget({Key? key, required this.courseProgress}) : super(key: key);

  @override
  State<StatisticWidget> createState() => _StatisticWidgetState();
}

class _StatisticWidgetState extends State<StatisticWidget> {
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
            padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Text("Course progress",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(93, 92, 99, 1)))),
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: SfLinearGauge(
                showTicks: false,
                interval: 100,
                axisLabelStyle: const TextStyle(
                    color:  Color.fromRGBO(93, 92, 99, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                axisTrackStyle: const LinearAxisTrackStyle(
                    thickness: 20, edgeStyle: LinearEdgeStyle.bothCurve),
              barPointers: [
                LinearBarPointer(
                    value: double.parse(widget.courseProgress.toString()),
                    thickness: 20,
                    edgeStyle: LinearEdgeStyle.bothCurve,
                    //Apply linear gradient
                    shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromRGBO(80, 69, 153, 1),
                          Color.fromRGBO(56, 179, 158, 1),
                          Color.fromRGBO(41, 245, 41, 1),
                        ])
                        .createShader(bounds)
                ),
              ],
            )
        ),
      ],
    );
  }
}
