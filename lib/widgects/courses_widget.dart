import 'dart:collection';
import 'dart:ui';
import 'package:diplom/blocs/course/course_bloc.dart';
import 'package:diplom/blocs/course/course_event.dart';
import 'package:diplom/blocs/course/course_state.dart';
import 'package:diplom/blocs/userLogs/user_logs_bloc.dart';
import 'package:diplom/blocs/userLogs/user_logs_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'course_widget.dart';

class Courses extends StatelessWidget {
  final List<dynamic> courses;
  final String userId;

  const Courses({Key? key, required this.courses, required this.userId})
      : super(key: key);

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
                padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Text("Your courses",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(93, 92, 99, 1)))),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: <Widget>[
                  if (courses.isEmpty) ...[
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
                        child: Text("You don't have courses yet",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(93, 92, 99, 1))),
                      ),
                    )
                  ] else ...[
                    for (var course in courses)
                      BlocProvider<CourseBloc>(
                        create: (_) => CourseBloc(),
                        child: BlocBuilder<UserLogsBloc, UserLogsState>(
                            builder: (context, userState) {
                          final courseBloc =
                              BlocProvider.of<CourseBloc>(context);
                          if (userState is UserLogsLoaded) {
                            return CourseWidget(
                              course: course['course'],
                              userId: userId,
                              userLogs: userState.userLogs,
                              courseBloc: courseBloc,
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ),
                  ]
                ],
              ),
            )
          ],
        ));
  }
}
