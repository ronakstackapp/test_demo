import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:intl/intl.dart';
import 'package:test_demo/model/usermodel.dart';
import 'package:test_demo/screen/pageview_home_screen.dart';
import 'database_screen.dart';
import 'firebase_fill_data.dart';


class FirebaseShowDataScreen extends StatefulWidget {
  const FirebaseShowDataScreen({Key? key}) : super(key: key);

  @override
  _FirebaseShowDataScreenState createState() => _FirebaseShowDataScreenState();
}

class _FirebaseShowDataScreenState extends State<FirebaseShowDataScreen> {
  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    // TODO: implement initState

    super.initState();
  }

  //
  // Future<DocumentSnapshot> getUserInfo()async{
  //  // var firebaseUser = await FirebaseAuth.instance.currentUser();
  //   return await FirebaseFirestore.instance.collection('note').doc().get();
  // }

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
          child: StreamBuilder(
          //  stream: Database.readItems(),
            stream: FirebaseFirestore.instance.collection('User').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {


              if(snapshot.hasData){
                return  ListView.builder(
                  itemCount:snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];
                   // userModelList.sort((a, b) => a.name!.compareTo(b.name!));
                    print("snapshots --->>${snapshot.data!.docs.length}");
                    print("snapshots --->>${documentSnapshot['name']}");
                    print(" DateTime.parse(documentSnapshot['dob'].toString()) --->>${documentSnapshot['dob'].runtimeType}");
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
                                      data: "${documentSnapshot['name']}",
                                    ),
                                    _RowData(
                                      title: "Email : ",
                                      data: "${documentSnapshot['email']}",
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
                                          Text("${documentSnapshot['dob']}")
                                      //  Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(documentSnapshot['dob']))),
                                     ],
                                   ),
                                 //   _RowData(title: "DOB : ",data: DateFormat('dd/MM/yyyy').format(userModelList[index].dob!),),
                                    _RowData(
                                      title: "PassWord : ",
                                      data: "${documentSnapshot['password']}",
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

                                      print("tab inderx ---- 1 -- $tabInt");


                                      UserModel userModel =UserModel(
                                        name: documentSnapshot['name'],
                                        password: documentSnapshot['password'],
                                        dob: documentSnapshot['dob'],
                                        email: documentSnapshot['email']
                                      );
                                       userModelg = userModel;
                                      // indexg = index;
                                      isUpdate = true;
                                      id = documentSnapshot['email'];

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
                                      _showDialog(documentSnapshot['email']);
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
                ); }
               else if(snapshot.hasError){
                return const Text("No data");
              }
              return const Center(child:  CircularProgressIndicator());
              }


          ),
        ),
      ),
    );
  }

  _showDialog(String indexRemove) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert!",style: TextStyle(color: Colors.red),),
          content:const Text("Are you sure you want to delete this User Details?"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  print("Show Dialog -->>");
                  Navigator.pop(context);
                },
                child: const Text("Back")),
            TextButton(
                onPressed: () {
                  print("Show Dialog -->>");
                  setState(() {
                   // userModelList.removeAt(indexRemove!);
                    Database.deleteProduct(indexRemove);
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
