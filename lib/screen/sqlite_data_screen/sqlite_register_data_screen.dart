// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_demo/model/usermodel.dart';
import 'package:test_demo/screen/array_data_screen/fill_data_screeen.dart';

// ignore: unused_import
import 'package:test_demo/screen/home_screen.dart';
import 'package:test_demo/sqlite/sqlite_helper.dart';
import 'package:test_demo/validation/validation_screen.dart';

import '../../common_widget.dart';

String email = "";
String yourPassword = "";

class SqliteRegisterScreen extends StatefulWidget {
  const SqliteRegisterScreen({Key? key, this.userModel}) : super(key: key);
  final UserModel? userModel;

  @override
  _SqliteRegisterScreenState createState() => _SqliteRegisterScreenState();
}

class _SqliteRegisterScreenState extends State<SqliteRegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool password = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? userName;

  final dbHelper = DataBaseManager.instance;

  List<Map<String,dynamic>> listData = [];

  MatchData() async {
    listData = await dbHelper.queryAllRows();
    print("MatchData -->>>$listData");
  }

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    userName = "";
    MatchData();
    // TODO: implement initState

    if ((email != "" && yourPassword != "")) {
      emailController.text = email;
      passwordController.text = yourPassword;
    }

    if (widget.userModel != null) {
      print("SqliteRegisterScreen --> initState --> userModel!=null ");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
            height: 230,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF81d7ff)),
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: CommonTextField(
                        textInputType: TextInputType.emailAddress,
                        validatorOnTap: (value) => loginEmailValidation(value),
                        controller: emailController,
                        hint: "Enter Your Email",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: CommonTextField(
                        controller: passwordController,
                        hint: "Enter Your Password",
                        obscureText: !password ? false : true,
                        // textInputType: TextInputType.phone,
                        validatorOnTap: (value) =>
                            loginPasswordValidation(value),
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                password = !password;
                              });
                            },
                            child:
                                // password
                                //     ? const Icon(Icons.remove_red_eye,
                                //         color: Colors.blue)
                                //
                                //   :
                                Icon(Icons.remove_red_eye,
                                    color: password
                                        ? Colors.blue[400]
                                        : Colors.blue)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Button(
                      buttonText: "Login",
                      pressedButton: () {
                        FocusScope.of(context).requestFocus(FocusNode());

                        if (_key.currentState!.validate()) {
                          bool isEmailAvailable = listData.any((element) =>
                              element['Email'] == emailController.text);

                          if (isEmailAvailable) {
                            // UserModel userModel = userModelList.firstWhere(
                            //     (element) {
                            //     return ( element.email == emailController.text) && (element.password == passwordController.text);
                            //     },
                            //
                            //     orElse: () => UserModel(name: ''));
                            // print("userModel -- password-->>> ${userModel.name}");
                            //
                            // // ignore: unnecessary_null_comparison
                            // if(userModel != null ){
                            //   userName = userModel.name;
                            //   _showDialog();

                            ///
                            bool isPassWordAvailable = listData.any((element) =>
                                (element['Password'] ==
                                    passwordController.text) &&
                                (element['Email'] == emailController.text));

                            if (isPassWordAvailable) {
                              Map<String,dynamic> userModel = listData.firstWhere(
                                  (element) =>
                                     ( (element['Password'] ==
                                      passwordController.text) &&(element['Email'] == emailController.text)),
                                  orElse: ()=>{});


                              userName = "";
                              userName = userModel['UserName'];
                              print("userModel['UserName'] --->>$userModel");

                              // yourPassword = passwordController.text;
                              email = emailController.text;
                              yourPassword = passwordController.text;
                              _showDialog();
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  "Incorrect password",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                "Incorrect Email address",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ));
                          }
                          //   UserModel userModel =  userModelList.firstWhere((element) =>  element.email == emailController.text,orElse: ()=> UserModel(name: 'no'));
                          // ignore: avoid_function_literals_in_foreach_calls

                          /*  userModelList.forEach((element) async {
                           print( "register -- element.email-->> ${element.email}");
                           if (element.email == emailController.text && emailController.text.trim().isNotEmpty) {
                             print("${element.email}");
                        print("register ---->>0");
                             if (element.password == passwordController.text) {
                               print("register ---->>1");
                               print("userModelList --> ${element.toJson()}");
                               print(""
                                   " --> ${element.toJson()}");
                               userName = element.name;
                            ///  await _showDialog();
                             } else if(passwordController.text.trim().isNotEmpty) {
                               print("register ---->>2");
                               ScaffoldMessenger.of(context)
                                   .showSnackBar(const SnackBar(
                                 content: Text(
                                   "Incorrect password",
                                   style: TextStyle(color: Colors.white),
                                 ),
                                 backgroundColor: Colors.red,
                               ));
                             }else{
                               print("register ---->>3");
                               ScaffoldMessenger.of(context)
                                   .showSnackBar(const SnackBar(
                                 content: Text(
                                   "Incorrect password",
                                   style: TextStyle(color: Colors.white),
                                 ),
                                 backgroundColor: Colors.red,
                               ));
                             }
                           }
                           // else if( emailController.text.trim().isNotEmpty && emailController.text != element.email) {
                           //   print("register ---->>4");
                           //   ScaffoldMessenger.of(context)
                           //       .showSnackBar(const SnackBar(
                           //     content: Text(
                           //       "Incorrect Email address",
                           //       style: TextStyle(color: Colors.white),
                           //     ),
                           //     backgroundColor: Colors.red,
                           //   ));
                           // }
                           //
                           else{
                             print("register ---->>5");
                             ScaffoldMessenger.of(context)
                                 .showSnackBar(const SnackBar(
                               content: Text(
                                 "Incorrect Email address",
                                 style: TextStyle(color: Colors.white),
                               ),
                               backgroundColor: Colors.red,
                             ));
                           }
                         });
                         */
                        }
                      },
                    ),
                    // Button(pressedButton: (){
                    //
                    // var res =  dbHelper.matchEmailAndPassword(emailController.text);
                    // print("check data -->>${res.runtimeType}");
                    // },buttonText: "check data",),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("WelCome!"),
          content: Text("Hello $userName"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  print("Show Dialog -->>");
                  // yourPassword = passwordController.text;
                  // email = emailController.text;
                  Navigator.pop(context);

                  // Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             const HomeScreen(selectedPage: 2)),
                  //     (Route<dynamic> route) => false);

                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (BuildContext context) {
                  //   return const HomeScreen(selectedPage: 2);
                  // }));
                },
                child: const Text("ok"))
          ],
        );
      },
    );
  }
}
