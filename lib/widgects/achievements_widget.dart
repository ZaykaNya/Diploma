import 'dart:ui';

import 'package:diplom/models/log.dart';
import 'package:diplom/models/test.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:flutter/material.dart';

import 'achievement_widget.dart';

class Achievements extends StatefulWidget {
  final List<UserLog> userLogs;
  final List<dynamic> courses;
  final List<Test> userTests;

  const Achievements({Key? key, required this.userLogs, required this.courses, required this.userTests})
      : super(key: key);

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  List _achievements = [];
  List _uncompletedAchievements = [];

  @override
  void initState() {
    final Calculator calculator = Calculator();
    List listOfAchievements =
        calculator.getGlobalAchievements(widget.courses, widget.userLogs, widget.userTests);
    _achievements = listOfAchievements[0];
    _uncompletedAchievements = listOfAchievements[1];
    super.initState();
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
                padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Text("Global achievements",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(93, 92, 99, 1)))),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  if (_achievements.isEmpty) ...{
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 32, 0, 16),
                        child: Text('You don`t have achievements yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(93, 92, 99, 1))),
                      ),
                    ),
                  },
                  for(var achievement in _achievements) ...[
                    Achievement(
                      header: achievement['header'],
                      label: achievement['label'],
                      uncompleted: achievement['uncompleted'],
                    )
                  ],
                  if (_uncompletedAchievements.isNotEmpty) ...{
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 24, 0, 16),
                            child: Text("Uncompleted achievements",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(93, 92, 99, 1)))),
                        for(var achievement in _uncompletedAchievements) ...[
                          Achievement(
                            header: achievement['header'],
                            label: achievement['label'],
                            uncompleted: achievement['uncompleted'],
                          )
                        ]
                      ],
                    )
                  },
                ],
              ),
            )
          ],
        ));
  }
}
