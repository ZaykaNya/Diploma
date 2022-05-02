import 'dart:ui';

import 'package:flutter/material.dart';

class AverageDashboard extends StatelessWidget {
  const AverageDashboard({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const AverageDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          height: 10,
          thickness: 10,
          color: Color.fromRGBO(218, 220, 239, 1),
        ),
        const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Text("Average score",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(93, 92, 99, 1)))),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.radio_button_checked, size: 250)
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 8)),
            const Text("Файно, візьми паляничку!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color.fromRGBO(93, 92, 99, 1))),
            const Padding(padding: EdgeInsets.only(top: 32)),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(134, 137, 235, 1)),
                          children: [
                            const TextSpan(text: "5"),
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(4, 0, 0, 5),
                                child: Image.asset('assets/images/checkmark_icon.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text("Completed", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromRGBO(140, 138, 149, 1))),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(right: 48)),
                  const VerticalDivider(
                    width: 2,
                    thickness: 2,
                    color: Color.fromRGBO(235, 235, 235, 1),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 48)),
                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(30, 176, 159, 1)),
                          children: [
                            const TextSpan(text: "2"),
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(4, 0, 0, 5),
                                child: Image.asset('assets/images/pencil_icon.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text("In progress", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromRGBO(140, 138, 149, 1))),
                    ],
                  )
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 32)),
          ],
        )
      ],
    );
  }
}
