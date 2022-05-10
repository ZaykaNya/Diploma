import 'package:diplom/authentication/authentication_bloc.dart';
import 'package:diplom/authentication/authentication_repository.dart';
import 'package:diplom/authentication/authentication_state.dart';
import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/course/course_bloc.dart';
import 'package:diplom/blocs/courseTests/course_tests_bloc.dart';
import 'package:diplom/blocs/logs/logs_bloc.dart';
import 'package:diplom/blocs/user/user_bloc.dart';
import 'package:diplom/blocs/userBestMark/user_best_mark_bloc.dart';
import 'package:diplom/blocs/userLogs/user_logs_bloc.dart';
import 'package:diplom/blocs/userTests/user_tests_bloc.dart';
import 'package:diplom/blocs/weekLogs/week_logs_bloc.dart';
import 'package:diplom/navigation/navigation_cubit.dart';
import 'package:diplom/widgects/logic_page.dart';
import 'package:diplom/widgects/splash.dart';
import 'package:diplom/widgects/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
              userRepository: userRepository,
            ),
          ),
          BlocProvider<UserBloc>(
            create: (_) => UserBloc(),
          ),
          BlocProvider<LogsBloc>(
            create: (_) => LogsBloc(),
          ),
          BlocProvider<UserLogsBloc>(
            create: (_) => UserLogsBloc(),
          ),
          BlocProvider<UserTestsBloc>(
            create: (_) => UserTestsBloc(),
          ),
          BlocProvider<WeekLogsBloc>(
            create: (_) => WeekLogsBloc(),
          ),
          BlocProvider<UserBestMarkBloc>(
            create: (_) => UserBestMarkBloc(),
          ),
          BlocProvider<CourseTestsBloc>(
            create: (_) => CourseTestsBloc(),
          ),
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (context) => NavigationCubit(),
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        )),
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    HomePage.route(),
                    (route) => false,
                  );
                  break;
                case AuthenticationStatus.unauthenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(),
                    (route) => false,
                  );
                  break;
                default:
                  break;
              }
            },
            child: child,
          );
        },
        onGenerateRoute: (_) => SplashPage.route(),
      ),
    );
  }
}
