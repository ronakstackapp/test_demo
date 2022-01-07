// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:test_demo/facebook_login/model.dart';
import 'package:test_demo/file_picker_demo/file_picker_demo.dart';
import 'package:test_demo/firebase_storage/second_firebase_img_upload.dart';
import 'package:test_demo/local_notification/local_notification_with_all_method/local_notification_screen.dart';
import 'package:test_demo/model/usermodel.dart';
import 'package:test_demo/multi_img_storage/multi_img.dart';
import 'package:test_demo/notification/firebase_notification_screen.dart';
import 'package:test_demo/notification/method_notification_screen.dart';
import 'package:test_demo/phoneverification/phone_verification_screen.dart';

// ignore: unused_import
import 'package:test_demo/screen/home_screen.dart';
import 'package:test_demo/validation/validation_screen.dart';
import '../common_widget.dart';
import 'auth_screen.dart';
import 'login_user_data.dart';

String email = "";
String yourPassword = "";

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
  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  bool isLoggedIn = false;

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    showMessage();
    // TODO: implement initState
    userName = "";

    if ((email != "" && yourPassword != "")) {
      emailController.text = email;
      passwordController.text = yourPassword;
    }

    if (widget.userModel != null) {
      print("FirebaseRegisterScreen --> initState --> userModel!=null ");
    }
    super.initState();
  }

  showMessage() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications(context);

    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
  }

  _changeData(String msg) {
    if (!mounted) return;
    setState(() => notificationData = msg);
  }

  _changeBody(String msg) {
    if (!mounted) return;
    setState(() => notificationBody = msg);
  }

  _changeTitle(String msg) {
    if (!mounted) return;
    setState(() => notificationTitle = msg);
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
                                validatorOnTap: (value) =>
                                    loginEmailValidation(value),
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
                              pressedButton: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());

                                if (_key.currentState!.validate()) {
                                  try {
                                    final newUser = await _auth
                                        .createUserWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text);

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
                    userData =
                        await Authentication.signInWithGoogle(context: context);
                    if (userData != null) {
                      setState(() {});
                    }
                  },
                ),
                if (userData != null)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return LoginUserScreen(user: userData!);
                          }));
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
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const LoginWithPhone();
                }));
              },
              child: const Text("PhoneNumber Verification")),
          SignInButton(Buttons.Facebook, mini: true, onPressed: () {
            //initiateFacebookLogin();
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    FireBaseModel.onTapFacebookLogin();
                  },
                  child: const Text("FaceBook Login")),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return FilePickerDemo();
                    }));
                  },
                  child: const Text("File Picker"))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { return const ImageUpload(); }));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return UploadingImageToFirebaseStorage();
                    }));
                  },
                  child: const Text("Img Upload")),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return UploadMultipleImageDemo();
                    }));
                  },
                  child: const Text("Multi Img Upload"))
            ],
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return notificationScreen(
                    notificationBody: notificationBody,
                    notificationData: notificationData,
                    notificationTitle: notificationTitle,
                  );
                }));
              },
              child: const Text("Firebase Notification Screen")),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return LocalNotifications(title: "Local Notification....",);
                }));
              },
              child: const Text("Local Notification Screen"))
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
