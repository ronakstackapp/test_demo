// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_demo/model/usermodel.dart';
import 'package:test_demo/screen/fill_data_screeen.dart';
import 'package:test_demo/screen/home_screen.dart';
import 'package:test_demo/validation/validation_screen.dart';

import '../common_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, this.userModel}) : super(key: key);
  final UserModel? userModel;


  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}



class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool password = true;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? userName;
  // String? email;
  // String? yourPassword;

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    // TODO: implement initState
    userName = "";
     // emailController.text = email??"";
     // passwordController.text = yourPassword??"";
     // print("Controller -->${emailController.text}");

    if (widget.userModel != null) {
      print("RegisterScreen --> initState --> userModel!=null ");
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
            height: 220,
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

                                    color: password ?  Colors.blue[400] : Colors.blue)




                        ),
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
                          bool isEmailAvailable = userModelList.any((element) =>
                              element.email == emailController.text);

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
                            bool isPassWordAvailable = userModelList.any(
                                (element) =>
                                   ( element.password ==
                                    passwordController.text) && (element.email == emailController.text) );

                            if (isPassWordAvailable) {

                              UserModel userModel = userModelList.firstWhere(
                                (element) =>
                                    element.password == passwordController.text,
                                orElse: () => UserModel(password: ""),
                              );
                               userName = userModel.name;
                              // yourPassword = passwordController.text;
                              // email = emailController.text;
                              _showDialog();
                            }
                            else {

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
