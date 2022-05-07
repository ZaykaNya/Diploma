import 'dart:ui';

import 'package:diplom/models/log.dart';
import 'package:flutter/material.dart';

import '../utils/calculator.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class CourseWidget extends StatefulWidget {
  final String course;
  final List<UserLog> userLogs;

  const CourseWidget({
    Key? key,
    required this.course,
    required this.userLogs
  }) : super(key: key);

  @override
  State<CourseWidget> createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  int _progress = 0;
  double _time = 0;

  @override
  void initState() {
    final Calculator calculator = Calculator();
    setState(() {
      _progress = calculator.countProgress(widget.userLogs, widget.course);
      _time = calculator.countTime(widget.userLogs, widget.course);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/react_icon.png'),
            const Padding(padding: EdgeInsets.only(right: 16)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.course.capitalize(),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(93, 92, 99, 1))),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(140, 138, 149, 1)),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                                child: Image.asset('assets/images/star_icon.png'),
                              ),
                            ),
                            TextSpan(text: '$_progress %'),
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 60)),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(140, 138, 149, 1)),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                                child: Image.asset('assets/images/alarm_clock_icon.png'),
                              ),
                            ),
                            TextSpan(text: "$_time h."),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 16)),
        const Divider(
          height: 2,
          thickness: 2,
          indent: 8,
          endIndent: 8,
          color: Color.fromRGBO(235, 235, 235, 1),
        ),
        const Padding(padding: EdgeInsets.only(top: 16)),
      ],
    );
  }
}
