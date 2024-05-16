import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:kidzo_app/Screens/packages/Monitoring_Services.dart';

Future<void> startMonitoringService() async {
  // Initialize FlutterBackgroundService
  await FlutterBackgroundService.initialize(onStart: () {
    onMonitoringServiceStart(); // Adjust this call according to its argument requirements
  });

  final monitoringService = FlutterBackgroundService();
  final iosConfiguration = IosConfiguration();
  final androidConfiguration = AndroidConfiguration(
    onStart: onMonitoringServiceStart, // Adjust this according to its argument requirements
    autoStart: true,
    isForegroundMode: true,
    autoStartOnBoot: true,
    initialNotificationTitle: 'Flutter App lock',
    initialNotificationContent: '',
  );

  await monitoringService.configure(
    iosConfiguration: iosConfiguration,
    androidConfiguration: androidConfiguration,
  );
}
