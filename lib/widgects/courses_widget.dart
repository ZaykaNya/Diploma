import 'dart:ui';

import 'package:flutter/material.dart';

import 'course_widget.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const Courses());
  }

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Text("Your courses",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(93, 92, 99, 1)))),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: const [
                  Course(
                    course: 'React',
                    progress: '85%',
                    time: '5 h.',
                  ),
                  Course(
                    course: 'React',
                    progress: '75%',
                    time: '5 h.',
                  ),
                  Course(
                    course: 'React',
                    progress: '75%',
                    time: '5 h.',
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
