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
            const Icon(Icons.radio_button_checked,
                size: 103, color: Colors.blueAccent),
            const Padding(padding: EdgeInsets.only(right: 0)),
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
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(140, 138, 149, 1)),
                          children: [
                            const WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                child: Icon(Icons.star,
                                    size: 24, color: Colors.orange),
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
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(140, 138, 149, 1)),
                          children: [
                            const WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                child: Icon(Icons.timer,
                                    size: 24, color: Colors.blue),
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
        const Padding(padding: EdgeInsets.only(top: 8)),
        const Divider(
          height: 2,
          thickness: 2,
          indent: 8,
          endIndent: 8,
          color: Color.fromRGBO(235, 235, 235, 1),
        ),
        const Padding(padding: EdgeInsets.only(top: 8)),
      ],
    );
  }
}
