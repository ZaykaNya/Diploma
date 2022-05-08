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
  List<int> _achievements = [];

  @override
  void initState() {
    final Calculator calculator = Calculator();
    _achievements =
        calculator.getGlobalAchievements(widget.courses, widget.userLogs, widget.userTests);
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
                  if (_achievements.contains(1)) ...{
                    const Achievement(
                      header: 'Newcomer',
                      label: 'You’ve enrolled your first course. Keep it up!',
                    ),
                  },
                  if (_achievements.contains(2)) ...{
                    const Achievement(
                      header: 'First win',
                      label: 'You’ve completed your first course. Well done!',
                    ),
                  },
                  if (_achievements.contains(3)) ...{
                    const Achievement(
                      header: 'Smarter?',
                      label: 'You’ve taken your first test.',
                    ),
                  },
                  if (_achievements.contains(4)) ...{
                    const Achievement(
                      header: 'Boss of the test',
                      label: 'You’ve got 100% in test.',
                    ),
                  },
                ],
              ),
            )
          ],
        ));
  }
}
