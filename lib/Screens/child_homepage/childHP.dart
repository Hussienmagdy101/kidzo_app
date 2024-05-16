import 'package:device_apps/device_apps.dart';
import 'package:kidzo_app/Screens/packages/appInformation.dart';
import 'package:kidzo_app/Screens/parent_signUp/signup_imports.dart';
import 'package:usage_stats/usage_stats.dart';

class ChildHomePage extends StatefulWidget {
  const ChildHomePage({super.key});

  @override
  State<ChildHomePage> createState() => _ChildHomePageState();
}

class _ChildHomePageState extends State<ChildHomePage> {
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
    return appStats!;
  }

  getAllInstalledApps() async {
    UsageStats.grantUsagePermission();
    appinformation = [];
    // check if permission is granted
    List<Application> apps = await DeviceApps.getInstalledApplications(
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: true,
        includeAppIcons: true);
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

  getUserId() async {
    var user = FirebaseAuth.instance.currentUser;

    print('Uid of the child is ${user!.uid}');

    setState(() {
      docId = user.uid;
      print('docId equals $docId');
    });
  }

  updateApps(String docId) async {
    await FirebaseFirestore.instance
        .collection('children')
        .doc(docId)
        .update({'appinfo': appinformation.map((e) => e.toJson()).toList()});
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
