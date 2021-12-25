import 'package:flutter/material.dart';

String? emailValidation(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty) {
    return 'Enter email address';
  }
  else if (!regex.hasMatch(value)) {
    return 'Enter valid email address';
  }
  else {
    return null;
  }
}

String? validatePrefDate(String value, BuildContext context,String dateOfBirth ,bool? isAdult ) {
  // ignore: avoid_print
  print("isAdult -->>> $isAdult");
  if (dateOfBirth.isEmpty) {
    return "Enter DoB";
  }
  else {
    if(isAdult == false){
    return "Age Must Be 18";
  }
  else {
    return null;
  }
  }
}

String? passwordValidation(String? value,String? text) {
  if (value == null || value.isEmpty) {
    return 'Enter PassWord';
  } else if (text!.length <= 5) {
    return 'min 6 character PassWord';
  }
  else {
    return null;
  }
}

confirmPassWordValidation
      (String? value,String? text,String textMatch) {
    if (value == null || value.isEmpty) {
      return 'Enter Confirm PassWord';
    } else if (text !=
        textMatch) {
      return 'Confirm Password not Match';
    } else if (textMatch.length <= 5) {
      return 'min 6 character PassWord';
    } else {
      return null;
    }
}


checkPassWordValidation
    (String? value,String? text,String textMatch) {
  if (value == null || value.isEmpty) {
    return 'Enter Your PassWord';
  } else if (text !=
      textMatch) {
    return 'Incorrect Password';
  } else if (textMatch.length <= 5) {
    return 'Incorrect Password';
  } else {
    return null;
  }
}

String? loginEmailValidation(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty) {
    return 'Enter email address';
  }
  else if (!regex.hasMatch(value)) {
    return 'Enter valid email address';
  }
  else {
    return null;
  }
}


String? loginPasswordValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter PassWord';
  } else if (value.length <= 5) {
   // return 'Min 6 character PassWord';
    return 'Incorrect Password';
  }
  else {
    return null;
  }
}
