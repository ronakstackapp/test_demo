// import 'package:flutter/material.dart';
// import 'package:test_demo/multi_img_storage/uploadimg_screen.dart';
// import 'package:test_demo/multi_img_storage/viewimg_screen.dart';
//
//
//
//
// class MultiImgUploadScreen extends StatefulWidget {
//   @override
//   _MultiImgUploadScreenState createState() => _MultiImgUploadScreenState();
// }
//
// class _MultiImgUploadScreenState extends State<MultiImgUploadScreen> {
//   final _globalKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         key: _globalKey,
//         backgroundColor: Theme.of(context).backgroundColor,
//         appBar: AppBar(
//           title: Text('Multiple Images'),
//           bottom:   TabBar(
//             tabs: [
//               Tab(icon: Icon(Icons.image),text: 'Images',),
//               Tab(icon: Icon(Icons.cloud_upload),text: "Upload Images",),
//             ],
//             indicatorColor: Colors.red,
//             indicatorWeight: 5.0,
//           ),
//         ),
//
//         body: TabBarView(
//           children: <Widget>[
//             ViewImages(),
//             UploadImages(globalKey: _globalKey,),
//           ],
//         ),
//       ),
//     );
//   }
// }