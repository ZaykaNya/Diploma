import 'dart:ui';

import 'package:diplom/models/chart_data.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/mark.dart';
import 'package:diplom/models/test.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class StatisticWidget extends StatefulWidget {
  final int courseProgress;
  final String course;
  final double timeSpent;
  final Mark bestMark;
  final List<Test> courseTests;
  final List<UserLog> userWeekLogs;

  const StatisticWidget(
      {Key? key,
      required this.courseProgress,
      required this.userWeekLogs,
      required this.course,
      required this.bestMark,
      required this.courseTests,
      required this.timeSpent})
      : super(key: key);

  @override
  State<StatisticWidget> createState() => _StatisticWidgetState();
}

class _StatisticWidgetState extends State<StatisticWidget> {
  static List<ChartData> _timeChartData = <ChartData>[];
  static List<ChartData> _testChartData = <ChartData>[];

  @override
  void initState() {
    Calculator calculator = Calculator();
    _timeChartData =
        calculator.getTimeChartData(widget.userWeekLogs, widget.course);
    _testChartData =
        calculator.getTestsChartData(widget.courseTests, widget.bestMark);
    super.initState();
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
                  color: Color.fromRGBO(93, 92, 99, 1),
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
                            ]).createShader(bounds)),
              ],
            )),
        const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Text("Time spent for last 7 days",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(93, 92, 99, 1)))),
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <CartesianSeries>[
                  SplineSeries<ChartData, String>(
                    width: 3,
                    color: const Color.fromRGBO(56, 179, 158, 1),
                    dataSource: _timeChartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                  )
                ])),
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text("Total time spent: ${widget.timeSpent} h.",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(93, 92, 99, 1)))),
        const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Text("Test results",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(93, 92, 99, 1)))),
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: SfCartesianChart(
                isTransposed: true,
                primaryXAxis: CategoryAxis(),
                primaryYAxis: CategoryAxis(
                  minimum: 0,
                  maximum: 100,
                  interval: 20,
                ),
                series: <ChartSeries>[
                  BarSeries<ChartData, String>(
                      color: const Color.fromRGBO(56, 179, 158, 1),
                      width: 0.25,
                      spacing: 0.1,
                      dataSource: _testChartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y)
                ])),
      ],
    );
  }
}
