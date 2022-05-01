import 'dart:ui';

import 'package:flutter/material.dart';

class HistoryRow extends StatelessWidget {
  final String header;
  final String label;

  const HistoryRow({
    Key? key,
    required this.header,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding( padding: EdgeInsets.only(top: 32)),
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
        )
      ],
    );
  }
}
