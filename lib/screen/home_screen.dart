import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_demo/model/usermodel.dart';
import 'package:test_demo/screen/register_screen.dart';
import 'package:test_demo/screen/show_data_screen.dart';

import 'fill_data_screeen.dart';
import 'pageview_home_screen.dart';


TabController? tabController;


class HomeScreen extends StatefulWidget {
  final UserModel? userModel;

  final int selectedPage;
  final int? index;

  const HomeScreen({Key? key, this.userModel, this.selectedPage = 0, this.index})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
 //  late TabController tabController;
 //  late PageController pageController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        vsync: this, length: 3,);

    tabController!.addListener(() {
      print("widget.selectedPage -->.${tabController!.index}");
    tabController!.animateTo(tabController!.index,duration: const Duration(milliseconds: 2000),curve: Curves.easeInCirc);
    //  tabController!.animateTo(widget.selectedPage,curve: Curves.bounceIn);
    //  tabController!.animateTo(widget.selectedPage,curve: Curves.easeInOutCubic);

      if(tabController!.index == 1){
        userModelg = null;
      }

    });

    if (widget.userModel != null) {
      // ignore: avoid_print
      print("${widget.userModel!.name}");
    }
  }

  // @override
  // void dispose() {
  //   tabController!.dispose();
  //   super.dispose();
  // }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
        bottom: TabBar(
          tabs: const [
            Tab(
              icon: Icon(Icons.gpp_good),
            ),
            Tab(
              icon: Icon(Icons.person),
            ),
            Tab(
              icon: Icon(Icons.supervisor_account_sharp),
            ),
          ],
          controller: tabController,
        ),
      ),
      body: TabBarView(
      physics: const ScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        children:const [
          RegisterScreen(),
          // RegisterScreen(userModel: widget.userModel,),
          // ignore: prefer_const_constructors
          FillDataScreen(
            // userModel: widget.userModel,
            // listIndex: widget.index,
          ),
           ShowDataScreen(),
        ],
        controller: tabController,
      ),
    );
  }
}
