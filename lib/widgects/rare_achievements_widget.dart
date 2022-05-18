import 'dart:convert';
import 'dart:ui';

import 'package:diplom/api/courses.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/mark.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:diplom/widgects/rare_achievement_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RareAchievements extends StatefulWidget {
  final String course;
  final Mark bestMark;
  final List<String> branches;
  final List<UserLog> userLogs;
  final List<List<dynamic>> numberOfBranchesChildren;

  const RareAchievements(
      {Key? key,
      required this.course,
      required this.bestMark,
      required this.userLogs,
      required this.numberOfBranchesChildren,
      required this.branches})
      : super(key: key);

  @override
  State<RareAchievements> createState() => _RareAchievementsState();
}

class _RareAchievementsState extends State<RareAchievements> {
  List _achievements = [];
  List _uncompletedAchievements = [];

  @override
  void initState() {
    initWidgetState();
    super.initState();
  }

  void initWidgetState() async {
    final prefs = await SharedPreferences.getInstance();

    final String? achievementsStr = prefs.getString('${widget.course}CourseAchievements');
    final String? uncompletedAchievementsStr = prefs.getString('${widget.course}UncompletedCourseAchievements');

    if(achievementsStr != null && uncompletedAchievementsStr != null) {
      dynamic achievements = jsonDecode(achievementsStr);
      dynamic uncompletedAchievements = jsonDecode(uncompletedAchievementsStr);

      setState(() {
        _achievements = achievements;
        _uncompletedAchievements = uncompletedAchievements;
      });
    } else {
      final Calculator calculator = Calculator();
      List listOfAchievements = calculator.getCourseAchievements(
          widget.bestMark, widget.course, widget.userLogs, widget.branches, widget.numberOfBranchesChildren);

      setState(() {
        _achievements = listOfAchievements[0];
        _uncompletedAchievements = listOfAchievements[1];
      });

      await prefs.setString('${widget.course}CourseAchievements', jsonEncode(_achievements));
      await prefs.setString('${widget.course}UncompletedCourseAchievements', jsonEncode(_uncompletedAchievements));
    }
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
                        padding: EdgeInsets.fromLTRB(0, 24, 0, 16),
                        child: Text('You don`t have achievements yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(93, 92, 99, 1))),
                      ),
                    ),
                  },
                  for (var achievement in _achievements) ...[
                    RareAchievement(
                      header: achievement['header'],
                      course: achievement['course'],
                      label: achievement['label'],
                      closest: achievement['closest'],
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
                        for (var achievement in _uncompletedAchievements) ...[
                          RareAchievement(
                            header: achievement['header'],
                            course: achievement['course'],
                            label: achievement['label'],
                            closest: achievement['closest'],
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
