import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:kidzo_app/Screens/App/appInfo.dart';
import 'package:usage_stats/usage_stats.dart';

class AppUsage extends StatefulWidget {
  const AppUsage({super.key});

  @override
  State<AppUsage> createState() => _AppUsageState();
}

class _AppUsageState extends State<AppUsage> {
  bool isLoading = true;
  List<Application> appsData = [];
  @override
  void initState() {
    super.initState();
    getAllInstalledApps();
  }

  getAllInstalledApps() async {
    UsageStats.grantUsagePermission();

    // check if permission is granted
    List<Application> apps = await DeviceApps.getInstalledApplications(
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: true,
        includeAppIcons: true);
    print('length of the apps ${apps.length}');
    print(apps);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const SizedBox()),
        body: Container(
          child: FutureBuilder(
              future: DeviceApps.getInstalledApplications(
                  includeSystemApps: true,
                  onlyAppsWithLaunchIntent: true,
                  includeAppIcons: true),
              builder: (context, Snapshot) {
                if (!Snapshot.hasData) {
                  return Container(
                      decoration: const BoxDecoration(),
                      child: const Text(
                        'we dont have any installed apps',
                      ));
                }
                List<Application> apps = Snapshot.data as List<Application>;
                return Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: apps.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return AppInfo(
                                  application: apps[index],
                                );
                              }),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color.fromARGB(255, 72, 74, 79)),
                              child: Center(
                                child: ListTile(
                                  leading: Image.memory(
                                      (apps[index] as ApplicationWithIcon)
                                          .icon),
                                  title: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      apps[index].appName,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        apps[index].openApp();
                                      },
                                      icon: const Icon(
                                        Icons.open_in_new,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }),
        ));
  }
}
