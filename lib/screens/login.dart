import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hes_pm/shared/firebase_auth.dart';
import 'package:hes_pm/shared/size_config.dart';
import 'package:hes_pm/widgets/mybutton.dart';
import 'package:hes_pm/widgets/mytextformField.dart';
import 'package:hes_pm/widgets/passwordTextform.dart';
import 'package:hes_pm/screens/signup.dart';

class Login extends StatefulWidget {

  final Function() onClickedSignUp;

Login({required this.onClickedSignUp});


  @override
  _LoginState createState() => _LoginState();
}

final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _loginKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();


bool obserText = true;

class _LoginState extends State<Login> {
  void validation() async {
    if (password.text.isEmpty &&
        email.text.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Both Fields Are Empty"),
        ),
      );

    } else if (email.text.isEmpty) {
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
    }  else {
      try {
        UserCredential result = await auth
            .signInWithEmailAndPassword(email: email.text, password: password.text);
             }
      on PlatformException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message!),

          ),
        );


      }
    }




  }

  Future signIn(email,password) async{
    try{
    await auth.signInWithEmailAndPassword(email: email, password: password);}
        on FirebaseAuthException catch(e){
      print(e);
        }
  }

  Widget _buildAllPart() {

    return Container(
      height: getHeight(40),
      width: getWidth(100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MyTextFormField(
              controller: email,
              name: "Email",
              icon: Icon(Icons.email, color: Colors.black26)),
          PasswordTextField(
              controller:password,
              obserText: obserText,
              onTap: () {
                setState(() {
                  obserText = !obserText;
                });
              }),
          MyButton(
            name: "Login",
            onPressed: () async {
              validation();

            },
            width: getWidth(22),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        key: _loginKey,
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: Text('Login to HES',
              style: TextStyle(color: Colors.blue, fontSize: 24)),
          actions: <Widget>[
            TextButton.icon(

                onPressed:widget.onClickedSignUp ,
                //     () {
                //
                //   Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //       builder: (ctx) => SignUp(onClickedSignIn: () {  },),
                //     ),
                //   );
                // },
                icon: Icon(Icons.person),
                label: Text('Register'))
          ],
        ),
        backgroundColor: Colors.blueGrey[900],
        body: SafeArea(
            child: Form(
              key: _formLoginKey,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: getWidth(9), vertical: getHeight(3)),
                  child: Column(
                    children: <Widget>[
                      _buildAllPart(),
                    ],
                  )),
            )));
  }
}