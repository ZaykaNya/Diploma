import 'dart:ui';

import 'package:flutter/material.dart';

import 'history_row_widget.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const History());
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
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: const [
                  HistoryRow(
                    header: '1h 35m',
                    label: 'Something happened\nIdk',
                  ),
                  HistoryRow(
                    header: '1h 45m',
                    label: 'Something happened\nIdk',
                  ),
                  HistoryRow(
                    header: '1h 45m',
                    label: 'Something happened\nIdk',
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}