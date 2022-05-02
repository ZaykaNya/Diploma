import 'dart:ui';

import 'package:flutter/material.dart';

class Achievement extends StatelessWidget {
  final String header;
  final String label;

  const Achievement({Key? key, required this.header, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/achievement_icon.jpg'),
            const Padding(padding: EdgeInsets.only(right: 16)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(header,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(93, 92, 99, 1))),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  Text(label,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(140, 138, 149, 1))),
                ],
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 16)),
      ],
    );
  }
}
