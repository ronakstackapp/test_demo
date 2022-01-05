// import 'package:flutter/material.dart';
//
//
//
// // PageController? pageController;
//
// class FirebasePageView extends StatefulWidget {
//   FirebasePageView({Key? key}) : super(key: key);
//
//   @override
//   _FirebasePageViewState createState() => _FirebasePageViewState();
// }
//
// class _FirebasePageViewState extends State<FirebasePageView> {
//   int _selectedIndex = 0;
//
//    late PageController _pageController;
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:const  Text("Tab Bar"),
//          bottom: PreferredSize(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        // alignment: MainAxisAlignment.center,
//         children: <Widget>[
//           FlatButton(
//             splashColor: Colors.blueAccent,
//             color: Colors.blue,
//             onPressed: () {
//               _pageController.animateToPage(0, duration:const Duration(milliseconds: 500), curve: Curves.ease);
//             },
//             child:const Text("One",),
//           ),
//           FlatButton(
//             splashColor: Colors.blueAccent,
//             color: Colors.blue,
//             onPressed: () {
//               _pageController.animateToPage(1, duration:const Duration(milliseconds: 500), curve: Curves.ease);
//             },
//             child:const Text("Two",),
//           ),
//           FlatButton(
//             splashColor: Colors.blueAccent,
//             color: Colors.blue,
//             onPressed: () {
//               _pageController.animateToPage(2, duration:const Duration(milliseconds: 500), curve: Curves.ease);
//             },
//             child:const Text("Three",),
//           )
//         ],
//       ),
//         preferredSize: const Size.fromHeight(35.0)),
//     ),
//
//       body: Expanded(
//         child: PageView(
//           controller: _pageController,
//           children:  [
//             Center(
//               child: Container(height: 200,width: 200,color:
//                 Colors.red,),
//             ),
//             Center(
//               child: Container(height: 200,width: 200,color:
//                 Colors.yellow,),
//             ),
//             Center(
//               child: Container(height: 200,width: 200,color:
//                 Colors.green,),
//             )
//             // FirebasePageView(),
//             // // RegisterScreen(userModel: widget.userModel,),
//             // // ignore: prefer_const_constructors
//             // FillDataScreen(
//             //   // userModel: widget.userModel,
//             //   // listIndex: widget.index,
//             // ),
//             // const ShowDataScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:test_demo/firebase_demo/firebase_fill_data.dart';
import 'package:test_demo/firebase_demo/firebase_register.dart';
import 'package:test_demo/firebase_demo/firebase_show_data.dart';


import '../common_widget.dart';


PageController? pageController;
// int? tabInt = 0;
ValueNotifier<int> counter = ValueNotifier(0);

class FirebasePageView extends StatefulWidget {
  FirebasePageView({Key? key}) : super(key: key);

  @override
  _FirebasePageViewState createState() => _FirebasePageViewState();
}

class _FirebasePageViewState extends State<FirebasePageView> {
  int _selectedIndex = 0;

 // PageController? pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    pageController!.addListener(() {
      if(pageController!.page ==0){
        counter.value=0;
      }else if( pageController!.page==1){
        counter.value=1;
      }else if( pageController!.page == 2){
        counter.value=2;
      }
    });
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Tab Bar"),
        bottom: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // alignment: MainAxisAlignment.center,
              children: <Widget>[
                tabWidget(
                  inkWellTap: () {
                    pageController!.animateToPage(0,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.ease);
                    counter.value = 0;
                  },
                  iconWidget: const Icon(
                    Icons.gpp_good,
                    color: Colors.white,
                  ),
                  intColor: 0,
                ),
                tabWidget(
                  inkWellTap: () {
                    pageController!.animateToPage(1,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.ease);
                    counter.value = 1;
                  },
                  iconWidget: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  intColor: 1,
                ),
                tabWidget(
                  inkWellTap: () {
                    pageController!.animateToPage(2,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.ease);
                    // pageController!.jumpToPage(2);
                    counter.value = 2;
                  },
                  iconWidget: const Icon(
                    Icons.supervisor_account_sharp,
                    color: Colors.white,
                  ),
                  intColor: 2,
                ),
              ],
            ),
            preferredSize: const Size.fromHeight(35.0)),
      ),
      body: PageView(
        controller: pageController,
        scrollBehavior: const ScrollBehavior(),
        children: const [
          ///PageView
          // RegisterScreen(),
          // FillDataScreen(),
          // ShowDataScreen(),

          ///firebase

          FirebaseRegisterScreen(),
          FirebaseFillDataScreen(),
          FirebaseShowDataScreen(),
        ],
      ),
    );
  }
}
