import 'package:flutter/material.dart';
import 'package:hes_pm/shared/firebase_auth.dart';
import 'package:hes_pm/shared/size_config.dart';
import 'package:hes_pm/widgets/mybutton.dart';

import 'addproject.dart';

class HomePage extends StatefulWidget {
  static var routeName = "/homepage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _homePageKey = GlobalKey<ScaffoldState>();

  Future<void> _signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.black),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                // showSearch(context: context, delegate: SearchProduct());
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
              )),
        ],
      ),
      key: _homePageKey,
      body: Container(

        height: getHeight(100),
        width: getWidth(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,


          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MyButton(name: "Add Project", onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AddProject()));
            }, width: getWidth(20)),
            MyButton(name: "Logout",width: getWidth(20),
              onPressed: () {
                _signOut();
              },
              
            ),
          ],
        ),
      ),
    );
  }
}
