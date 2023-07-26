import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  // String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  // String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  if (duration.inHours < 24) {
    return "${twoDigits(duration.inHours)} hours";
  } else {
    return "${twoDigits(duration.inDays)} days ${twoDigits(duration.inHours.remainder(24))} hours";
  }
}

void requestNotificationPermissions(BuildContext context) async {
  var status = await Permission.notification.status;
  if (!status.isGranted) {
    status = await Permission.notification.request();
    if (!status.isGranted) {
      // Show a dialog informing the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Permission not granted'),
            content: Text('Permission for notifications was not granted. You won\'t receive reminders to water your plants.'),
            actions: [
              TextButton(
                onPressed: () {
                  // Redirect the user to the settings page
                  openAppSettings();
                },
                child: Text('Open Settings'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
  }
}
