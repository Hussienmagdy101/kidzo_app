// import 'package:device_apps/device_apps.dart';
// import 'package:flutter/material.dart';
// import 'package:kidzo_app/Screens/Appli/home.dart';
// import 'package:kidzo_app/Screens/parent_signUp/signup_imports.dart';
// import 'package:usage_stats/usage_stats.dart';

// import '../../constant.dart';

// class AppLock extends StatefulWidget {
//   const AppLock({super.key});

//   @override
//   State<AppLock> createState() => _AppLockState();
// }

// class _AppLockState extends State<AppLock> {
//   bool _isAppLocked(int index) {
//     return false;
//   }

//   bool isSelected = false;
//   getAllInstalledApps() async {
//     UsageStats.grantUsagePermission();

//     // check if permission is granted
//     List<Application> apps = await DeviceApps.getInstalledApplications(
//         includeSystemApps: true,
//         onlyAppsWithLaunchIntent: true,
//         includeAppIcons: true);
//     print('length of the apps ${apps.length}');

//     @override
//     void initState() {
//       super.initState();
//       getAllInstalledApps();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(children: [
//       Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(colors: [
//           Color.fromRGBO(18, 69, 89, 1),
//           Color.fromRGBO(18, 69, 89, 1)
//         ])),
//       ),
//       SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0.5),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 alignment: Alignment.topLeft,
//                 height: 52,
//                 width: 52,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                 ),
//                 child: GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).pushReplacement(MaterialPageRoute(
//                           builder: (BuildContext context) => const HomePage()));
//                     },
//                     child: Image.asset(
//                       "assets/images/left_arrow1.png",
//                       fit: BoxFit.contain,
//                     )),
//               ),
//             ),
//           ],
//         ),
//       )),
//       const Padding(
//         padding: EdgeInsets.symmetric(horizontal: 120, vertical: 75),
//         child: Text(
//           'App lock',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 40,
//             fontFamily: 'Alice',
//             fontWeight: FontWeight.w400,
//             height: 0,
//           ),
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 130),
//         child: Image.asset('assets/images/Line2.png'),
//       ),
//       const Padding(
//         padding: EdgeInsets.symmetric(vertical: 146, horizontal: 20),
//         child: Text(
//           'App locking allows you to restrict access to specific apps on your child device',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontFamily: 'Alice',
//             fontWeight: FontWeight.w400,
//             height: 0,
//           ),
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.only(top: 200.0),
//         child: Container(
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(40), topRight: Radius.circular(40)),
//             color: Colors.white,
//           ),
//           height: double.infinity,
//           width: double.infinity,
//           child: FutureBuilder(
//             future: DeviceApps.getInstalledApplications(
//               includeSystemApps: true,
//               onlyAppsWithLaunchIntent: true,
//               includeAppIcons: true,
//             ),
//             builder: (context, Snapshot) {
//               if (!Snapshot.hasData) {}
//               List<Application> apps = Snapshot.data as List<Application>;
//               return ListView.builder(
//                 itemCount: apps.length,
//                 itemBuilder: (context, index) {
//                   return Visibility(
//                     visible: !_isAppLocked(index),
//                     child: GestureDetector(
//                       onTap: () {},
//                       child: ListTile(
//                           title: Text(
//                             apps[index].appName,
//                             style: const TextStyle(
//                               fontSize: 23,
//                             ),
//                           ),
//                           leading: Image.memory(
//                               (apps[index] as ApplicationWithIcon).icon),
//                           trailing: Switch(
//                             onChanged: (value) {
//                               setState(() {
//                                 isSelected = !isSelected;
//                               });
//                             },
//                             value: isSelected,
//                             inactiveTrackColor:
//                                 const Color.fromRGBO(255, 255, 255, 1),
//                             activeColor: kPrimaryColor,
//                           )),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       )
//     ]));
//   }
// }
