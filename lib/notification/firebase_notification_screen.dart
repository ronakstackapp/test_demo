import 'package:flutter/material.dart';


class notificationScreen extends StatefulWidget {
  const notificationScreen({Key? key, this.notificationTitle, this.notificationBody, this.notificationData}) : super(key: key);
 final String? notificationTitle;
  final String? notificationBody;
  final String? notificationData;

  @override
  State<notificationScreen> createState() => _notificationScreenState();
}

class _notificationScreenState extends State<notificationScreen> {


  // String notificationTitle = 'No Title';
  // String notificationBody = 'No Body';
  // String notificationData = 'No Data';


  @override
  void initState() {
    // final firebaseMessaging = FCM();
    // firebaseMessaging.setNotifications(context);
    //
    // firebaseMessaging.streamCtlr.stream.listen(_changeData);
    // firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    // firebaseMessaging.titleCtlr.stream.listen(_changeTitle);

    super.initState();
  }

  // _changeData(String msg) {
  //   if (!mounted) return;
  //   setState(() => notificationData = msg);
  // }
  // _changeBody(String msg) {
  //   if (!mounted) return;
  //   setState(() => notificationBody = msg);
  // }
  // _changeTitle(String msg) {
  //   if (!mounted) return;
  //   setState(() => notificationTitle = msg);
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.notificationTitle!,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
             widget. notificationBody!,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              widget.notificationData!,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}