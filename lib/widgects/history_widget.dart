import 'dart:convert';
import 'dart:ui';

import 'package:diplom/api/courses.dart';
import 'package:diplom/api/tests.dart';
import 'package:diplom/models/chart_data_compare.dart';
import 'package:diplom/models/course.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/test.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class History extends StatefulWidget {
  final List<dynamic> courses;
  final List<UserLog> userLogs;
  final List<UserLog> allLogs;
  final List<Test> userTests;

  const History({
    Key? key,
    required this.courses,
    required this.userLogs,
    required this.allLogs,
    required this.userTests,
  }) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with TickerProviderStateMixin {
  bool _pageLoaded = false;
  late AnimationController controller;
  List<ChartDataCompare> _chartTimeDataCompare = <ChartDataCompare>[];
  List<ChartDataCompare> _chartTestsResultsDataCompare = <ChartDataCompare>[];
  List<ChartDataCompare> _chartTestsDurationDataCompare = <ChartDataCompare>[];
  List<Course> listOfCourses = [];
  String _courseTime = "";
  String _courseTimeWord = "more";
  String _testsPercentage = "";
  String _testsPercentageWord = "";
  String _testsTime = "";
  String _testsTimeWord = "";

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    initPageState(widget.courses);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void initPageState(courses) async {
    final prefs = await SharedPreferences.getInstance();

    final String? chartTimeDataCompareStr = prefs.getString('chartTimeDataCompare');
    final String? testsTimeWordStr = prefs.getString('testsTimeWord');
    final String? testsTimeStr = prefs.getString('testsTime');
    final String? chartTestsResultsDataCompareStr = prefs.getString('chartTestsResultsDataCompare');
    final String? testsPercentageWordStr = prefs.getString('testsPercentageWord');
    final String? testsPercentageStr = prefs.getString('testsPercentage');
    final String? chartTestsDurationDataCompareStr = prefs.getString('chartTestsDurationDataCompare');
    final String? courseTimeWordStr = prefs.getString('courseTimeWord');
    final String? courseTimeStr = prefs.getString('courseTime');

    if(chartTimeDataCompareStr != null && testsTimeWordStr != null && testsTimeStr != null && chartTestsResultsDataCompareStr != null
        && testsPercentageWordStr != null && testsPercentageStr != null && chartTestsDurationDataCompareStr != null && courseTimeWordStr != null
        && courseTimeStr != null) {
      List newChartTimeDataCompareFromJSON = jsonDecode(chartTimeDataCompareStr);
      List newChartTestsResultsDataCompareFromJSON = jsonDecode(chartTestsResultsDataCompareStr);
      List newChartTestsDurationDataCompareFromJSON = jsonDecode(chartTestsDurationDataCompareStr);

      List<ChartDataCompare> newChartTimeDataCompare = [];
      List<ChartDataCompare> newChartTestsResultsDataCompare = [];
      List<ChartDataCompare> newChartTestsDurationDataCompare = [];

      for(var data in newChartTimeDataCompareFromJSON) {
        newChartTimeDataCompare.add(
            ChartDataCompare(data['x'], data['y1'], data['y2'])
        );
      }

      for(var data in newChartTestsResultsDataCompareFromJSON) {
        newChartTestsResultsDataCompare.add(
            ChartDataCompare(data['x'], data['y1'], data['y2'])
        );
      }

      for(var data in newChartTestsDurationDataCompareFromJSON) {
        newChartTestsDurationDataCompare.add(
            ChartDataCompare(data['x'], data['y1'], data['y2'])
        );
      }

      setState(() {
        _chartTimeDataCompare = newChartTimeDataCompare;
        _courseTime = courseTimeStr;
        _courseTimeWord = courseTimeWordStr;
        _chartTestsResultsDataCompare = newChartTimeDataCompare;
        _testsPercentage = testsPercentageStr;
        _testsPercentageWord = testsPercentageWordStr;
        _chartTestsDurationDataCompare = newChartTestsDurationDataCompare;
        _testsTime = testsTimeStr;
        _testsTimeWord = testsTimeWordStr;
        _pageLoaded = true;
      });
    } else {
      Calculator calculator = Calculator();
      List<Course> listOfCourses = [];
      List<List<Test>> listOfCoursesTests = [];

      for (var course in courses) {
        dynamic data = await fetchCoursesByName(course['course']);
        listOfCourses.add(data);

        dynamic listOfCourseTests = await fetchTestsFromCourse(course['course']);
        listOfCoursesTests.add(listOfCourseTests);
      }

      List timeChartData = calculator.getTimeSpentOnCourseCompareData(
          widget.courses, widget.userLogs, widget.allLogs, listOfCourses);
      List testsChartData = calculator.getTestResultCompareData(
          widget.courses, listOfCoursesTests, widget.userTests);
      List testsDurationChartData = calculator.getTestDurationCompareData(
          widget.courses, listOfCoursesTests, widget.userTests);

      setState(() {
        _chartTimeDataCompare = timeChartData[0];
        _courseTime = timeChartData[1];
        _courseTimeWord = timeChartData[2];
        _chartTestsResultsDataCompare = testsChartData[0];
        _testsPercentage = testsChartData[1];
        _testsPercentageWord = testsChartData[2];
        _chartTestsDurationDataCompare = testsDurationChartData[0];
        _testsTime = testsDurationChartData[1];
        _testsTimeWord = testsDurationChartData[2];
        _pageLoaded = true;
      });

      List chartTimeDataCompareForJSON = [];
      List chartTestsResultsDataCompareForJSON = [];
      List chartTestsDurationDataCompareForJSON = [];

      for(ChartDataCompare data in _chartTimeDataCompare) {
        chartTimeDataCompareForJSON.add({
          'x': data.x,
          'y1': data.y1,
          'y2': data.y2
        });
      }

      for(ChartDataCompare data in _chartTestsResultsDataCompare) {
        chartTestsResultsDataCompareForJSON.add({
          'x': data.x,
          'y1': data.y1,
          'y2': data.y2
        });
      }

      for(ChartDataCompare data in _chartTestsDurationDataCompare) {
        chartTestsDurationDataCompareForJSON.add({
          'x': data.x,
          'y1': data.y1,
          'y2': data.y2
        });
      }

      await prefs.setString('chartTimeDataCompare', jsonEncode(chartTimeDataCompareForJSON));
      await prefs.setString('testsTimeWord', _testsTimeWord);
      await prefs.setString('testsTime', _testsTime);
      await prefs.setString('chartTestsResultsDataCompare', jsonEncode(chartTestsResultsDataCompareForJSON));
      await prefs.setString('testsPercentageWord', _testsPercentageWord);
      await prefs.setString('testsPercentage', _testsPercentage);
      await prefs.setString('chartTestsDurationDataCompare', jsonEncode(chartTestsDurationDataCompareForJSON));
      await prefs.setString('courseTimeWord', _courseTimeWord);
      await prefs.setString('courseTime', _courseTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(!_pageLoaded) {
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
      return Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 10,
                thickness: 10,
                color: Color.fromRGBO(218, 220, 239, 1),
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Text("Compare to others",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(93, 92, 99, 1)))),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: 16, color: Color.fromRGBO(93, 92, 99, 1)),
                    text: 'Usually you are spending ',
                    children: <TextSpan>[
                      TextSpan(
                          text: _courseTime,
                          style: TextStyle(color: _courseTimeWord == "more"
                              ? Colors.green
                              : Colors.red)),
                      const TextSpan(text: ' minutes '),
                      TextSpan(text: _courseTimeWord),
                      const TextSpan(
                          text: ' on course. You`re test results are '),
                      TextSpan(text: _testsPercentageWord),
                      const TextSpan(text: ' by '),
                      TextSpan(
                          text: '$_testsPercentage%',
                          style: TextStyle(
                              color: _testsPercentageWord == "better" ? Colors
                                  .green : Colors.red)),
                      const TextSpan(text: ' than average. You spend '),
                      TextSpan(
                          text: _testsTime,
                          style: TextStyle(color: _testsTimeWord == "less"
                              ? Colors.green
                              : Colors.red)),
                      const TextSpan(text: ' minutes '),
                      TextSpan(text: _testsTimeWord),
                      const TextSpan(text: ' on tests.'),
                    ],
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Text("Time spent on courses",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(93, 92, 99, 1)))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <CartesianSeries>[
                        BarSeries<ChartDataCompare, String>(
                            color: Colors.pinkAccent,
                            dataSource: _chartTimeDataCompare,
                            xValueMapper: (ChartDataCompare data, _) => data.x,
                            yValueMapper: (ChartDataCompare data, _) =>
                            data.y1),
                        BarSeries<ChartDataCompare, String>(
                            color: const Color.fromRGBO(56, 179, 158, 1),
                            dataSource: _chartTimeDataCompare,
                            xValueMapper: (ChartDataCompare data, _) => data.x,
                            yValueMapper: (ChartDataCompare data, _) =>
                            data.y2),
                      ])),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            color: const Color.fromRGBO(56, 179, 158, 1),
                          ),
                          const Text('  - you`re time spent on course in hours',
                              style: TextStyle(
                                  color: Color.fromRGBO(93, 92, 99, 1))),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 4)),
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            color: Colors.pinkAccent,
                          ),
                          const Text(
                              '  - average time spent on course in hours',
                              style: TextStyle(
                                  color: Color.fromRGBO(93, 92, 99, 1))),
                        ],
                      ),
                    ],
                  )),
              const Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Text("You`re and others tests results",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(93, 92, 99, 1)))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <CartesianSeries>[
                        BarSeries<ChartDataCompare, String>(
                            color: Colors.pinkAccent,
                            dataSource: _chartTestsResultsDataCompare,
                            xValueMapper: (ChartDataCompare data, _) => data.x,
                            yValueMapper: (ChartDataCompare data, _) =>
                            data.y1),
                        BarSeries<ChartDataCompare, String>(
                            color: const Color.fromRGBO(56, 179, 158, 1),
                            dataSource: _chartTestsResultsDataCompare,
                            xValueMapper: (ChartDataCompare data, _) => data.x,
                            yValueMapper: (ChartDataCompare data, _) =>
                            data.y2),
                      ])),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            color: const Color.fromRGBO(56, 179, 158, 1),
                          ),
                          const Text('  - you`re test result',
                              style: TextStyle(
                                  color: Color.fromRGBO(93, 92, 99, 1))),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 4)),
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            color: Colors.pinkAccent,
                          ),
                          const Text('  - average test result',
                              style: TextStyle(
                                  color: Color.fromRGBO(93, 92, 99, 1))),
                        ],
                      ),
                    ],
                  )),
              const Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Text("You`re and others tests duration",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(93, 92, 99, 1)))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <CartesianSeries>[
                        BarSeries<ChartDataCompare, String>(
                            color: Colors.pinkAccent,
                            dataSource: _chartTestsDurationDataCompare,
                            xValueMapper: (ChartDataCompare data, _) => data.x,
                            yValueMapper: (ChartDataCompare data, _) =>
                            data.y1),
                        BarSeries<ChartDataCompare, String>(
                            color: const Color.fromRGBO(56, 179, 158, 1),
                            dataSource: _chartTestsDurationDataCompare,
                            xValueMapper: (ChartDataCompare data, _) => data.x,
                            yValueMapper: (ChartDataCompare data, _) =>
                            data.y2),
                      ])),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            color: const Color.fromRGBO(56, 179, 158, 1),
                          ),
                          const Text('  - you`re test duration',
                              style: TextStyle(
                                  color: Color.fromRGBO(93, 92, 99, 1))),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 4)),
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            color: Colors.pinkAccent,
                          ),
                          const Text('  - average test duration',
                              style: TextStyle(
                                  color: Color.fromRGBO(93, 92, 99, 1))),
                        ],
                      ),
                    ],
                  )),
              const Padding(padding: EdgeInsets.only(top: 32)),
            ],
          ));
    }
  }
}
