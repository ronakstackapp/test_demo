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

  @override
  void initState() {
    // TODO: implement initState
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
                        obscureText: password ? false : true,
                        validatorOnTap: (value) =>
                            loginPasswordValidation(value),
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                password = !password;
                              });
                            },
                            child: password
                                ? const Icon(Icons.remove_red_eye,
                                    color: Colors.blue)
                                : const Icon(CupertinoIcons.eye_slash,
                                    color: Colors.blue)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Button(
                      buttonText: "Login",
                      pressedButton: () {
                        FocusScope.of(context).requestFocus(FocusNode());

                       if(_key.currentState!.validate()){
                         // ignore: avoid_function_literals_in_foreach_calls
                         userModelList.forEach((element) async {
                           print("-->> ${element.email}");
                           if (element.email == emailController.text && emailController.text.trim().isNotEmpty) {
                             print("${element.email}");

                             if (element.password == passwordController.text) {
                               print("userModelList --> ${element.toJson()}");
                               print(""
                                   " --> ${element.toJson()}");
                               userName = element.name;
                              await _showDialog();
                             } else if(passwordController.text.trim().isNotEmpty) {
                               ScaffoldMessenger.of(context)
                                   .showSnackBar(const SnackBar(
                                 content: Text(
                                   "Incorrect password",
                                   style: TextStyle(color: Colors.white),
                                 ),
                                 backgroundColor: Colors.red,
                               ));
                             }
                           } else if( emailController.text.trim().isNotEmpty && emailController.text != element.email) {
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

  return  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("WelCome!"),
          content:  Text("Hello $userName"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  print("Show Dialog -->>");
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const HomeScreen(selectedPage: 2);
                  }));
                },
                child: const Text("ok"))
          ],
        );
      },
    );
  }
}
