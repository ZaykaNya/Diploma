import 'package:diplom/authentication/authentication_bloc.dart';
import 'package:diplom/widgects/pages/statistic_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final userId = context.select(
              (AuthenticationBloc bloc) => bloc.state.user.id,
        );
        return StatisticPage(userId: userId);
      },
    );
  }
}
