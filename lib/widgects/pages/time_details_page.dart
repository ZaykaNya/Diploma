import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:diplom/blocs/user/user_bloc.dart';
import 'package:diplom/blocs/user/user_state.dart';
import 'package:diplom/models/chart_data.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:diplom/widgects/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TimeDetailsPage extends StatefulWidget {
  final List<String> branches;
  final List<String> branchCaptions;
  final List<UserLog> userWeekLogs;
  final List<UserLog> userLogs;
  final String course;

  const TimeDetailsPage(
      {Key? key,
      required this.branches,
      required this.branchCaptions,
      required this.course,
      required this.userWeekLogs,
      required this.userLogs})
      : super(key: key);

  @override
  State<TimeDetailsPage> createState() => _TimeDetailsPageState();
}

class _TimeDetailsPageState extends State<TimeDetailsPage> {
  static List<List<ChartData>> _timeChartData = [<ChartData>[]];
  static List<ChartData> _totalTimeChartData = <ChartData>[];
  static List<String> _days = [];

  @override
  void initState() {
    Calculator calculator = Calculator();
    var now = DateTime.now();
    var startFrom = now.subtract(Duration(days: now.weekday));
    _days = List.generate(
        7, (i) => DateFormat('EEEE').format(startFrom.add(Duration(days: i))));
    _totalTimeChartData = calculator.countTimeByBranches(
        widget.userLogs, widget.course.toLowerCase(), widget.branches);
    _timeChartData = calculator.countTimeForLast7Days(widget.userLogs, widget.course, widget.branches);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(80, 71, 153, 1),
          toolbarHeight: 54,
          title: const Text('Time details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserInitial) {
                    return Container();
                  } else if (state is UserLoading) {
                    return Container();
                  } else if (state is UserLoaded) {
                    return Profile(
                      name: state.user.user.name,
                      surname: state.user.user.surname,
                      login: state.user.user.login,
                    );
                  } else if (state is UserError) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
              const Divider(
                height: 10,
                thickness: 10,
                color: Color.fromRGBO(218, 220, 239, 1),
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Text("Total time by pages in mins",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(93, 92, 99, 1)))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <CartesianSeries>[
                        ColumnSeries<ChartData, String>(
                          color: const Color.fromRGBO(56, 179, 158, 1),
                          dataSource: _totalTimeChartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                        )
                      ])),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < widget.branchCaptions.length; i++) ...{
                        Text('${i + 1} - ${widget.branchCaptions[i]}',
                            style: const TextStyle(
                                color: Color.fromRGBO(93, 92, 99, 1)))
                      }
                    ],
                  )),
              const Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Text("Time by pages in mins for last 7 days",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(93, 92, 99, 1)))),
              for (int i = 0; i < _days.length; i++) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                        child: Text(_days[i],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(93, 92, 99, 1)))),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            series: <CartesianSeries>[
                              ColumnSeries<ChartData, String>(
                                color: const Color.fromRGBO(56, 179, 158, 1),
                                dataSource: _timeChartData[i],
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                              )
                            ])),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < widget.branchCaptions.length; i++) ...{
                              Text('${i + 1} - ${widget.branchCaptions[i]}',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(93, 92, 99, 1)))
                            }
                          ],
                        )),
                    const Padding(padding: EdgeInsets.only(top: 16)),
                  ],
                )
              ]
            ],
          ),
        ));
  }
}
