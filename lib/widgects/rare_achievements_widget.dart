import 'dart:ui';

import 'package:diplom/widgects/rare_achievement_widget.dart';
import 'package:flutter/material.dart';

class RareAchievements extends StatelessWidget {
  const RareAchievements({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RareAchievements());
  }

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
                padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Text("Rare achievements",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(93, 92, 99, 1)))),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: const [
                  RareAchievement(
                    header: 'Special function',
                    course: 'React',
                    label: 'You made class component happy by using it!',
                  ),
                  RareAchievement(
                    header: 'Hook me',
                    course: 'React',
                    label: 'You catched the difference between hooks and classes!',
                  ),
                  RareAchievement(
                    header: 'Widget master',
                    course: 'Dart',
                    label: 'You created your first application!',
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
