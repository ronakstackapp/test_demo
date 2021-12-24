import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:intl/intl.dart';
import 'package:test_demo/screen/home_screen.dart';

import 'fill_data_screeen.dart';

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

                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  HomeScreen( selectedPage: 1,
                                         userModel: userModelList[index],
                                         index: index,)), (Route<dynamic> route) => false);

                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //   return HomeScreen(
                                //     selectedPage: 1,
                                //     userModel: userModelList[index],
                                //     index: index,
                                //   );
                                // }));
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  userModelList.removeAt(index);
                                });
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
