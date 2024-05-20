// ignore: file_names
import 'package:device_policy_manager/device_policy_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:kidzo_app/Screens/App/home.dart';
import 'package:kidzo_app/widget/constant.dart';


class ScreenLock extends StatefulWidget {
  const ScreenLock({super.key});

  @override
  State<ScreenLock> createState() => _ScreenLockState();
}

class _ScreenLockState extends State<ScreenLock> {
  bool isSelected = false;
  getPermission() async {
    bool isAdmin = await DevicePolicyManager.isPermissionGranted();
    if (isAdmin == false) {
      DevicePolicyManager.requestPermession();
    }
    await DevicePolicyManager.requestPermession(
        "Your app is requesting the Adminstration permission");
  }

  showOverlay() async {
    if (isSelected == true) {
      await FlutterOverlayWindow.showOverlay();
    } else {
      await FlutterOverlayWindow.closeOverlay();
    }
  }
  

  @override
  void initState() {
    getPermission();
    showOverlay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3,
          decoration: const ShapeDecoration(
            color: Color.fromRGBO(18, 69, 89, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                  topLeft: Radius.zero,
                  topRight: Radius.zero),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(110),
            child: Text(
              "ScreenTime",
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 45),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage()));
              },
              child: Image.asset(
                "assets/images/left_arrow1.png",
                fit: BoxFit.contain,
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height / 1.3,
            decoration: ShapeDecoration(
              color: const Color.fromARGB(255, 230, 230, 230),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.only(top: 40, right: 30),
              title: const Text(
                "Lock Screen",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 22,
                  fontFamily: 'Alice',
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              trailing: Switch(
                onChanged: (value) async {
                  setState(() {
                    if (isSelected == false) {
                      DevicePolicyManager.lockNow();
                    }
                    if (isSelected == true) {}
                  });
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                value: isSelected,
                inactiveTrackColor: const Color.fromRGBO(239, 239, 240, 1),
                activeColor: kPrimaryColor,
              ),
            ),
          ),
        )
      ],
    ));
  }
}
