import 'dart:ui';

import 'package:flutter/material.dart';

class HistoryRow extends StatelessWidget {
  const HistoryRow({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HistoryRow());
  }

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
            children: const [
              Padding( padding: EdgeInsets.only(top: 32)),
              Text('Hardworker',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(93, 92, 99, 1))),
              Padding(padding: EdgeInsets.only(top: 4)),
              Text('You’ve completed 5 courses. Great motivation!',
                  style: TextStyle(
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
