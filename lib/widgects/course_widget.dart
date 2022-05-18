import 'dart:convert';
import 'dart:ui';

import 'package:diplom/api/branch.dart';
import 'package:diplom/api/courses.dart';
import 'package:diplom/blocs/course/course_bloc.dart';
import 'package:diplom/blocs/course/course_event.dart';
import 'package:diplom/blocs/course/course_state.dart';
import 'package:diplom/blocs/courseTests/course_tests_bloc.dart';
import 'package:diplom/blocs/courseTests/course_tests_event.dart';
import 'package:diplom/blocs/page/page_bloc.dart';
import 'package:diplom/blocs/userBestMark/user_best_mark_bloc.dart';
import 'package:diplom/blocs/userBestMark/user_best_mark_event.dart';
import 'package:diplom/blocs/weekLogs/week_logs_bloc.dart';
import 'package:diplom/blocs/weekLogs/week_logs_event.dart';
import 'package:diplom/models/branch.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:diplom/widgects/pages/course_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class CourseWidget extends StatefulWidget {
  final String course;
  final String userId;
  final CourseBloc courseBloc;
  final PageBloc pageBloc;
  final List<UserLog> userLogs;

  const CourseWidget(
      {Key? key,
      required this.course,
      required this.userId,
      required this.courseBloc,
      required this.pageBloc,
      required this.userLogs})
      : super(key: key);

  @override
  State<CourseWidget> createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  int _progress = 0;
  double _time = 0;
  List<String> _branches = [];
  List<String> _branchCaptions = [];
  List<List<dynamic>> _numberOfBranchesChildren = [];

  void initPageState(branches) async {
    final prefs = await SharedPreferences.getInstance();

    final bool? courseWidgetUserSame = prefs.getBool('${widget.course.toLowerCase()}courseWidgetUserSame');

    final String? numberOfBranchesChildrenFromCache = prefs.getString('${widget.course}ChartTestsDurationDataCompare');
    final int? progressFromCache = prefs.getInt('${widget.course}Progress');
    final double? timeFromCache = prefs.getDouble('${widget.course}Time');
    final List<String>? branchesFromCache = prefs.getStringList('${widget.course}Branches');
    final List<String>? branchCaptionsFromCache = prefs.getStringList('${widget.course}BranchCaptions');

    if (numberOfBranchesChildrenFromCache != null &&
        progressFromCache != null &&
        timeFromCache != null &&
        branchesFromCache != null &&
        branchCaptionsFromCache != null &&
        courseWidgetUserSame == true) {
      List<List<dynamic>> newNumberOfBranchesChildren = [];

      for (var data in jsonDecode(numberOfBranchesChildrenFromCache)) {
        List temp = [];

        for (var item in data) {
          temp.add(PageInCourse.fromJson(item));
        }

        newNumberOfBranchesChildren.add(temp);
      }

      setState(() {
        _branchCaptions = branchCaptionsFromCache;
        _progress = progressFromCache;
        _time = timeFromCache;
        _branches = branchesFromCache;
        _numberOfBranchesChildren = newNumberOfBranchesChildren;
      });
    } else {
      List<String> pagesNames = [];
      List<List<dynamic>> numberOfBranchesChildren = [];
      final Calculator calculator = Calculator();

      for (String branch in branches) {
        dynamic page = await fetchPageByBranch(branch);
        List<dynamic> pageChildren = await fetchPageChildrenByBranch(branch);
        numberOfBranchesChildren.add(pageChildren);
        pagesNames.add(page.caption);
      }

      setState(() {
        _branchCaptions = pagesNames;
        _progress = calculator.countProgress(
            widget.userLogs, widget.course, branches, numberOfBranchesChildren);
        _time = calculator.countTime(widget.userLogs, widget.course);
        _branches = branches;
        _numberOfBranchesChildren = numberOfBranchesChildren;
      });

      List<List<dynamic>> numberOfBranchesChildrenToJSON = [];

      for (var data in _numberOfBranchesChildren) {
        List temp = [];

        for (var item in data) {
          temp.add({
            'caption': item.caption,
            'view': item.view,
          });
        }

        numberOfBranchesChildrenToJSON.add(temp);
      }

      await prefs.setString('${widget.course}ChartTestsDurationDataCompare',
          jsonEncode(numberOfBranchesChildrenToJSON));
      await prefs.setInt('${widget.course}Progress', _progress);
      await prefs.setDouble('${widget.course}Time', _time);
      await prefs.setStringList('${widget.course}Branches', _branches);
      await prefs.setStringList(
          '${widget.course}BranchCaptions', _branchCaptions);
      await prefs.setBool('${widget.course.toLowerCase()}courseWidgetUserSame', true);
    }
  }

  @override
  void initState() {
    fetchCoursesByName(widget.course).then((value) {
      initPageState(value.branches);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userWeekLogsBloc = BlocProvider.of<WeekLogsBloc>(context);
    final userBestMarkBloc = BlocProvider.of<UserBestMarkBloc>(context);
    final courseTestsBloc = BlocProvider.of<CourseTestsBloc>(context);
    widget.courseBloc.add(GetCourse(course: widget.course));
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        primary: Colors.white,
        shadowColor: Colors.white,
        side: const BorderSide(color: Colors.white, width: 0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<CourseBloc, CourseState>(
                  builder: (context, courseState) {
                if (courseState is CourseLoaded) {
                  final String image =
                      'http://semantic-portal.net/images/${courseState.course.course.image}';
                  if (courseState.course.course.image != "") {
                    return Image.network(image, height: 103, width: 103);
                  } else {
                    return Image.asset('assets/images/react_icon.png');
                  }
                } else {
                  return Container();
                }
              }),
              const Padding(padding: EdgeInsets.only(right: 16)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.course.split('-').join(' ').capitalize(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(93, 92, 99, 1))),
                    const Padding(padding: EdgeInsets.only(top: 4)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(140, 138, 149, 1)),
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 6, 0),
                                  child: Image.asset(
                                      'assets/images/star_icon.png'),
                                ),
                              ),
                              TextSpan(text: '$_progress %'),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 60)),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(140, 138, 149, 1)),
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 6, 0),
                                  child: Image.asset(
                                      'assets/images/alarm_clock_icon.png'),
                                ),
                              ),
                              TextSpan(text: "$_time h."),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 16)),
          const Divider(
            height: 2,
            thickness: 2,
            indent: 8,
            endIndent: 8,
            color: Color.fromRGBO(235, 235, 235, 1),
          ),
          const Padding(padding: EdgeInsets.only(top: 16)),
        ],
      ),
      onPressed: () {
        DateTime weekAgo = DateTime.now().subtract(const Duration(days: 6));
        userWeekLogsBloc.add(GetWeekLogs(
            id: widget.userId,
            time: '${weekAgo.year}-${weekAgo.month}-${weekAgo.day}'));
        userBestMarkBloc
            .add(GetUserBestMark(id: widget.userId, course: widget.course));
        courseTestsBloc.add(GetCourseTests(course: widget.course));
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CoursePage(
                    course: widget.course.capitalize(),
                    courseProgress: _progress,
                    timeSpent: _time,
                    branches: _branches,
                    branchCaptions: _branchCaptions,
                    numberOfBranchesChildren: _numberOfBranchesChildren,
                  )),
        );
      },
    );
  }
}
