import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:intl/intl.dart';
import 'package:test_demo/screen/pageview_home_screen.dart';

import 'fill_data_screeen.dart';
// ignore: unused_import
import 'home_screen.dart';

class ShowDataScreen extends StatefulWidget {
  const ShowDataScreen({Key? key}) : super(key: key);

  @override
  _ShowDataScreenState createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {
  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    // TODO: implement initState

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
          child: ListView.builder(
            itemCount: userModelList.length,
            itemBuilder: (BuildContext context, int index) {
              userModelList.sort((a, b) => a.name!.compareTo(b.name!));
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _RowData(
                                title: "Name : ",
                                data: "${userModelList[index].name}",
                              ),
                              _RowData(
                                title: "Email : ",
                                data: "${userModelList[index].email}",
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
                                  Text(DateFormat('dd/MM/yyyy').format(
                                      userModelList[index].dob ??
                                          DateTime.now())),
                                ],
                              ),
                              // _RowData(title: "DOB : ",data: DateFormat('dd/MM/yyyy').format(userModelList[index].dob!),),
                              _RowData(
                                title: "PassWord : ",
                                data: "${userModelList[index].password}",
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
                                Future.delayed( const Duration(milliseconds: 500),(){
                                  counter.value = 1;
                                });

                                ///tabbar
                               //  tabController!.index = 1;

                                // ignore: avoid_print
                                print("tab inderx ---- 1 -- $tabInt");
                                userModelg = userModelList[index];
                                indexg = index;
                                // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
                                //   return HomeScreen(selectedPage: 1,userModel: userModelList[index],index: index,);
                                // }), (Route<dynamic> route) => false);
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
          title: const Text("Alert!",style: TextStyle(color: Colors.red),),
          content:const Text("Are you sure you want to delete this User Details?"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  // ignore: avoid_print
                  print("Show Dialog -->>");
                  Navigator.pop(context);
                },
                child: const Text("Back")),
            TextButton(
                onPressed: () {
                  // ignore: avoid_print
                  print("Show Dialog -->>");
                  setState(() {
                    userModelList.removeAt(indexRemove!);
                    Navigator.pop(context);
                  });
                //  Navigator.pop(context);
                },
                child: const Text("Delete",style: TextStyle(color: Colors.red),)),
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
