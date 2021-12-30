
import 'package:flutter/material.dart';
import 'package:test_demo/share_pref/share_pref_fill_data.dart';
import 'package:test_demo/share_pref/share_pref_register.dart';
import 'package:test_demo/share_pref/share_pref_show_data.dart';

import '../common_widget.dart';


PageController? pageController;
int? tabInt = 0;
ValueNotifier<int> counter = ValueNotifier(0);


class TestWidget extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  TestWidget({Key? key}) : super(key: key);

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
 // int _selectedIndex = 0;

  // late PageController _pageController;
  bool? isBool = false;

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


///share_pref_only
  isBoolFunction(bool isBools){
    print("isBoolFunction  - 0 -->>$isBools");
    setState(() {
      isBool = isBools;
    });
    print("isBoolFunction  - 1 -->>$isBool");
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  @override
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
                    setState(() {
                      isBool = false;
                    });

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
                    setState(() {
                      isBool = false;
                    });
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
        children:  [
          ///pageView
          // RegisterScreen(),
          // FillDataScreen(),
          // ShowDataScreen

          ///Share_pref
         const SharePrefRegisterScreen(),
          SharePrefFillDataScreen(isUser: isBool??false),
          SharePrefShowDataScreen(isBoolFunction)
        ],
      ),
    );
  }
}
