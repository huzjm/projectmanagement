import 'package:flutter/material.dart';
import 'package:hes_pm/shared/constants.dart';

class PasswordTextField extends StatelessWidget {
  final bool obserText;
  final TextEditingController controller;


  final void Function() onTap;

  PasswordTextField({required this.controller,required this.obserText, required this.onTap});

  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obserText,
      controller: controller,
      decoration: textInputDecoration.copyWith(
          hintText: "Password",
          prefixIcon: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Icon(Icons.vpn_key,color: Colors.black26),
          ),
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(
              obserText == true ? Icons.visibility : Icons.visibility_off,
              color: Colors.black54,
            ),
          )),
    );
  }
}
