// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:test_demo/model/firebase_user_model.dart';
import 'package:test_demo/model/usermodel.dart';
import 'package:test_demo/phoneverification/phone_verification_screen.dart';
import 'package:test_demo/res/resource_screen.dart';
import 'package:test_demo/screen/fill_data_screeen.dart';
// ignore: unused_import
import 'package:test_demo/screen/home_screen.dart';
import 'package:test_demo/validation/validation_screen.dart';

import '../common_widget.dart';
import 'auth_screen.dart';
import 'login_user_data.dart';
import 'phone_varification.dart';

String email = "";
String yourPassword ="";


class FirebaseRegisterScreen extends StatefulWidget {
  const FirebaseRegisterScreen({Key? key, this.userModel}) : super(key: key);
  final UserModel? userModel;



  @override
  _FirebaseRegisterScreenState createState() => _FirebaseRegisterScreenState();
}
class _FirebaseRegisterScreenState extends State<FirebaseRegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool password = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? userName;
  final _auth = FirebaseAuth.instance;
 User? userData;

  bool isLoggedIn = false;

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    // TODO: implement initState
    userName = "";

    if((email != "" && yourPassword != "")){
      emailController.text = email;
      passwordController.text = yourPassword;
    }

    if (widget.userModel != null) {
      print("FirebaseRegisterScreen --> initState --> userModel!=null ");
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
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
                        Column(
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
                              pressedButton: () async {
                                FocusScope.of(context).requestFocus(FocusNode());

                                if (_key.currentState!.validate()) {

                                  try {
                                    final newUser = await _auth.createUserWithEmailAndPassword(
                                        email: emailController.text, password: passwordController.text);

                                    print("*****${newUser.toString()}");
                                    // if (newUser != null) {
                                    //   Navigator.pushNamed(context, 'home_screen');
                                    // }

                                  } catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                        "email address is already in use by another account",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                    ));

                                  }

                                }
                              },
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SignInButton(
                  Buttons.Google,
                  onPressed: () async {
                    print("aaa");
                    userData = await Authentication.signInWithGoogle(context: context);
                    if(userData != null){
                      setState(() {

                      });
                    }
                  },
                ),
                if(userData != null)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                      onTap: ()  {
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { return  LoginUserScreen(user: userData!); }));
                      },
                      child: const Text(" User ")),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                      onTap: () async {
                        await Authentication.signOut(context: context);
                      },
                      child: const Text("LogOut")),
                )
              ],
            ),
          ),
          TextButton(onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { return const LoginWithPhone(); }));
         },
          child: const Text("PhoneNumber Verification")),
          SignInButton(
            Buttons.Facebook,
            mini: true,
            onPressed: ()  {
              //initiateFacebookLogin();
            }
          ),

        ],
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



  // void initiateFacebookLogin() async {
  //   var facebookLogin = FacebookLogin();
  //   var facebookLoginResult =
  //   await facebookLogin.logInWithReadPermissions(['email']);
  //   switch (facebookLoginResult.status) {
  //     case FacebookLoginStatus.error:
  //       print("Error");
  //       onLoginStatusChanged(false);
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       print("CancelledByUser");
  //       onLoginStatusChanged(false);
  //       break;
  //     case FacebookLoginStatus.loggedIn:
  //       print("LoggedIn");
  //       onLoginStatusChanged(true);
  //       break;
  //   }
  // }
///flutter_auth
  // Future<Resource?> signInWithFacebook() async {
  //   try {
  //     print("FaceBook Login -->>>0");
  //     final LoginResult result = await FacebookAuth.instance.login();
  //     print("FaceBook Login -->>>$result");
  //
  //     switch (result.status) {
  //       case LoginStatus.success:
  //         final AuthCredential facebookCredential =
  //         FacebookAuthProvider.credential(result.accessToken!.token);
  //         final userCredential =
  //         await _auth.signInWithCredential(facebookCredential);
  //         print("FaceBook Login -->>>$userCredential");
  //         return Resource(status: Status.Success);
  //       case LoginStatus.cancelled:
  //         return Resource(status: Status.Cancelled);
  //       case LoginStatus.failed:
  //         return Resource(status: Status.Error);
  //       default:
  //         return null;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     throw e;
  //   }
  // }

}

