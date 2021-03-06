import 'package:diplom/authentication/authentication_bloc.dart';
import 'package:diplom/blocs/allLogs/all_logs_bloc.dart';
import 'package:diplom/blocs/allLogs/all_logs_event.dart';
import 'package:diplom/blocs/logs/logs_bloc.dart';
import 'package:diplom/blocs/logs/logs_event.dart';
import 'package:diplom/blocs/user/user_bloc.dart';
import 'package:diplom/blocs/user/user_event.dart';
import 'package:diplom/blocs/userLogs/user_logs_bloc.dart';
import 'package:diplom/blocs/userLogs/user_logs_event.dart';
import 'package:diplom/blocs/userTests/user_tests_bloc.dart';
import 'package:diplom/blocs/userTests/user_tests_event.dart';
import 'package:diplom/widgects/pages/statistic_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final allLogsBloc = BlocProvider.of<AllLogsBloc>(context);
    final logsBloc = BlocProvider.of<LogsBloc>(context);
    final userLogsBloc = BlocProvider.of<UserLogsBloc>(context);
    final userTestsBloc = BlocProvider.of<UserTestsBloc>(context);
    return Builder(
      builder: (context) {
        final userId = context.select(
              (AuthenticationBloc bloc) => bloc.state.user.id,
        );
        DateTime weekAgo = DateTime.now().subtract(const Duration(days: 6));
        allLogsBloc.add(const GetAllLogs());
        userBloc.add(GetUser(id: userId));
        logsBloc.add(GetLogsFromTime(id: userId, time: '${weekAgo.year}-${weekAgo.month}-${weekAgo.day}'));
        userLogsBloc.add(GetUserLogs(id: userId));
        userTestsBloc.add(GetUserTests(id: userId));
        return StatisticPage(userId: userId);
      },
    );
  }
}
