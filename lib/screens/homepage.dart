import 'package:flutter/material.dart';
import 'package:hes_pm/screens/seeprojects.dart';
import 'package:hes_pm/shared/firebase_auth.dart';
import 'package:hes_pm/shared/size_config.dart';
import 'package:hes_pm/widgets/mybutton.dart';
import 'package:provider/provider.dart';

import '../model/project.dart';
import '../provider/provider.dart';
import 'addproject.dart';
import 'gratingcalculator.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}
late MainProvider provider;
class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _homePageKey = GlobalKey<ScaffoldState>();

  Future<void> _signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) { provider = Provider.of<MainProvider>(context);
  provider.getProjectData();
  List<Project> projects = provider.projectList;
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
            }, width: getWidth(30)),
            MyButton(name: "See Projects", onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SeeProjects( projects: projects,)));}, width: getWidth(30)),
            MyButton(name: "Gratings", onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>GratingCalculator()));
            }, width: getWidth(30)),
            MyButton(name: "Logout",width: getWidth(30),
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
