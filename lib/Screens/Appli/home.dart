import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kidzo_app/Screens/Appli/appLock.dart';
import 'package:kidzo_app/Screens/Appli/appUsage.dart';
import 'package:kidzo_app/Screens/welcome_screen/welcome_screen.dart';

import 'package:kidzo_app/widget/catergory_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ClipRRect(
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: const Color.fromRGBO(18, 69, 89, 1),
            animationDuration: const Duration(milliseconds: 300),
            onTap: (index) {
              print(index);
            },
            items: const [
              Icon(
                Icons.home,
                color: Colors.white,
              ),
              Icon(
                Icons.people,
                color: Colors.white,
              ),
            ],
          ),
          body: Stack(
            children: <Widget>[
              Container(
                height: size.height * 0.28,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                        image: AssetImage("assets/images/maps.png"))),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 2.95,
                      // padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              alignment: Alignment.bottomLeft,
                              image:
                                  AssetImage("assets/images/Rectangle.png"))),
                    ),
                    SizedBox(
                      // margin: const EdgeInsets.only(top: 250),
                      height: MediaQuery.of(context).size.height / 1.7,
                      width: double.infinity,
                      child: Column(
                        verticalDirection: VerticalDirection.down,
                        children: [
                          Expanded(
                            child: GridView.count(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              crossAxisCount: 2,
                              crossAxisSpacing: 25,
                              mainAxisSpacing: 20,
                              children: <Widget>[
                                CatecoryCard(
                                  svgScr: "assets/images/AppLock (2).png",
                                  title: 'Lock Apps',
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const Applock()));
                                  },
                                ),
                                CatecoryCard(
                                  svgScr: "assets/images/FilterContent.png",
                                  title: 'Filter Content',
                                  onTap: () {},
                                ),
                                CatecoryCard(
                                  svgScr: "assets/images/screenTime.png",
                                  title: 'Screen Time',
                                  onTap: () {},
                                ),
                                CatecoryCard(
                                  svgScr: "assets/images/AppUsage.png",
                                  title: 'App Usage',
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const AppUsage()));
                                  },
                                ),
                                CatecoryCard(
                                  svgScr: "assets/images/logout (2).png",
                                  title: 'Log Out',
                                  onTap: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const WelcomeScreen()));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
