import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {

  final TextEditingController? controller;
  final String? hint;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validatorOnTap;
  final GestureTapCallback? onChangedOnTap;

  const CommonTextField({Key? key, this.controller, this.hint, this.suffixIcon, this.obscureText, this.textInputType, this.textInputAction, this.validatorOnTap, this.onChangedOnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onChangedOnTap,
      validator: validatorOnTap,
      controller: controller,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      obscureText: obscureText ?? false,
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
