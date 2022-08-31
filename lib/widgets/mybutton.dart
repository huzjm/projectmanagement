import 'package:flutter/material.dart';
import 'package:hes_pm/shared/size_config.dart';
class MyButton extends StatelessWidget {
  final void Function() onPressed;
  final String name;
  final width;
  MyButton({required this.name, required this.onPressed,required this.width});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(6.034),
      width: width,

      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue),
          onPressed: onPressed,
          child: Text(name,
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold

              ))),
    );
  }
}
