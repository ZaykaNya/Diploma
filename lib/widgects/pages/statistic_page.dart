import 'dart:ui';

import 'package:diplom/blocs/userTests/user_tests_event.dart';
import 'package:intl/intl.dart';
import 'package:diplom/api/logs.dart';
import 'package:diplom/api/users.dart';
import 'package:diplom/authentication/authentication.dart';
import 'package:diplom/authentication/authentication_bloc.dart';
import 'package:diplom/blocs/allLogs/all_logs_bloc.dart';
import 'package:diplom/blocs/allLogs/all_logs_state.dart';
import 'package:diplom/blocs/logs/logs_bloc.dart';
import 'package:diplom/blocs/logs/logs_event.dart';
import 'package:diplom/blocs/logs/logs_state.dart';
import 'package:diplom/blocs/user/user_bloc.dart';
import 'package:diplom/blocs/user/user_state.dart';
import 'package:diplom/blocs/userLogs/user_logs_bloc.dart';
import 'package:diplom/blocs/userLogs/user_logs_event.dart';
import 'package:diplom/blocs/userLogs/user_logs_state.dart';
import 'package:diplom/blocs/userTests/user_tests_bloc.dart';
import 'package:diplom/blocs/userTests/user_tests_state.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/user.dart';
import 'package:diplom/navigation/constants/nav_bar_items.dart';
import 'package:diplom/navigation/navigation_cubit.dart';
import 'package:diplom/navigation/navigation_state.dart';
import 'package:diplom/widgects/profile.dart';
import 'package:diplom/widgects/achievements_widget.dart';
import 'package:diplom/widgects/courses_widget.dart';
import 'package:diplom/widgects/history_widget.dart';
import 'package:diplom/widgects/average_dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticPage extends StatefulWidget {
  final String userId;

  const StatisticPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  int _selectedIndex = 0;
  bool _pageLoaded = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if(index == 0) {
      initWidgetState();
    }
  }

  @override
  void initState() {
    initWidgetState();
    super.initState();
  }

  void initWidgetState() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');
    final String? lastLogTime = prefs.getString('lastLogTime');
    final int? lastDay = prefs.getInt('lastDay');
    final currentDay = DateTime.now().day;

    List<UserLog> newLogs = [];

    if(lastLogTime != null) {
      newLogs = await fetchLogsFromTime(lastLogTime);
    } else {
      newLogs = await fetchLogsFromTime('2015-01-01 00:00:00');
    }

    if(userId != widget.userId || newLogs.length > 0) {
      User user = await fetchUserDetailsById(widget.userId);

      for(var course in user.courses) {
        await prefs.setBool('${course['course'].toLowerCase()}timeDetailsPageUserSame', false);
        await prefs.setBool('${course['course'].toLowerCase()}coursePageUserSame', false);
        await prefs.setBool('${course['course'].toLowerCase()}statisticWidgetUserSame', false);
        await prefs.setBool('${course['course'].toLowerCase()}rareAchievementsUserSame', false);
        await prefs.setBool('${course['course'].toLowerCase()}courseWidgetUserSame', false);
      }

      DateTime timeOfLastLog = DateTime.parse('${newLogs.last.time}').add(const Duration(seconds: 1));
      String lastLogTimeToCache = DateFormat("yyyy-MM-dd HH:mm:ss").format(timeOfLastLog);

      await prefs.setString('userId', widget.userId);
      await prefs.setBool('averageDashboardUserSame', false);
      await prefs.setBool('achievementsUserSame', false);
      await prefs.setBool('historyWidgetUserSame', false);
      await prefs.setString('lastLogTime', lastLogTimeToCache);
      await prefs.setInt('lastDay', currentDay);

      setState(() {
        _pageLoaded = true;
        _selectedIndex = 0;
      });
    } else if(currentDay != lastDay) {
      User user = await fetchUserDetailsById(widget.userId);

      for(var course in user.courses) {
        await prefs.setBool('${course['course'].toLowerCase()}timeDetailsPageUserSame', false);
        await prefs.setBool('${course['course'].toLowerCase()}coursePageUserSame', false);
        await prefs.setBool('${course['course'].toLowerCase()}statisticWidgetUserSame', false);
        await prefs.setBool('${course['course'].toLowerCase()}courseWidgetUserSame', false);
      }

      await prefs.setBool('averageDashboardUserSame', false);
      await prefs.setInt('lastDay', currentDay);

      setState(() {
        _pageLoaded = true;
        _selectedIndex = 0;
      });
    } else {
      setState(() {
        _pageLoaded = true;
        _selectedIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final logsBloc = BlocProvider.of<LogsBloc>(context);
    final userLogsBloc = BlocProvider.of<UserLogsBloc>(context);
    final userTestsBloc = BlocProvider.of<UserTestsBloc>(context);
    if(_selectedIndex == 0) {
      BlocProvider.of<NavigationCubit>(context)
          .getNavBarItem(NavbarItem.statistics);
    }
    if(_pageLoaded) {
      return MultiBlocListener(
        listeners: [
          BlocListener<UserBloc, UserState>(
            listener: (context, state) => {
              if (state is UserError)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message!),
                    ),
                  )
                }
            },
          ),
          BlocListener<UserLogsBloc, UserLogsState>(
            listener: (context, state) => {
              if (state is UserLogsError)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message!),
                    ),
                  )
                }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(80, 71, 153, 1),
            toolbarHeight: 54,
            title: const Text('Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
            actions: <Widget>[
              IconButton(
                padding: const EdgeInsets.only(right: 8),
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserInitial) {
                      return _buildLoading();
                    } else if (state is UserLoading) {
                      return _buildLoading();
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
                BlocBuilder<NavigationCubit, NavigationState>(
                    builder: (context, state) {
                      if (state.navbarItem == NavbarItem.statistics) {
                        return Column(
                          children: [
                            BlocBuilder<LogsBloc, LogsState>(
                                builder: (context, logsState) {
                                  if (logsState is LogsLoaded) {
                                    return BlocBuilder<UserLogsBloc, UserLogsState>(
                                        builder: (context, userLogsState) {
                                          if (userLogsState is UserLogsLoaded) {
                                            return BlocBuilder<UserBloc, UserState>(
                                                builder: (context, userState) {
                                                  if (userState is UserLoaded) {
                                                    return AverageDashboard(
                                                        logs: logsState.logs,
                                                        userLogs: userLogsState.userLogs,
                                                        courses: userState.user.courses);
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
                            BlocBuilder<UserBloc, UserState>(
                                builder: (context, state) {
                                  if (state is UserLoaded) {
                                    return Courses(
                                        courses: state.user.courses,
                                        userId: widget.userId);
                                  } else {
                                    return Container();
                                  }
                                }),
                          ],
                        );
                      } else if (state.navbarItem == NavbarItem.progress) {
                        return Column(
                          children: [
                            BlocBuilder<UserLogsBloc, UserLogsState>(
                                builder: (context, userLogsState) {
                                  if (userLogsState is UserLogsLoaded) {
                                    return BlocBuilder<UserBloc, UserState>(
                                        builder: (context, userState) {
                                          if (userState is UserLoaded) {
                                            return BlocBuilder<UserTestsBloc, UserTestsState>(
                                                builder: (context, testsState) {
                                                  if (testsState is UserTestsLoaded) {
                                                    return Achievements(
                                                        userLogs: userLogsState.userLogs,
                                                        courses: userState.user.courses,
                                                        userTests: testsState.userTests);
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
                                })
                          ],
                        );
                      } else if (state.navbarItem == NavbarItem.history) {
                        return BlocBuilder<UserLogsBloc, UserLogsState>(
                            builder: (context, userLogsState) {
                              if (userLogsState is UserLogsLoaded) {
                                return BlocBuilder<AllLogsBloc, AllLogsState>(
                                    builder: (context, allLogsState) {
                                      if (allLogsState is AllLogsLoaded) {
                                        return BlocBuilder<UserBloc, UserState>(
                                            builder: (context, userState) {
                                              if (userState is UserLoaded) {
                                                return BlocBuilder<UserTestsBloc, UserTestsState>(
                                                    builder: (context, testsState) {
                                                      if (testsState is UserTestsLoaded) {
                                                        return History(
                                                          userLogs: userLogsState.userLogs,
                                                          allLogs: allLogsState.allLogs,
                                                          courses: userState.user.courses,
                                                          userTests: testsState.userTests,
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
                                    });
                              } else {
                                return Container();
                              }
                            });
                      }
                      return Container();
                    }),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home Page',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wine_bar),
                label: 'Achievements',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timelapse),
                label: 'Statistic',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromRGBO(41, 215, 41, 1),
            // selectedItemColor: Colors.white,
            unselectedItemColor: const Color.fromRGBO(134, 137, 235, 1),
            onTap: (index) {
              DateTime weekAgo = DateTime.now().subtract(const Duration(days: 6));
              logsBloc.add(GetLogsFromTime(
                  id: widget.userId,
                  time: '${weekAgo.year}-${weekAgo.month}-${weekAgo.day}'));
              userLogsBloc.add(GetUserLogs(id: widget.userId));
              userTestsBloc.add(GetUserTests(id: widget.userId));
              _onItemTapped(index);
              if (index == 0) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.statistics);
              } else if (index == 1) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.progress);
              } else if (index == 2) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.history);
              }
            },
            backgroundColor: const Color.fromRGBO(80, 71, 153, 1),
          ),
        ),
      );
    } else {
      return _buildLoading();
    }
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
