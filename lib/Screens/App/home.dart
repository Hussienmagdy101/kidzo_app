import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kidzo_app/Screens/App/appLock.dart';
import 'package:kidzo_app/Screens/App/appUsage.dart';
import 'package:kidzo_app/Screens/App/lockScreen.dart';
import 'package:kidzo_app/Screens/welcome_screen/welcome_screen.dart';
import 'package:kidzo_app/widget/catergory_card.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController? gmc;
  StreamSubscription<Position>? positionStream;
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(43.5320733, -120.2697067), zoom: 16);

  getLocatinPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse) {
      print("WhileInUse");
      Position position = await Geolocator.getCurrentPosition();

      positionStream =
          Geolocator.getPositionStream().listen((Position? position) {
        markers.add(Marker(
            markerId: MarkerId('1'),
            position: LatLng(position!.latitude, position.longitude)));
        gmc!.animateCamera(CameraUpdate.newLatLng(
            LatLng(position.latitude, position.longitude)));
        setState(() {});
      });
    }
  }

  List<Marker> markers = [
    Marker(markerId: MarkerId('1'), position: LatLng(29.9966133, 31.175625))
  ];

  @override
  void initState() {
    // TODO: implement initState
    getLocatinPermission();

    super.initState();
  }

  @override
  void dispose() {
    if (positionStream != null) {
      positionStream!.cancel();
    }
    super.dispose();
  }

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
            body: Container(
                child: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height / 3.5,
                width: double.infinity,
                child: GoogleMap(
                  markers: markers.toSet(),
                  initialCameraPosition: cameraPosition,
                  mapType: MapType.satellite,
                  onMapCreated: (mapcontroller) {
                    gmc = mapcontroller;
                  },
                ),
              ),
              SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 24),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment.bottomLeft,
                            image: AssetImage("assets/images/Rectangle.png"))),
                  ),
                  SizedBox(
                    // margin: const EdgeInsets.only(top: 250),
                    height: MediaQuery.of(context).size.height / 1.8,
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
                                              const AppLock()));
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
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const ScreenLock()));
                                },
                              ),
                              CatecoryCard(
                                svgScr: "assets/images/AppUsage.png",
                                title: 'App Usage',
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const AppUsage()));
                                },
                              ),
                              CatecoryCard(
                                svgScr: "assets/images/logout (2).png",
                                title: 'Log Out',
                                onTap: () async {
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.of(context).push(MaterialPageRoute(
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
              )),
            ]))));
  }
}
