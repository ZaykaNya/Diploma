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
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(padding: EdgeInsets.fromLTRB(12, 16, 8, 16),
                child: Text("Your courses", style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(93, 92, 99, 1)))),
            Course(),
            Course(),
            Course(),
          ],
        ));
  }
}