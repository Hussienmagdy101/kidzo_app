import 'package:flutter/material.dart';
import 'package:kidzo_app/Screens/Appli/home.dart';
import 'package:kidzo_app/Screens/widget/Profile_idField.dart';

import 'package:kidzo_app/Screens/widget/home_bottomNav.dart';

class ParentPage2 extends StatefulWidget {
  const ParentPage2({super.key});

  @override
  State<ParentPage2> createState() => _ParentPage1State();
}

class _ParentPage1State extends State<ParentPage2> {
  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(18, 69, 89, 1),
            Color.fromRGBO(18, 69, 89, 1)
          ])),
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 120),
              child: Parent_id()),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Image.asset(
                            "assets/images/refresh.png",
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: OutlinedButton.icon(
                            style: ButtonStyle(
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.height / 7.5,
                                vertical:
                                    MediaQuery.of(context).size.width / 15,
                              )),
                              backgroundColor: const WidgetStatePropertyAll(
                                Color.fromRGBO(219, 217, 217, 1),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            },
                            icon: Image.asset(
                              'assets/images/profile2.png',
                            ),
                            label: const Text(
                              'Child Name',
                              style: TextStyle(
                                  color: Color(0xFF598393), fontSize: 20),
                            )),
                      ),
                    ],
                  ),
                  const HomebottomNav(),
                ],
              )),
        ),
      ],
    ));
  }
}
