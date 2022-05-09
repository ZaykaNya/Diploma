import 'dart:ui';

import 'package:diplom/blocs/courseTests/course_tests_bloc.dart';
import 'package:diplom/blocs/courseTests/course_tests_state.dart';
import 'package:diplom/blocs/user/user_bloc.dart';
import 'package:diplom/blocs/user/user_state.dart';
import 'package:diplom/blocs/userBestMark/user_best_mark_bloc.dart';
import 'package:diplom/blocs/userBestMark/user_best_mark_state.dart';
import 'package:diplom/blocs/userLogs/user_logs_bloc.dart';
import 'package:diplom/blocs/userLogs/user_logs_state.dart';
import 'package:diplom/blocs/weekLogs/week_logs_bloc.dart';
import 'package:diplom/blocs/weekLogs/week_logs_state.dart';
import 'package:diplom/widgects/profile.dart';
import 'package:diplom/widgects/rare_achievements_widget.dart';
import 'package:diplom/widgects/statistic_widjet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursePage extends StatefulWidget {
  final String course;
  final double timeSpent;
  final int courseProgress;

  const CoursePage(
      {Key? key,
      required this.course,
      required this.courseProgress,
      required this.timeSpent})
      : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> with TickerProviderStateMixin {

  launchURL(String url) async {
    if(await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(80, 71, 153, 1),
        toolbarHeight: 54,
        title: Text(widget.course,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserInitial) {
                return Container();
              } else if (state is UserLoading) {
                return Container();
              } else if (state is UserLoaded) {
                return Profile(
                  name: state.user.user.name,
                  surname: state.user.user.surname,
                  login: state.user.user.login,
                );
              } else if (state is UserError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: ElevatedButton(
              onPressed: () {
                final url = 'http://semantic-portal.net/my:course:${widget.course.toLowerCase()}';

                launchURL(url);
              },
              child: const Text(
                "Go to course",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  primary: const Color.fromRGBO(41, 215, 41, 1),
              ),
            ),
          ),
          TabBar(
            labelColor: const Color.fromRGBO(41, 215, 41, 1),
            unselectedLabelColor: const Color.fromRGBO(140, 138, 149, 1),
            indicatorColor: const Color.fromRGBO(41, 215, 41, 1),
            padding: const EdgeInsets.all(0),
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            controller: _tabController,
            tabs: const [
              Tab(text: 'STATISTIC', height: 32),
              Tab(text: 'ACHIEVEMENTS', height: 32)
            ],
          ),
          Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height - 292,
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: BlocBuilder<WeekLogsBloc, WeekLogsState>(
                      builder: (context, weekLogsState) {
                    if (weekLogsState is WeekLogsLoaded) {
                      return BlocBuilder<UserBestMarkBloc, UserBestMarkState>(
                          builder: (context, userBestMarkState) {
                        if (userBestMarkState is UserBestMarkLoaded) {
                          return BlocBuilder<CourseTestsBloc, CourseTestsState>(
                              builder: (context, courseTestsState) {
                            if (courseTestsState is CourseTestsLoaded) {
                              return StatisticWidget(
                                courseProgress: widget.courseProgress,
                                userWeekLogs: weekLogsState.userWeekLogs,
                                course: widget.course,
                                timeSpent: widget.timeSpent,
                                bestMark: userBestMarkState.userBestMark,
                                courseTests: courseTestsState.courseTests,
                              );
                            } else {
                              return Container();
                            }
                          });
                        } else {
                          return Container();
                        }
                      });
                    } else {
                      return Container();
                    }
                  }),
                ),
                SingleChildScrollView(
                  child: BlocBuilder<UserBestMarkBloc, UserBestMarkState>(
                      builder: (context, userBestMarkState) {
                    if (userBestMarkState is UserBestMarkLoaded) {
                      return BlocBuilder<UserLogsBloc, UserLogsState>(
                          builder: (context, userLogsState) {
                            if (userLogsState is UserLogsLoaded) {
                              return RareAchievements(
                                  course: widget.course,
                                  bestMark: userBestMarkState.userBestMark,
                                  userLogs: userLogsState.userLogs
                              );
                            } else {
                              return Container();
                            }
                          });

                    } else {
                      return Container();
                    }
                  }),
                ),
              ],
            ),
          ),
          // RareAchievements(),
        ],
      ),
    );
  }
}
