// // ignore_for_file: avoid_print
//
// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:test_demo/model/usermodel.dart';
//
//
// import '../common_widget.dart';
// import 'firebase_pageview_home_screen.dart';
//
//
// String email = "";
// String yourPassword = "";
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({Key? key, this.userModel}) : super(key: key);
//   final UserModel? userModel;
//
//   @override
//   RegisterScreenState createState() => RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   bool password = true;
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//   String? userName;
//
//   bool checkEmail = false;
//   bool checkPasswords = false;
//
//   String? checkPassword;
//
//   List<dynamic> list = [];
//
//   Future<bool> readEmailItems(String controller) async {
//     var matchEmail = await FirebaseFirestore.instance
//         .collection('notes')
//         .where('email', isEqualTo: controller)
//         .get();
//
//     if (matchEmail.docs.map((e) => e["password"]).isEmpty) {
//       checkEmail = false;
//     } else {
//       checkEmail = true;
//     }
//
//     print("matchEmail == ${matchEmail.docs.map((e) => e["email"])}");
//
//     return checkEmail;
//   }
//
//   Future<bool> readItems(
//       String emailController, String passwordController) async {
//     var matchData = await FirebaseFirestore.instance
//         .collection('notes')
//         .where('email', isEqualTo: emailController)
//         .where('password', isEqualTo: passwordController)
//         .get();
//
//     if (matchData.docs.map((e) => e["email"]).isEmpty &&
//         matchData.docs.map((e) => e['password']).isEmpty) {
//       checkEmail = false;
//       checkPasswords = false;
//     } else {
//       checkEmail = true;
//       checkPasswords = true;
//     }
//
//     List<QueryDocumentSnapshot<Map<String, dynamic>>> data = matchData.docs;
//     for (var element in data) {
//       userName = element['name'];
//     }
//
//     return checkPasswords;
//   }
//
//   Future<bool> readUsername(String controller) async {
//     var matchPassword = await FirebaseFirestore.instance
//         .collection('notes')
//         .where('password', isEqualTo: controller)
//         .get();
//
//     print("matchPassword == ${matchPassword.docs.map((e) => e["password"])}");
//
//     return checkPasswords;
//   }
//
//   @override
//   void initState() {
//     FocusManager.instance.primaryFocus?.unfocus();
//     // TODO: implement initState
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//           child: Container(
//             height: 220,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: const Color(0xFF81d7ff)),
//             child: SingleChildScrollView(
//               child: Form(
//                 key: _key,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 15, vertical: 10),
//                       child: CommonTextField(
//                         textInputType: TextInputType.emailAddress,
//                         validatorOnTap: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Enter Your Email';
//                           } else {
//                             return null;
//                           }
//                         },
//                         controller: emailController,
//                         hint: "Enter Your Email",
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 15, vertical: 10),
//                       child: CommonTextField(
//                         controller: passwordController,
//                         hint: "Enter Your Password",
//                         obscureText: !password ? false : true,
//                         // textInputType: TextInputType.phone,
//                         validatorOnTap: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Enter Your Password';
//                           } else if (value.length <= 5) {
//                             return 'Min 6 character PassWord';
//                             // return 'Incorrect Email';
//                           } else {
//                             return null;
//                           }
//
//                           //   else if(checkEmial == false){
//                           //     return "hdfjds";
//                           // }
//                         },
//                         suffixIcon: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 password = !password;
//                               });
//                             },
//                             child:
//                             // password
//                             //     ? const Icon(Icons.remove_red_eye,
//                             //         color: Colors.blue)
//                             //
//                             //   :
//                             Icon(Icons.remove_red_eye,
//                                 color: password
//                                     ? Colors.blue[400]
//                                     : Colors.blue)),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Button(
//                         buttonText: "Login",
//
//                         // pressedButton: () async {
//                         //   if (_key.currentState!.validate()) {
//                         //
//                         //     // var checkEmails = await dbHelper.checkEmail(
//                         //     //     email: emailController.text);
//                         //     //
//                         //     // if (checkEmails.isEmpty) {
//                         //     //   checkEmail =true;
//                         //     //   ScaffoldMessenger.of(context)
//                         //     //       .showSnackBar(const SnackBar(
//                         //     //     content: Text(
//                         //     //       "Incorrect Email address",
//                         //     //       style: TextStyle(color: Colors.white),
//                         //     //     ),
//                         //     //     backgroundColor: Colors.red,
//                         //     //   ));
//                         //     // } else {}
//                         //     //
//                         //     // var checkPassword = await dbHelper.checkPassword(
//                         //     //     password: passwordController.text);
//                         //     //
//                         //     // if (checkPassword.isEmpty) {
//                         //     //   checkPasswords = true;
//                         //     //   ScaffoldMessenger.of(context)
//                         //     //       .showSnackBar(const SnackBar(
//                         //     //     content: Text(
//                         //     //       "Incorrect password",
//                         //     //       style: TextStyle(color: Colors.white),
//                         //     //     ),
//                         //     //     backgroundColor: Colors.red,
//                         //     //   ));
//                         //     // } else {}
//                         //     //
//                         //     //
//                         //     //
//                         //     //   var data = await dbHelper.getEmail(
//                         //     //       email: emailController.text,
//                         //     //       password: passwordController.text);
//                         //     //   print("data ==> $data");
//                         //     //
//                         //     //
//                         //     //
//                         //     //   if(!checkEmail && !checkPasswords){
//                         //     //     if (data.isEmpty) {
//                         //     //       ScaffoldMessenger.of(context)
//                         //     //           .showSnackBar(const SnackBar(
//                         //     //         content: Text(
//                         //     //           "Email and Password not match",
//                         //     //           style: TextStyle(color: Colors.white),
//                         //     //         ),
//                         //     //         backgroundColor: Colors.red,
//                         //     //       ));
//                         //     //     }
//                         //     //   } else{
//                         //     //     userName = data[0]['YourName'];
//                         //     //     _showDialog();
//                         //     //   }
//                         //     //
//                         //     //
//                         //
//                         //     setState(() {});
//                         //   }
//                         // },
//                         pressedButton: () async {
//                           FocusScope.of(context).requestFocus(FocusNode());
//
//                           if (_key.currentState!.validate()) {
//                             // await readEmailItems(emailController.text);
//                             //
//                             // await readPasswordItems(passwordController.text);
//
//                             await readItems(
//                                 emailController.text, passwordController.text);
//
//                             // if(checkEmail == false){
//                             //   ScaffoldMessenger.of(context)
//                             //       .showSnackBar(const SnackBar(
//                             //     content: Text(
//                             //       "Email not match",
//                             //       style: TextStyle(color: Colors.white),
//                             //     ),
//                             //     backgroundColor: Colors.red,
//                             //   ));
//                             // } else {return;}
//                             //
//                             // if(checkPasswords == false){
//                             //   ScaffoldMessenger.of(context)
//                             //       .showSnackBar(const SnackBar(
//                             //     content: Text(
//                             //       "Password not match",
//                             //       style: TextStyle(color: Colors.white),
//                             //     ),
//                             //     backgroundColor: Colors.red,
//                             //   ));
//                             // } else {
//                             //   return;
//                             // }
//
//                             if (checkEmail == true && checkPasswords == true) {
//                               _showDialog();
//                             } else {
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(const SnackBar(
//                                 content: Text(
//                                   "Email and Password not match",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 backgroundColor: Colors.red,
//                               ));
//                             }
//
//                             // readEmailItems(emailController.text).whenComplete(() {
//                             //   readPasswordItems(passwordController.text)
//                             //       .whenComplete(() {
//                             //     _showDialog();
//                             //   });
//                             // }).then((value) => SnackBar(content: Text("Fails")));
//                           }
//                         }),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _showDialog() {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("WelCome!"),
//           content: Text("Hello $userName"),
//           actions: <Widget>[
//             TextButton(
//                 onPressed: () {
//                   print("Show Dialog -->>");
//                   // yourPassword = passwordController.text;
//                   // email = emailController.text;
//                   Navigator.pop(context);
//
//                   pageController!.animateToPage(2,
//                       duration: const Duration(milliseconds: 1000),
//                       curve: Curves.ease);
//                   Future.delayed(const Duration(milliseconds: 500), () {
//                     counter.value = 2;
//                   });
//                 },
//                 child: const Text("ok"))
//           ],
//         );
//       },
//     );
//   }
// }