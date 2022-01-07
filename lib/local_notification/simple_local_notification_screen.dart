import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class LocalNotificationScreen extends StatefulWidget {
  @override
  LocalNotificationScreenState createState() => LocalNotificationScreenState();
}

class LocalNotificationScreenState extends State<LocalNotificationScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notification();
  }

  notification() async {
    print('Notification method called.!');
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = const IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    var platform = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform);
  }

  notificationDetails() async {
    var androidNotification = const AndroidNotificationDetails(
      'CHANNEL ID',
      "CHANNLE NAME",
      "channelDescription",
      importance: Importance.max,
      priority: Priority.max,
      enableLights: true,
      playSound: true,
    );
    var iosNotification = const IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformNotification =
    NotificationDetails(android: androidNotification, iOS: iosNotification);


    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin.show(
        0,
        'Title : title',
        'Body : body',
        platformNotification,
      );
    } else {
      await flutterLocalNotificationsPlugin.show(
        0,
        'Title : title',
        'Body : body',
        platformNotification,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            notificationDetails();
          },
          child: const Text('Send notification'),
        ),
      ),
    );
  }
}
