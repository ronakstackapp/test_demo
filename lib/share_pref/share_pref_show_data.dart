import 'dart:convert';

import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:intl/intl.dart';
import 'package:test_demo/model/usermodel.dart';
import 'package:test_demo/screen/pageview_home_screen.dart';
import 'package:test_demo/share_pref/share_pref_fill_data.dart';
import 'package:test_demo/shared_pref/shared_pref_model.dart';

class SharePrefShowDataScreen extends StatefulWidget {
  Function abc;

  SharePrefShowDataScreen(this.abc);
  @override
  _SharePrefShowDataScreenState createState() =>
      _SharePrefShowDataScreenState();
}

class _SharePrefShowDataScreenState extends State<SharePrefShowDataScreen> {
  List<dynamic> Data = [];

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    // TODO: implement initState
    getdata();
    super.initState();
  }

  getdata() async {
    String res = await MySharedPreferences.modelRead('user1');
    // ignore: avoid_print
    Data = jsonDecode(res);
    setState(() {});
    print(Data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 10,
          decoration: BoxDecoration(
            color: const Color(0xFF81d7ff),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Data.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: Data.length,
                  itemBuilder: (BuildContext context, int index) {
                    //  userModelListPref.sort((a, b) => a.name!.compareTo(b.name!));
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _RowData(
                                      title: "Name : ",
                                      data: "${Data[index]['name']}",
                                    ),
                                    _RowData(
                                      title: "Email : ",
                                      data: "${Data[index]['email']}",
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "DOB : ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        //  Text("${Data!['dob'].runtimeType}")
                                        // Text("${DateTime.parse(Data!['dob'])}"),
                                        Text(DateFormat('dd/MM/yyyy').format(
                                            DateTime.parse(
                                                Data[index]['dob']))),
                                      ],
                                    ),
                                    // _RowData(title: "DOB : ",data: DateFormat('dd/MM/yyyy').format(userModelListPref[index].dob!),),
                                    _RowData(
                                      title: "PassWord : ",
                                      data: "${Data[index]['password']}",
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      ///pageVIew
                                      // ignore: avoid_print
                                      print("tab inderx ---- 0 -- $tabInt");
                                      pageController!.animateToPage(1,
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          curve: Curves.ease);
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        counter.value = 1;
                                      });

                                      ///tabbar
                                      //  tabController!.index = 1;

                                      // ignore: avoid_print
                                      print("tab inderx ---- 1 -- $tabInt");
                                     // userModelg = userModelListPref[index];
                                      print("Updata --->>Data[index]-->>${Data[index]}");
                                      userModelData = Data[index];
                                      print("Updata --->>userModelData-->>$userModelData");
                                      // userModelg != null;
                                      indexg = index;
                                      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
                                      //   return HomeScreen(selectedPage: 1,userModel: userModelListPref[index],index: index,);
                                      // }), (Route<dynamic> route) => false);
                                      widget.abc.call(true);
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _showDialog(index);
                                      // setState(() {
                                      //   userModelListPref.removeAt(index);
                                      // });
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  _showDialog(int? indexRemove) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Alert!",
            style: TextStyle(color: Colors.red),
          ),
          content:
              const Text("Are you sure you want to delete this User Details?"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Back")),
            TextButton(
                onPressed: () async {

                  //  userModelListPref.removeAt(indexRemove!);
                  String res = await MySharedPreferences.modelRead('user1');
                  // print("modelRead -->>>> GEt Data -->${jsonDecode(res).runtimeType}");
                  // print("modelRead -->>>> GEt Data -->${jsonDecode(res)}");
                  List<dynamic> data = jsonDecode(res);

                  data.removeAt(indexRemove!);

                  String userDataNew = jsonEncode(data);
                  MySharedPreferences.saveModel('user1', userDataNew);
                  // print("modelRead -->> List<UserModel> >>getData -->${data.runtimeType}");
                  Navigator.pop(context);

                  setState(() {
                    getdata();
                  });
                  //  Navigator.pop(context);
                },
                child: const Text(
                  "oK",
                  style: TextStyle(color: Colors.red),
                )),
          ],
        );
      },
    );
  }
}

class _RowData extends StatelessWidget {
  const _RowData({
    Key? key,
    this.indexData,
    this.title,
    this.data,
  }) : super(key: key);

  final int? indexData;
  final String? title;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(data!),
      ],
    );
  }
}
