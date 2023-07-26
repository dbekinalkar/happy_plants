import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/plant_model.dart';

class NotificationService {
  final notifications = FlutterLocalNotificationsPlugin();

  NotificationService() {
    const settingsAndroid = AndroidInitializationSettings('ic_launcher'); 
    const settingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);
    notifications.initialize(const InitializationSettings(
        android: settingsAndroid, iOS: settingsIOS));
  }

  Future<void> scheduleNotification(Plant plant) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'plant_watering_reminders', 'Plant Watering Reminders',
        channelDescription: 'Reminder to water your plants',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false);

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    debugPrint('Scheduling notification for ${plant.name} at ${tz.TZDateTime.now(tz.local).add(plant.wateringFrequency)}');

    await notifications.zonedSchedule(
        plant.id.hashCode,
        'Time to water ${plant.name}',
        'It\'s time to water your ${plant.name}!',
        tz.TZDateTime.now(tz.local).add(plant.wateringFrequency),
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<void> cancelNotification(Plant plant) async {
    await notifications.cancel(plant.id.hashCode);
  }
}
