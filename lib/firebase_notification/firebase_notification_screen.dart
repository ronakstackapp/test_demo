import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:test_demo/firebase_notification/notification_model.dart';

class FirebaseNotificationScreen extends StatefulWidget {
  const FirebaseNotificationScreen({Key? key}) : super(key: key);

  @override
  _FirebaseNotificationScreenState createState() => _FirebaseNotificationScreenState();
}

class _FirebaseNotificationScreenState extends State<FirebaseNotificationScreen> {
  late int _totalNotifications;


  // Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   await Firebase.initializeApp();
  //
  //   print("Handling a background message: ${message.messageId}");
  //   message.notification!.title;
  // }

  late FirebaseMessaging messaging;
  PushNotification? _notificationInfo;
  @override
  void initState() {
    super.initState();
    _totalNotifications = 0;

    ///1
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print("token--->>>$value");
    });


  //  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    //
    ///2
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);

      PushNotification notification = PushNotification(
                  title: event.notification?.title,
                  body: event.notification?.body,
                );

      setState(() {
                _notificationInfo = notification;
                _totalNotifications++;
              });

      if (!mounted) return;

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(event.notification!.title!),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });

    });
    // /3
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });

  }



  // void registerNotification() async {
  //
  //   // 2. Instantiate Firebase Messaging
  //   messaging = FirebaseMessaging.instance;
  //
  //   // 3. On iOS, this helps to take the user permissions
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     provisional: false,
  //     sound: true,
  //   );
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //     // TODO: handle the received notifications
  //
  //
  //     // For handling the received notifications
  //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //       // Parse the message received
  //       PushNotification notification = PushNotification(
  //         title: message.notification?.title,
  //         body: message.notification?.body,
  //       );
  //
  //       setState(() {
  //         _notificationInfo = notification;
  //         _totalNotifications++;
  //       });
  //     });
  //
  //   } else {
  //     print('User declined or has not accepted permission');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Notify'),
        brightness: Brightness.dark,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const  Text(
            'App for capturing Firebase Push Notifications',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16.0),
          NotificationBadge(totalNotifications: _totalNotifications),
          SizedBox(height: 16.0),
          // TODO: add the notification text here

          _notificationInfo != null
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TITLE: ${_notificationInfo!.title}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'BODY: ${_notificationInfo!.body}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          )
              : Container(),
        ],
      ),
    );
  }
}


class NotificationBadge extends StatelessWidget {
  final int totalNotifications;

   NotificationBadge({required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$totalNotifications',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}