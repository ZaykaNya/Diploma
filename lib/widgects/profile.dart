import 'dart:ui';

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const Profile());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.account_circle, size: 76, color: Color.fromRGBO(154, 153, 162, 1)),
          const Padding(padding: EdgeInsets.only(right: 8)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color.fromRGBO(93, 92, 99, 1)),
                  children: [
                    TextSpan(text: 'Valery Grant'),
                    WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: Icon(Icons.accessible, color: Color.fromRGBO(93, 92, 99, 1)),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 4)),
              const Text('val.grant@gmail.com', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromRGBO(140, 138, 149, 1))),
            ],
          )
        ],
      ),
    );
  }
}