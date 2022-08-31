import 'package:flutter/material.dart';
import 'package:hes_pm/shared/constants.dart';
class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
final String name;

final Icon icon;

MyTextFormField({required this.controller,required this.name, required this.icon});
  @override
  Widget build(BuildContext context) {
    return TextFormField(

    controller: controller,
      decoration: textInputDecoration.copyWith(
          hintText: name,prefixIcon: GestureDetector(
        onTap: (){FocusScope.of(context).unfocus();},
        child: icon,
      ),

    ));
  }
}
