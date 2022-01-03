// ignore_for_file: avoid_print, duplicate_ignore



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:test_demo/common_widget.dart';
import 'package:test_demo/firebase_demo/database_screen.dart';
import 'package:test_demo/firebase_demo/firebase_pageview_home_screen.dart';
import 'package:test_demo/model/usermodel.dart';
import 'package:test_demo/screen/pageview_home_screen.dart';
import 'package:test_demo/validation/validation_screen.dart';

UserModel? userModelg;
int? indexg;
bool isUpdate = false;
String? id;

class FirebaseFillDataScreen extends StatefulWidget {
  const FirebaseFillDataScreen({Key? key}) : super(key: key);

  // final UserModel? userModel;
  // final int? listIndex;
  //
  // const FirebaseFillDataScreen({Key? key, this.userModel, this.listIndex})
  //     : super(key: key);

  @override
  _FirebaseFillDataScreenState createState() => _FirebaseFillDataScreenState();
}

List<UserModel> userModelList = [];

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('UserData');

class _FirebaseFillDataScreenState extends State<FirebaseFillDataScreen> {
  //final _key = GlobalKey<FormState>();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  DateTime? selectedDate;
  bool confirmPassword = true;
  bool password = true;
  bool isAdult = false;

  // DateTime? picked;

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    // TODO: implement initState

    print("isUpdate --------------****** $isUpdate");


    if (userModelg != null) {
      print("aaaaaa");
      nameController.text = userModelg!.name!;
      emailController.text = userModelg!.email!;
      dobController.text = userModelg!.dob!;
    //  dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
      passwordController.text = userModelg!.password!;
      confirmPasswordController.text = userModelg!.password!;
      print("picked --->> DoB${userModelg!.dob}");
print("**********${dobController.text.split('/').last}");

      if (DateTime.now().year - int.parse(dobController.text.split('/').last) > 18) {
        print("adult");
        isAdult = true;
      } else {
        isAdult = false;
      }
    }
    super.initState();
  }

  // @override
  // void dispose() {
  //   tabController!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Container(
            height: 380,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xff81ff9c)),
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 6),
                      child: CommonTextField(
                          controller: nameController,
                          textInputType: TextInputType.name,
                          hint: "Enter Your Name",
                          validatorOnTap: (String? value) {
                            //   String Patten2 = r"^[a-zA-Z_ ]{6,}*$";
                            RegExp regex = RegExp(r'^[a-zA-Z]+$');
                            if (value == null || value.isEmpty) {
                              return 'Enter User Name';
                            } else if (!regex.hasMatch(value)) {
                              return 'Only Alphabet Allow';
                            } else {
                              return null;
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 6),
                      child: CommonTextField(
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        hint: "Enter Your Email",
                        validatorOnTap: (value) => emailValidation(value),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 6),
                      child: CommonTextField(
                        readOnly: true,
                        controller: dobController,
                        hint: "Date of Birth",
                        onChangedOnTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            _selectDate(context);
                          });
                        },
                        validatorOnTap: (value) => validatePrefDate(
                            value!, context, dobController.text, isAdult),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 6),
                      child: CommonTextField(
                        controller: passwordController,
                        hint: "Enter Password",
                        obscureText: !password ? false : true,
                        // inputFormatters: [
                        //    FilteringTextInputFormatter.digitsOnly,
                        //    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        //    //LengthLimitingTextInputFormatter(10),
                        //    ],
                        validatorOnTap: (value) =>
                            passwordValidation(value, passwordController.text),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 6),
                      child: CommonTextField(
                        controller: confirmPasswordController,
                        hint: "Enter Confirm Password",
                        obscureText: !confirmPassword ? false : true,
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                confirmPassword = !confirmPassword;
                              });
                            },
                            child: confirmPassword
                                ? const Icon(Icons.remove_red_eye,
                                color: Colors.blue)
                                : const Icon(CupertinoIcons.eye_slash,
                                color: Colors.blue)),
                        validatorOnTap: (value) => confirmPassWordValidation(
                            value,
                            passwordController.text,
                            confirmPasswordController.text),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Button(
                      buttonText:
                      isUpdate ? "Update" : "Register",
                      pressedButton: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        // UserModel userModel = UserModel(
                        //   name: nameController.text,
                        //   email: emailController.text,
                        //   dob: selectedDate,
                        //   password: passwordController.text,
                        // );

                        Map<String,dynamic> userData ={
                          "name": nameController.text,
                          "email": emailController.text,
                          "dob": dobController.text,
                          "password": passwordController.text,
                        };

                        if (_key.currentState!.validate()) {

                          FocusScope.of(context).requestFocus(FocusNode());

                          if(isUpdate){
                            Database.updateItem(data:userData,docId: id);
                            Future.delayed(const Duration(milliseconds: 700),(){
                              isUpdate = false;
                            });

                          }else{
                            Database.addItem(data: userData);
                          }

                          // if (userModelg == null) {
                          //   userModelList.add(userModel);
                          // } else {
                          //   userModelList.removeAt(indexg!);
                          //   userModelList.insert(indexg!, userModel);
                          // }

                          // tabController!.index = 2;

                          ///tabbar
                          //  tabController!.animateTo(2,duration: const Duration(milliseconds: 1000),curve: Curves.easeInCirc);


                          ///pageView
                          pageController!.animateToPage(
                              2, duration: const Duration(milliseconds: 1000),
                              curve: Curves.ease);
                          Future.delayed( const Duration(milliseconds: 500),(){
                            counter.value = 2;
                          });


                          ///navigator
                          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          //  const  HomeScreen(selectedPage: 2)), (Route<dynamic> route) => false);

                          // ignore: avoid_print
                          // print("userModelList -->>${userModelList.length}");
                          // print("userModelList -->>${userModelList[0].email}");

                          Future.delayed(const Duration(milliseconds: 1000),(){
                            return  userModelg = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
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

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800, 8),
      lastDate: DateTime(2101),
      // builder: (BuildContext context, Widget? child) {
      //   return Theme(
      //     data: ThemeData.light().copyWith(
      //       colorScheme: const ColorScheme.light(
      //         primary: Colors.blue,
      //         onSurface: Colors.grey,
      //       ),
      //       dialogBackgroundColor: Colors.white,
      //     ),
      //     child: child!,
      //   );
      // },
    );
    print("picked 00-->>$picked");
    if (picked != null && picked != selectedDate) {
      print("picked 01-->>$picked");
      setState(() {
        selectedDate = picked;
        dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate!);

        // print('selecteddATE --> ${selectedDate}');

        if (DateTime.now().year - selectedDate!.year > 18) {
          print("adult");
          isAdult = true;
        } else {
          isAdult = false;
        }
      });
    }
  }

// _buttonOnTab() {
//   if (_key.currentState!.validate()) {
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (BuildContext context) {
//       return  ShowDataScreen();
//     }));
//   }
// }




}
