import 'dart:ui';
import 'package:diplom/blocs/user/user_bloc.dart';
import 'package:diplom/blocs/user/user_state.dart';
import 'package:diplom/models/test.dart';
import 'package:diplom/widgects/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

String printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}

class TestsDetailsPage extends StatefulWidget {
  final List<Test> courseTests;
  final String course;

  const TestsDetailsPage({Key? key, required this.courseTests, required this.course})
      : super(key: key);

  @override
  State<TestsDetailsPage> createState() => _TestsDetailsPageState();
}

class _TestsDetailsPageState extends State<TestsDetailsPage> {
  String _courseName = "";

  @override
  void initState() {
    _courseName = widget.course.toLowerCase().split('-')[0];
    print(_courseName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(80, 71, 153, 1),
        toolbarHeight: 54,
        title: const Text('Tests details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
      ),
      backgroundColor: Colors.white,
      body: Column(
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
              child: Text("All tests",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(93, 92, 99, 1)))),
          for (var test in widget.courseTests.reversed) ...[
            if('${test.branchId}'.contains(_courseName) || '${test.courseId}'.contains(_courseName)) ...{
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            test.branchId != null
                                ? '${test.branchId}'
                                : '${test.courseId}',
                            style: const TextStyle(
                                color: Color.fromRGBO(93, 92, 99, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        Text(
                            'time: ${printDuration(Duration(seconds: DateTime.parse('${test.timeEnd}').difference(DateTime.parse('${test.timeStart}')).inSeconds))}',
                            style: const TextStyle(
                                color: Color.fromRGBO(93, 92, 99, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
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
                              value: double.parse(test.percentage.toString()),
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
                ],
              )
            }
          ]
        ],
      ),
    );
  }
}
