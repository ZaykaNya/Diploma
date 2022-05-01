import 'dart:ui';

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String name;
  final String surname;

  const Profile({
    Key? key,
    required this.name,
    required this.surname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
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
                text: TextSpan(
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color.fromRGBO(93, 92, 99, 1)),
                  children: [
                    TextSpan(text: '$name $surname'),
                    const WidgetSpan(
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