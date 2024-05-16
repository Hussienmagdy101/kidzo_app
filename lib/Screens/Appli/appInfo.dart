import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidzo_app/Screens/Appli/appUsage.dart';
import 'package:kidzo_app/Screens/packages/checkPermission.dart';
import 'package:usage_stats/usage_stats.dart';

class AppInfo extends StatefulWidget {
  final Application application;
  const AppInfo({super.key, required this.application});

  @override
  State<AppInfo> createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  UsageInfo? appStats;
  getUsage() async {
    DateTime endDate = DateTime.now();
    DateTime startDate =
        DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);

    // grant usage permission - opens Usage Settings

    // query events
    // List<EventUsageInfo> events =
    //     await UsageStats.queryEvents(startDate, endDate);

    // query usage stats
    List<UsageInfo> usageStats =
        await UsageStats.queryUsageStats(startDate, endDate);

    if (usageStats.isNotEmpty) {
      for (var element in usageStats) {
        if (element.packageName == widget.application.packageName) {
          setState(() {
            appStats = element;
          });
        }
      }
    }
    print('value of App Usage${appStats!.packageName}');
  }

  @override
  void initState() {
    super.initState();
    getUsage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.application.appName),
        ),
        body: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: const Text(
                      'Screen Time :',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      '${(int.parse(appStats!.totalTimeInForeground!) / 1000 / 60).toStringAsFixed(2)} min:sec',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: const Text(
                      'Last Time Used :',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      DateFormat('dd-MM-yyyy HH-mm-ss').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(appStats!.lastTimeUsed!))),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
