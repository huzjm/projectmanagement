import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hes_pm/shared/constants.dart';

import '../shared/size_config.dart';
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



class NumberTextField extends StatelessWidget {

  const NumberTextField({required this.obserIcon,required this.labelText,required this.controller,this.icon=
    Icons.timelapse_outlined,

  });



  final TextEditingController controller;
  final String labelText;
  final  icon;
  final bool obserIcon;


  @override
  Widget build(BuildContext context) {
    return TextFormField(


      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,2}')),
      ],
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.lightBlue, width: 1),
          ),
          border: const OutlineInputBorder(),
          icon: obserIcon==true?icon:null,

          labelText: labelText),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a number';
        }
        return null;
      },
    );
  }
}




