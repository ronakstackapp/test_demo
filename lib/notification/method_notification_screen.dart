import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("onBackgroundMessage ----------->");

  if (message.data.containsKey('data')) {
    // Handle data message
    final data = message.data['data'];
    print("onBackgroundMessage --->>>$data");
  }

  if (message.data.containsKey('notification')) {
    // Handle notification message
    final notification = message.data['notification'];
    print("onBackgroundMessage --->>>$notification");
  }
  // Or do other work.


}

class FCM {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();

  setNotifications(context) async{

    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      print('initial message');
      titleCtlr.sink.add(initialMessage.notification!.title!);
      bodyCtlr.sink.add(initialMessage.notification!.body!);
    }

    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    FirebaseMessaging.onMessage.listen(
          (message) async {
            print("onMessage ----------->");
        if (message.data.containsKey('data')) {
          // Handle data message
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          streamCtlr.sink.add(message.data['notification']['click_action']);
        }
        // Or do other work.
        titleCtlr.sink.add(message.notification!.title!);
        bodyCtlr.sink.add(message.notification!.body!);
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("onMessageOpenedApp ----------->${message.data} nhdhdngfd");

      if (message.data.containsKey('data')) {
        print("onMessageOpenedApp --->> data--->>>>");
        // Handle data message
        streamCtlr.sink.add(message.data['data']);
        // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) { return  }))
      }
      if (message.data.containsKey('notification')) {
        print("onMessageOpenedApp --->> notification--->>>>");
        // Handle notification message
        streamCtlr.sink.add(message.data['notification']);
      }
      // Or do other work.
      titleCtlr.sink.add(message.notification!.title!);
      bodyCtlr.sink.add(message.notification!.body!);
    });
    // With this token you can test it easily on your phone
    final token =
    _firebaseMessaging.getToken().then((value) => print('Token: $value'));

  }

  dispose() {
    streamCtlr.close();
    bodyCtlr.close();
    titleCtlr.close();
  }
}