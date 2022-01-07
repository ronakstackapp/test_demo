import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  Future<void> init() async {
     AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');

     IOSInitializationSettings initializationSettingsIOS = const
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: null);

    tz.initializeTimeZones();  // <------

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }





  Future<void> showNotifications() async {
     AndroidNotificationDetails _androidNotificationDetails =
    const  AndroidNotificationDetails(
      'channel ID',
      'channel name',
      'channel description',
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    );

     IOSNotificationDetails _iosNotificationDetails =  const IOSNotificationDetails(
      presentAlert: true,
      presentBadge:true,
      presentSound: true,

    );


    NotificationDetails platformChannelSpecifics =
    NotificationDetails(
        android: _androidNotificationDetails,
        iOS: _iosNotificationDetails);


    await flutterLocalNotificationsPlugin.show(
      0,
      'Notification Title',
      'This is the Notification Body',
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }
  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
    DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      icon: 'flutter_devs',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
  Future<void> showBigPictureNotification() async {
    var bigPictureStyleInformation = const BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
      largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
      contentTitle: 'flutter devs',
      summaryText: 'summaryText',
    );
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel id',
        'big text channel name',
        'big text channel description',
        styleInformation: bigPictureStyleInformation);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics,iOS: null);
    await flutterLocalNotificationsPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics,
        payload: "big image notifications");
  }
  Future<void> showNotificationMediaStyle() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      'media channel description',
      color: Colors.red,
      enableLights: true,
      largeIcon: DrawableResourceAndroidBitmap("flutter_devs"),
      styleInformation: MediaStyleInformation(),
    );
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics,iOS: null);
    await flutterLocalNotificationsPlugin.show(
        0, 'notification title', 'notification body', platformChannelSpecifics);
  }
  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
   // await flutterLocalNotificationsPlugin.cancel(NOTIFICATION_ID);
  }
  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

Future<void> showPeriodicNotification() async {
  const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('channel_id', 'Channel Name', 'Channel Description');
  const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails,iOS: null);
  await flutterLocalNotificationsPlugin.periodicallyShow(0, 'Flutter Local Notification', 'Flutter Periodic Notification',
      RepeatInterval.everyMinute, notificationDetails, payload: 'Destination Screen(Periodic Notification)');
}



Future<void> showBigTextNotification() async {
  const BigTextStyleInformation bigTextStyleInformation =
  BigTextStyleInformation(
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    htmlFormatBigText: true,
    contentTitle: 'Flutter Big Text Notification Title',
    htmlFormatContentTitle: true,
    summaryText: 'Flutter Big Text Notification Summary Text',
    htmlFormatSummaryText: true,
  );
  const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('channel_id', 'Channel Name', 'Channel Description', styleInformation: bigTextStyleInformation);
  const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails,iOS: null);
  await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification', 'Flutter Big Text Notification',
      notificationDetails, payload: 'Destination Screen(Big Text Notification)');
}

Future<void> showInsistentNotification() async {
  const int insistentFlag = 4;
  final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails('channel_id', 'Channel Name', 'Channel Description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      additionalFlags: Int32List.fromList(<int>[insistentFlag]));
  final NotificationDetails notificationDetails = NotificationDetails(android: androidPlatformChannelSpecifics, iOS:null);
  await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification', 'Flutter Insistent Notification',
      notificationDetails, payload: 'Destination Screen(Insistent Notification)');
}

Future<void> showOngoingNotification() async {
  const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('channel_id', 'Channel Name', 'Channel Description',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      autoCancel: false);
  const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS:null);
  await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification', 'Flutter Ongoing Notification',
      notificationDetails, payload: 'Destination Screen(Ongoing Notification)');
}

Future<void> showProgressNotification() async {
  const int maxProgress = 5;
  for (int i = 0; i <= maxProgress; i++) {
    await Future<void>.delayed(const Duration(seconds: 1), () async {
      final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('channel_id', 'Channel Name', 'Channel Description',
          channelShowBadge: false,
          importance: Importance.max,
          priority: Priority.high,
          onlyAlertOnce: true,
          showProgress: true,
          maxProgress: maxProgress,
          progress: i);
      final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails,iOS: null);
      await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification', 'Flutter Progress Notification',
          notificationDetails, payload: 'Destination Screen(Progress Notification)');
    });
  }
}

}