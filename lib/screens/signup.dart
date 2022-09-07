import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:hes_pm/screens/login.dart';
import 'package:hes_pm/shared/size_config.dart';
import 'package:hes_pm/widgets/mybutton.dart';
import 'package:hes_pm/widgets/mytextformField.dart';
import 'package:hes_pm/widgets/passwordTextform.dart';

import '../shared/firebase_auth.dart';

class SignUp extends StatefulWidget {
  final Function() onClickedSignIn;


  static var routeName="/signup";
  SignUp({required this.onClickedSignIn});
  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<FormState> _formSignUpKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _signUpKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
bool obserText = true;
final TextEditingController email = TextEditingController();

final TextEditingController password = TextEditingController();



class _SignUpState extends State<SignUp> {
  void validation() async{
    if (        email.text.isEmpty &&
        password.text.isEmpty
        ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("All Fields Are Empty"),
        ),
      );
    }  else if (email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please Try a Vaild Email"),
        ),
      );
    } else if (password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password  Is Too Short"),
        ),
      );
    } else {
      try{
        UserCredential result = await auth.createUserWithEmailAndPassword(email: email.text, password: password.text);
        FirebaseFirestore.instance.collection("User").doc(result.user!.uid).set({

          "UserID":result.user!.uid,
          "UserEmail":email,


          "Auth": "new",
        });
      } on PlatformException catch(e){
        print(e.message.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
      }
    }


  }
  Widget _buildAllTextFormField(){
    return Container(
      height: getHeight(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[


          MyTextFormField( name: "Email", icon: Icon(Icons.email,color: Colors.black26), controller: email,),

          PasswordTextField(controller: password,obserText: obserText,  onTap: () {
            setState(() {
              obserText = !obserText;
            });
          }),



        ],
      ),
    );
  }
  Widget _buildBottomPart(){
    return Container(
        height: getHeight(40),
        margin: EdgeInsets.symmetric(horizontal: getWidth(9)),
        width: double.infinity,
        child: Column(

            children: <Widget>[
              _buildAllTextFormField(),
              MyButton(name: "Register", onPressed: (){validation();}, width: getWidth(33)),

            ]));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _signUpKey,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text('Register',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 24
            )),
        actions: <Widget>[
          TextButton.icon(
              onPressed: widget.onClickedSignIn,
              //     () {
              //   Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(
              //       builder: (ctx) => Login(onClickedSignUp: () {  },),
              //     ),
              //   );
              // },
              icon: Icon(Icons.person),
              label: Text('Log In'))
        ],
      ),
      backgroundColor: Colors.blueGrey[900],
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Form(
            key: _formSignUpKey,
            child: Container(
                child: Column(children: <Widget>[


                  SizedBox(
                    height: getHeight(3),
                  ),
                  _buildBottomPart()
                ])),
          )),
    );
  }
}
