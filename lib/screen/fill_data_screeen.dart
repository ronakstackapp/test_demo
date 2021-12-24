// ignore_for_file: avoid_print, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_demo/common_widget.dart';
import 'package:test_demo/model/usermodel.dart';
import 'package:test_demo/validation/validation_screen.dart';

import 'home_screen.dart';

class FillDataScreen extends StatefulWidget {
  final UserModel? userModel;
  final int? index;
  const FillDataScreen({Key? key, this.userModel, this.index}) : super(key: key);

  @override
  _FillDataScreenState createState() => _FillDataScreenState();
}

List<UserModel> userModelList = [];

class _FillDataScreenState extends State<FillDataScreen> {
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
  DateTime? picked;

  @override
  void initState() {
    // TODO: implement initState
    if(widget.userModel != null){
      nameController.text = widget.userModel!.name!;
      emailController.text = widget.userModel!.email!;
      dobController.text = "${widget.userModel!.dob?? DateTime.now()}";
     // selectedDate = widget.userModel!.dob??DateTime.now();
      passwordController.text = widget.userModel!.password!;
      confirmPasswordController.text = widget.userModel!.password!;
      print("picked --->>$picked");
      print("picked --->>${widget.index}");
    }

    super.initState();
  }

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
                color: const Color(0xFF81d7ff)),
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
                          }
                          // suffixIcon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 6),
                      child: CommonTextField(
                        controller: emailController,
                        hint: "Enter Your Email",
                        validatorOnTap: (value) => emailValidation(value),
                        // suffixIcon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 6),
                      child: CommonTextField(
                        controller: dobController,
                        hint: "Date of Birth",
                        onChangedOnTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            _selectDate(context);
                          });
                        },
                        // suffixIcon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                        validatorOnTap: (value) =>
                            validatePrefDate(value!, context,selectedDate,isAdult),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 6),
                      child: CommonTextField(
                        controller: passwordController,
                        hint: "Enter Password",
                        obscureText: password ? false : true,
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
                        obscureText: confirmPassword ? false : true,
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
                      buttonText: widget.userModel == null?"Register":"Update",
                      pressedButton: () {
                        FocusScope.of(context).requestFocus(FocusNode());

                        // ///
                        // print("${DateTime.now().year - selectedDate!.year > 18}");

                        UserModel userModel = UserModel(
                            name: nameController.text,
                            email: emailController.text,
                            dob: dobController.text,
                            password: passwordController.text,
                        );

                        if (_key.currentState!.validate()) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if(widget.userModel == null){
                            userModelList.add(userModel);
                          }else{
                            userModelList.removeAt(widget.index!);
                            userModelList.insert(widget.index!, userModel);
                          }
                          widget.userModel == null;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const HomeScreen(selectedPage: 2);
                              }));

                          // ignore: avoid_print
                          print("userModelList -->>${userModelList.length}");
                          print("userModelList -->>${userModelList[0].email}");

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
    final picked = await showDatePicker(
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
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dobController.text = DateFormat('dd/MM/yyyy').format(picked);

        if(DateTime.now().year - selectedDate!.year > 18){
          print("adult");
          isAdult = true;
        }else{
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
