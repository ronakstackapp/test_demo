import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_service.dart';


class LocalNotifications extends StatefulWidget {

  String? title;

  LocalNotifications({this.title});

  @override
  _LocalNotificationsState createState() => _LocalNotificationsState();
}

class _LocalNotificationsState extends State<LocalNotifications> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final LocalNotification = NotificationService();
  @override
  void initState() {
    super.initState();
    LocalNotification.init();
    // requestPermissions();
    // var androidSettings = AndroidInitializationSettings('app_icon');
    // var iOSSettings = IOSInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    // );
    //
    // var initSetttings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
    // flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: onClickNotification);

  }
///if_init_is_not_work_remove_commont
  // void requestPermissions() {
  //   flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  // }
  //
  // Future onClickNotification(String? payload) async {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //     return DestinationScreen(
  //       payload: payload,
  //     );
  //   }));
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title!)),
      body:  SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: const Text('Simple Notification'),
                onPressed: () =>  LocalNotification.showNotifications()
              ),
              const SizedBox(height: 15),
              RaisedButton(
                child:const Text('Schedule Notification'),
                onPressed: () => LocalNotification.scheduleNotification()
              ),
              const SizedBox(height: 15),
              // RaisedButton(
              //   child: Text('Periodic Notification'),
              //   onPressed: () => showPeriodicNotification(),
              // ),
              // SizedBox(height: 15),
              RaisedButton(
                child: const Text('Big Picture Notification'),
                onPressed: () => LocalNotification.showBigPictureNotification()
              ),
              const SizedBox(height: 15),
              RaisedButton(
                child:const  Text('Big Text Notification'),
                onPressed: () => LocalNotification.showBigTextNotification()
              ),
              const SizedBox(height: 15),
              RaisedButton(
                  child:const  Text('show Periodic Notification'),
                  onPressed: () => LocalNotification.showPeriodicNotification()
              ),
              const SizedBox(height: 15),
              RaisedButton(
                child:const Text('Insistent Notification'),
                onPressed: () => LocalNotification.showInsistentNotification(),
              ),
              const SizedBox(height: 15),
              RaisedButton(
                child: const Text('OnGoing Notification'),
                onPressed: () => LocalNotification.showOngoingNotification()
              ),
              const SizedBox(height: 15),
              RaisedButton(
                child:const  Text('Progress Notification'),
                onPressed: () => LocalNotification.showProgressNotification()
              ),
              const  SizedBox(height: 15),
              RaisedButton(
                  child:const Text('Cancel Notification'),
                  onPressed: () => LocalNotification.cancelNotification()
              ),
              const SizedBox(height: 15),
              RaisedButton(
                  child:const  Text('Cancel All Notification'),
                  onPressed: () => LocalNotification.cancelAllNotification()
              ),
            ],
          ),
        ),
      ),
    );
  }
}