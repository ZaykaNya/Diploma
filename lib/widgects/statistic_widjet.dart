import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}

class StatisticWidget extends StatefulWidget {
  final int courseProgress;
  const StatisticWidget({Key? key, required this.courseProgress}) : super(key: key);

  @override
  State<StatisticWidget> createState() => _StatisticWidgetState();
}

class _StatisticWidgetState extends State<StatisticWidget> {
  static List<ChartData> _chartData = <ChartData>[];
  static List<ChartData> _chartData2 = <ChartData>[];

  @override
  void initState() {
    _chartData = <ChartData>[
      ChartData('Mon', 1),
      ChartData('Tue', 2),
      ChartData('Wed', 1),
      ChartData('Thu', 4),
      ChartData('Fri', 2),
      ChartData('Sut', 5),
      ChartData('Sun', 0),
    ];

    _chartData2 = <ChartData>[
      ChartData('Average', 58),
      ChartData('You`re best', 100),
    ];
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
        const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Text("Time spent through week:",
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
                    dataSource: _chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                  )
                ]
            )
        ),
        const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text("Total time spent: 10 h.",
                style: TextStyle(
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
                      dataSource: _chartData2,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y
                  )
                ]
            )
        ),
      ],
    );
  }
}