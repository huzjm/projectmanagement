import 'package:flutter/material.dart';
import 'package:hes_pm/screens/signup.dart';

import 'login.dart';


class AuthPage extends StatefulWidget {


  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin=true;
  @override
  Widget build(BuildContext context) => isLogin? Login(onClickedSignUp:toggle):SignUp(onClickedSignIn:toggle);
  void toggle() =>setState(()=>isLogin=!isLogin);
}
