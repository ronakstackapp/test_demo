import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_demo/model/usermodel.dart';

// ignore: unused_import
// ignore: avoid_print

import 'package:test_demo/screen/array_data_screen/fill_data_screeen.dart';
import 'package:test_demo/screen/array_data_screen/pageview_home_screen.dart';
import 'package:test_demo/screen/sqlite_data_screen/sqlite_fill_data_screen.dart';
import 'package:test_demo/sqlite/sqlite_helper.dart';

class SqliteShowDataScreen extends StatefulWidget {
  const SqliteShowDataScreen({Key? key}) : super(key: key);

  @override
  _SqliteShowDataScreenState createState() => _SqliteShowDataScreenState();
}

class _SqliteShowDataScreenState extends State<SqliteShowDataScreen> {
  final dbHelper = DataBaseManager.instance;
  Future? data;

  @override
  void initState() {
    // ignore: avoid_print
    print("SqliteShowDataScreen -- initState");
    FocusManager.instance.primaryFocus?.unfocus();
    // TODO: implement initState

     data = dbHelper.queryAllRows();
    // ignore: avoid_print
    print("Show Data-->> $data");


    super.initState();
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
          child: FutureBuilder(
            future: data,
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              // ignore: avoid_print
              print("snapshot data -->${snapshot.data}");
              return snapshot.data == null ?const Center(child:CircularProgressIndicator()) : ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                 // print("snapshot data list index -->>${data![index].}");
                 // userModelList.sort((a, b) => a.name!.compareTo(b.name!));
                  var userdata = snapshot.data[index];
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
                                    data: "${userdata['UserName']}",
                                  ),
                                  _RowData(
                                    title: "Email : ",
                                    data: "${userdata['Email']}",
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
                                      //  Text("${userModelList[index].dob}")
                                      Text("${userdata['BirthDate']}"),
                                    ],
                                  ),
                                  // _RowData(title: "DOB : ",data: DateFormat('dd/MM/yyyy').format(userModelList[index].dob!),),
                                  _RowData(
                                    title: "PassWord : ",
                                    data: "${userdata['Password']}",
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    ///pageVIew
                                    // ignore: avoid_print
                                    print("tab inderx ---- 0 -- $tabInt");
                                    pageController!.animateToPage(1,
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        curve: Curves.ease);
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      counter.value = 1;
                                    });


                                    ///tabbar
                                    //  tabController!.index = 1;
                                    // print("tab inderx ---- 1 -- $tabInt");


                                    indexSqlite = userdata['Id'];
                                     // Map<String, dynamic> updateDate = {'Id': 7, 'UserName': 'ronak', 'Email':' ronak@gmail.com', 'BirthDate': 30/12/1978, 'Password': 'qqqqqq'};



                                    UserModel userModel = UserModel(
                                      name: userdata['UserName'],
                                      email: userdata['Email'],
                                      dob: DateFormat('dd/MM/yyyy').parse(userdata['BirthDate']),
                                      password: userdata['Password'],
                                    );

                            print("userModel --->>> 00 -->>  ${userModel.email}");
                                    userModelSqlite = userModel;

                                    print("userModel --->>> 11 ---- >>  ${userModelSqlite!.name}");
                                    //
                                    //  //dbHelper.update(, userdata['Id']);
                                    setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // ignore: avoid_print
                                    print("_showDialog -->>${userdata['Id']}");


                                    _showDialog(userdata['Id'],userdata['UserName']);
                                    // setState(() {
                                    //   userModelList.removeAt(index);
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
              );
            },
          ),
        ),
      ),
    );
  }

  _showDialog(int? id,String? userName) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Alert!",
            style: TextStyle(color: Colors.red),
          ),
          content:
               Text("Are you sure you want to delete $userName Details?"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  // ignore: avoid_print
                  print("Show Dialog -->>");
                  Navigator.pop(context);
                },
                child: const Text("No")),
            TextButton(
                onPressed: () async {
                  // ignore: avoid_print
                  print("Show Dialog -->>");
                await  dbHelper.delete(id!);
                  // data = dbHelper.queryAllRows();
                  // setState(()  {
                  //
                  // });
                  Navigator.pop(context);
                },
                child: const Text(
                  "Yes",
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
