import 'dart:ui';

import 'package:flutter/material.dart';

class Achievement extends StatelessWidget {
  const Achievement({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const Achievement());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.account_box_sharp,
            size: 103, color: Color.fromRGBO(154, 153, 162, 1)),
        const Padding(padding: EdgeInsets.only(right: 0)),
        Expanded(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Newcomer',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(93, 92, 99, 1))),
              Padding(padding: EdgeInsets.only(top: 4)),
              Text('You’ve completed your first course. Keep it up! ',
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
