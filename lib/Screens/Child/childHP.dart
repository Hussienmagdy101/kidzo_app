import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_apps/device_apps.dart';
import 'package:device_policy_manager/device_policy_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kidzo_app/Screens/packages/appInformation.dart';
import 'package:kidzo_app/Screens/welcome_screen/welcome_screen.dart';
import 'package:usage_stats/usage_stats.dart';

class ChildHomePage extends StatefulWidget {
  const ChildHomePage({super.key});

  @override
  State<ChildHomePage> createState() => _ChildHomePageState();
}

class _ChildHomePageState extends State<ChildHomePage> {
  StreamSubscription<Position>? positionStream;
  static Future<bool?> checkUsagePermission() async {
    bool isPermission = UsageStats.checkUsagePermission() as bool;
    return isPermission;
  }

  UsageInfo? appStats;
  String? docId;
  List<Appinformation> appinformation = [];
  @override
  void initState() {
    getAllInstalledApps();
    getUserId();
    getData();
    checkUsagePermission();
    super.initState();
  }

  Future<UsageInfo> getUsage(Application application) async {
    DateTime endDate = DateTime.now();
    DateTime startDate =
        DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);

    List<UsageInfo> usageStats =
        await UsageStats.queryUsageStats(startDate, endDate);

    if (usageStats.isNotEmpty) {
      for (var element in usageStats) {
        if (element.packageName == application.packageName) {
          setState(() {
            appStats = element;
          });
        }
      }
    }
    print('value of App Usage${appStats!.packageName}');
    print('The app Opened ${appStats!.lastTimeUsed}');
    return appStats!;
  }

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

      StreamSubscription<Position> positionStream =
          Geolocator.getPositionStream().listen((Position? position) {
        print("++++++++++++++++++++++++++");
        print(position!.latitude);
        print(position!.longitude);
        print("==============================");
      });
    }
  }

  getAllInstalledApps() async {
    UsageStats.grantUsagePermission();
    appinformation = [];
    // check if permission is granted
    List<Application> apps = await DeviceApps.getInstalledApplications(
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
      includeAppIcons: true,
    );
    if (apps.isNotEmpty) {
      for (var element in apps) {
        UsageInfo uInfo = await getUsage(element);
        print('screen time ${uInfo.totalTimeInForeground.toString()}');
        Appinformation appInfo = Appinformation(
            element.appName,
            element.packageName,
            uInfo.totalTimeInForeground.toString(),
            uInfo.lastTimeUsed.toString(),
            false);
        setState(() {
          appinformation.add(appInfo);
        });
      }
    }
    print('length of the apps ${apps.length}');
    await updateApps(docId!);
  }

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('appinfo', arrayContains: 'YouTube')
        .get();
    print(querySnapshot.docs);
  }

  getUserId() async {
    var user = FirebaseAuth.instance.currentUser;

    print('Uid of the child is ${user!.uid}');

    setState(() {
      docId = user.uid;
      print('docId equals $docId');
    });
  }

  getPermission() async {
    bool isAdmin = await DevicePolicyManager.isPermissionGranted();
    if (isAdmin == false) {
      DevicePolicyManager.requestPermession();
    }
    await DevicePolicyManager.requestPermession(
        "Your app is requesting the Adminstration permission");
  }

  updateApps(String docId) async {
    await FirebaseFirestore.instance
        .collection('children')
        .doc(docId)
        .update({'appinfo': appinformation.map((e) => e.toJson()).toList()});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Column(children: <Widget>[
              SizedBox(
                width: 390,
                height: 84,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Now,\n T',
                        style: TextStyle(
                          color: Color(0xFF124559),
                          fontSize: 28,
                          fontFamily: 'Alice',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: 'he Devices are connected\n',
                        style: TextStyle(
                          color: Color(0xFF124559),
                          fontSize: 25,
                          fontFamily: 'Alice',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ]),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.88,
                      alignment: Alignment.center,
                      image: AssetImage(
                        "assets/images/image46.png",
                      ))),
            ),
            const SizedBox(
              width: double.infinity,
              height: 100,
              child: Text(
                'Unauthorized Account: This account does not have authorization to perform any actions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0x7F124559),
                  fontSize: 16,
                  fontFamily: 'Alice',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const WelcomeScreen()));
              },
              child: const Text('LogOut'),
            )
          ]),
    )));
  }
}
