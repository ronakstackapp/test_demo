// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:test_demo/screen/register_screen.dart';

import 'screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
       fontFamily: "EB Garamond",
      ),
      home: const HomeScreen(selectedPage: 1),
    );
  }
}


// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     title: 'TabBarView inside PageView',
//     home: MyHomePage(),
//   );
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({ Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// final PageController _pageController = PageController();
//
// PageView myPageView = PageView(
//   controller: _pageController,
//   allowImplicitScrolling: true,
//   children: <Widget>[
//     Container(color: Colors.red),
//     GreenShades(),
//     Container(color: Colors.yellow),
//   ],
// );
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       title: Text('TabBarView inside PageView'),
//     ),
//     body: myPageView,
//   );
// }
//
// class GreenShades extends StatefulWidget {
//   @override
//   _GreenShadesState createState() => _GreenShadesState();
// }
//
// class _GreenShadesState extends State<GreenShades>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     this._tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Local dragStartDetail.
//     DragStartDetails? dragStartDetails;
//     // Current drag instance - should be instantiated on overscroll and updated alongside.
//     Drag? drag;
//     return Column(
//       children: <Widget>[
//         TabBar(
//           labelColor: Colors.green,
//           indicatorColor: Colors.green,
//           controller: _tabController,
//           tabs:const <Tab>[
//              Tab(text: "Dark"),
//              Tab(text: "Normal"),
//              Tab(text: "Light"),
//           ],
//         ),
//         Expanded(
//           child: NotificationListener(
//             onNotification: (notification) {
//               if (notification is ScrollStartNotification) {
//                 dragStartDetails = notification.dragDetails!;
//               }
//               if (notification is OverscrollNotification) {
//                 drag = _pageController.position.drag(dragStartDetails!, () {});
//                 drag!.update(notification.dragDetails!);
//               }
//               if (notification is ScrollEndNotification) {
//                 drag!.cancel();
//               }
//               return true;
//             },
//             child: TabBarView(
//               controller: _tabController,
//               children: <Widget>[
//                 Container(color: Colors.green[800]),
//                 Container(color: Colors.green),
//                 Container(color: Colors.green[200]),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }