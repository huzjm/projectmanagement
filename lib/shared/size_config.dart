import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    print (screenWidth);
    screenHeight = _mediaQueryData.size.height-(MediaQuery.of(context).padding.top+kToolbarHeight);
    print (screenHeight);
    orientation = _mediaQueryData.orientation;
  }
}

double getHeight(double inputHeight){
  double screenHeight = SizeConfig.screenHeight/100;
  print (screenHeight*inputHeight);
  return inputHeight*screenHeight;

}

double getWidth(double inputWidth){
  double screenWidth=SizeConfig.screenWidth/100;
  print(inputWidth*screenWidth);
  return inputWidth*screenWidth;
}