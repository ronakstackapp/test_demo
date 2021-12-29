import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'screen/array_data_screen/pageview_home_screen.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? readOnly;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validatorOnTap;
  final GestureTapCallback? onChangedOnTap;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextField(
      {Key? key,
      this.controller,
      this.hint,
      this.suffixIcon,
      this.obscureText,
      this.textInputType,
      this.textInputAction,
      this.validatorOnTap,
      this.onChangedOnTap,
      this.inputFormatters, this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly??false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: onChangedOnTap,
      validator: validatorOnTap,
      controller: controller,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      obscureText: obscureText ?? false,
      cursorColor: Colors.transparent,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.buttonText,
    this.pressedButton,
  }) : super(key: key);

  final String? buttonText;
  final VoidCallback? pressedButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: pressedButton,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Text(
            buttonText ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ));
  }
}


class TabWidget extends StatelessWidget {
  const TabWidget({
    Key? key, this.inkWellTap, this.intColor, this.iconWidget,
  }) : super(key: key);

  final GestureTapCallback? inkWellTap;
  final int? intColor;
  final Widget? iconWidget;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          InkWell(
            onTap: inkWellTap,
            child:  SizedBox(
              width: double.infinity,
              height: 45,
              child:iconWidget
            ),
          ),
          ValueListenableBuilder(
            valueListenable: counter,
            builder:
                (BuildContext context, int value, Widget? child) {
              return Container(
                width: double.infinity,
                height: 2,
                decoration: BoxDecoration(
                    color: value == intColor ? Colors.white : Colors.blue,
                    borderRadius: BorderRadius.circular(4)),
              );
            },
            // child: Container(width: double.infinity,height: 2,decoration: BoxDecoration(
            //     color: tabInt == 2?Colors.white : Colors.blue,
            //     borderRadius: BorderRadius.circular(4)),),
          ),
        ],
      ),
    );
  }
}
