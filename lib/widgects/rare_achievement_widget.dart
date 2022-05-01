import 'dart:ui';

import 'package:flutter/material.dart';

class RareAchievement extends StatelessWidget {
  final String header;
  final String course;
  final String label;

  const RareAchievement({
    Key? key,
    required this.header,
    required this.course,
    required this.label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.account_box_sharp,
            size: 116, color: Color.fromRGBO(154, 153, 162, 1)),
        const Padding(padding: EdgeInsets.only(right: 0)),
        Expanded(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(header,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(93, 92, 99, 1))),
              const Padding(padding: EdgeInsets.only(top: 4)),
              Text(course,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                      color: Color.fromRGBO(80, 71, 153, 1))),
              const Padding(padding: EdgeInsets.only(top: 4)),
              Text(label,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(140, 138, 149, 1))),
            ],
          ),
        )
      ],
    );
  }
}
