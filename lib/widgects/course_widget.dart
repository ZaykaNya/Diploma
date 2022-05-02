import 'dart:ui';

import 'package:flutter/material.dart';

class Course extends StatelessWidget {
  final String course;
  final String progress;
  final String time;

  const Course({
    Key? key,
    required this.course,
    required this.progress,
    required this.time
  }) : super(key: key);

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
                  Text(course,
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
                            TextSpan(text: progress),
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
                            TextSpan(text: time),
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
