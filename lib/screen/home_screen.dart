import 'package:flutter/material.dart';
import 'package:test_demo/model/usermodel.dart';
import 'package:test_demo/screen/register_screen.dart';
import 'package:test_demo/screen/show_data_screen.dart';

import 'fill_data_screeen.dart';

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
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        vsync: this, length: 3, initialIndex: widget.selectedPage);
    if (widget.userModel != null) {
      // ignore: avoid_print
      print("${widget.userModel!.name}");
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: [
           RegisterScreen(userModel: widget.userModel,),
          FillDataScreen(
            userModel: widget.userModel,
            index: widget.index,
          ),
          const ShowDataScreen(),
        ],
        controller: _tabController,
      ),
    );
  }
}
