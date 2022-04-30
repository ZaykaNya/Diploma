import 'dart:ui';

import 'package:diplom/authentication/authentication.dart';
import 'package:diplom/authentication/authentication_bloc.dart';
import 'package:diplom/widgects/profile.dart';
import 'package:diplom/widgects/achievements_widget.dart';
import 'package:diplom/widgects/courses_widget.dart';
import 'package:diplom/widgects/history_widget.dart';
import 'package:diplom/widgects/average_dashboard_widget.dart';
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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(80, 71, 153, 1),
        toolbarHeight: 54,
        title: const Text('Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 8),
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Profile(),
            const AverageDashboard(),
            const Courses(),
            Builder(
              builder: (context) {
                final userId = context.select(
                      (AuthenticationBloc bloc) => bloc.state.user.id,
                );
                return Text('UserID: $userId');
              },
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            ),
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
        onTap: _onItemTapped,
        backgroundColor: const Color.fromRGBO(80, 71, 153, 1),
      ),
    );
  }
}
