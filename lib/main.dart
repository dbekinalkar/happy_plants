import 'package:flutter/material.dart';
import 'app.dart';
import 'package:get_it/get_it.dart';
import 'services/plant_service.dart';
import 'services/notification_service.dart';
import 'services/plant_persistence_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

GetIt locator = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('Settings up services');
  setupServices();
  debugPrint('done setting up services');
  tz.initializeTimeZones();
  runApp(PlantWateringApp());
  requestNotificationPermissions();
}

void setupServices() {
  locator.registerSingleton(PlantService());
  locator.registerSingleton(NotificationService());
  locator.registerSingleton(PlantPersistenceService());
}

void requestNotificationPermissions() async {
  var status = await Permission.notification.status;
  debugPrint(status.toString());
  if (!status.isGranted) {
    status = await Permission.notification.request();
    if (!status.isGranted) {
      // The user did not grant the permission. Handle this case appropriately.
    }
  }
}
