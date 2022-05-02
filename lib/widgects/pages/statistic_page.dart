import 'dart:ui';

import 'package:diplom/authentication/authentication.dart';
import 'package:diplom/authentication/authentication_bloc.dart';
import 'package:diplom/blocs/user/user_bloc.dart';
import 'package:diplom/blocs/user/user_event.dart';
import 'package:diplom/blocs/user/user_state.dart';
import 'package:diplom/navigation/constants/nav_bar_items.dart';
import 'package:diplom/navigation/navigation_cubit.dart';
import 'package:diplom/navigation/navigation_state.dart';
import 'package:diplom/widgects/profile.dart';
import 'package:diplom/widgects/achievements_widget.dart';
import 'package:diplom/widgects/courses_widget.dart';
import 'package:diplom/widgects/history_widget.dart';
import 'package:diplom/widgects/average_dashboard_widget.dart';
import 'package:diplom/widgects/rare_achievements_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticPage extends StatefulWidget {
  final String userId;
  const StatisticPage({
    Key? key,
    required this.userId
  }) : super(key: key);

  @override
  State<StatisticPage> createState() => _StatisticPageState(userId);
}

class _StatisticPageState extends State<StatisticPage> {
  int _selectedIndex = 0;
  final String userId;
  final UserBloc _userBloc = UserBloc();

  _StatisticPageState(this.userId);

  @override
  void initState() {
    print(userId);
    _userBloc.add(GetUser(id: userId));
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => _userBloc,
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) => {
            if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              )
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(80, 71, 153, 1),
              toolbarHeight: 54,
              title: const Text('Profile',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                            children: const [
                              AverageDashboard(),
                              Courses(),
                            ],
                          );
                        } else if (state.navbarItem == NavbarItem.progress) {
                          return Column(
                            children: const [
                              Achievements(),
                              RareAchievements(),
                            ],
                          );
                        } else if (state.navbarItem == NavbarItem.history) {
                          return const History();
                        }
                        return Container();
                      }),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Statistic',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_alert),
                  label: 'Progress',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'History',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: const Color.fromRGBO(41, 215, 41, 1),
              // selectedItemColor: Colors.white,
              unselectedItemColor: const Color.fromRGBO(134, 137, 235, 1),
              onTap: (index) {
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
        )
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
