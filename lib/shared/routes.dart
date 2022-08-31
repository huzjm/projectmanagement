
import 'package:flutter/widgets.dart';
import 'package:hes_pm/screens/homepage.dart';
import 'package:hes_pm/screens/login.dart';
import 'package:hes_pm/screens/signup.dart';


final Map<String, WidgetBuilder> routes = {
Login.routeName:(context)=>Login(onClickedSignUp: () {  },),
SignUp.routeName:(context)=> SignUp(onClickedSignIn: () {  },),
HomePage.routeName:(context)=>HomePage(),

};
