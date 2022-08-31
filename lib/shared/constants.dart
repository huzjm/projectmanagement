import 'package:flutter/material.dart';

const textInputDecoration =  InputDecoration(

    fillColor: Colors.white,
    filled: true,

    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.black54, width:2.0
      ),

    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width : 2.0)
    )
);

String truncate(String text, { length: 20, omission: '...' }) {
  if (length >= text.length) {
    return text;
  }
  return text.replaceRange(length, text.length, omission);
}
String? capitalize(String s) => (s != null && s.length > 1)
    ? s[0].toUpperCase() + s.substring(1)
    : s != null ? s.toUpperCase() : null;