import 'dart:ui';

import 'package:diplom/models/log.dart';
import 'package:diplom/models/mark.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:diplom/widgects/rare_achievement_widget.dart';
import 'package:flutter/material.dart';

class RareAchievements extends StatefulWidget {
  final String course;
  final Mark bestMark;
  final List<UserLog> userLogs;

  const RareAchievements({Key? key, required this.course, required this.bestMark, required this.userLogs})
      : super(key: key);

  @override
  State<RareAchievements> createState() => _RareAchievementsState();
}

class _RareAchievementsState extends State<RareAchievements> {
  List<int> _achievements = [];

  @override
  void initState() {
    final Calculator calculator = Calculator();
    _achievements =
        calculator.getCourseAchievements(widget.bestMark, widget.course, widget.userLogs);
    print(_achievements);
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
                child: Text("Course achievements",
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
                    RareAchievement(
                      header: 'Getting started',
                      course: widget.course,
                      label: 'You have started the course',
                    ),
                  },
                  if (_achievements.contains(2)) ...{
                    RareAchievement(
                      header: 'Great knowledge',
                      course: widget.course,
                      label: 'You`re best mark > 80%',
                    ),
                  },
                  if (_achievements.contains(3)) ...{
                    RareAchievement(
                      header: '${widget.course} master',
                      course: widget.course,
                      label: 'You have completed the course',
                    ),
                  },
                ],
              ),
            )
          ],
        ));
  }
}
