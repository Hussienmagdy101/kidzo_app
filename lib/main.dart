import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kidzo_app/Re-usable_Component/print.dart';
import 'package:kidzo_app/Screens/packages/background_Services.dart';
import 'package:kidzo_app/Screens/widget/logincheck.dart';
import 'package:kidzo_app/widget/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  

// hi
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyC57p0R3tJqj-Df_sWKHGXXz4I_g0BllRY',
          appId: '1:897461993498:android:961ab21bbb9cf01bb011a3',
          messagingSenderId: '897461993498',
          projectId: 'kidzo-f479a'));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        printFunction('====================User is currently signed Out!');
      } else {
        printFunction('====================User is signed in');
      }
    });
    super.initState();
  }
//JJI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kidzo',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
        ),
        home: const LoginCheck());
  }
}
