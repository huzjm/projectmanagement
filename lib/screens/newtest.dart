import 'package:flutter/material.dart';
class NewTest extends StatefulWidget {
   String testString;
  NewTest({required this.testString}) ;

  @override
  State<NewTest> createState() => _NewTestState();
}

class _NewTestState extends State<NewTest> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.testString);
  }
}
