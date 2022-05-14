import 'dart:ui';

import 'package:diplom/api/courses.dart';
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

class TimeDetailsPage extends StatefulWidget {

  const TimeDetailsPage(
      {Key? key,})
      : super(key: key);

  @override
  State<TimeDetailsPage> createState() => _TimeDetailsPageState();
}

class _TimeDetailsPageState extends State<TimeDetailsPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(80, 71, 153, 1),
        toolbarHeight: 54,
        title: const Text('Time details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
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
          const Divider(
            height: 10,
            thickness: 10,
            color: Color.fromRGBO(218, 220, 239, 1),
          ),
        ],
      ),
    );
  }
}
