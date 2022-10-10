import 'package:flutter/material.dart';
import 'package:hes_pm/model/employee.dart';
import 'package:hes_pm/model/miscellaneous.dart';
import 'package:hes_pm/screens/addemployee.dart';
import 'package:hes_pm/screens/schedule.dart';
import 'package:hes_pm/screens/seeprojects.dart';
import 'package:hes_pm/screens/testschedule.dart';

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
  Future<List<Project>> _getProjects() async {

    await provider.getProjectData();
    return provider.projectList;

  }

  Future<DateTime> _getScheduleDate()async{
    await provider.getMiscellaneous();
    return provider.getScheduleDate;
  }

  Future<double> _getID()async{

    await provider.getMiscellaneous();
    return provider.getID;

  }
  Future<List<Employee>> _getEmployeeList()async{

    await provider.getEmployeeData();
    return provider.getEmployeeList;

  }


  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MainProvider>(context);


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

            MyButton(
                name: "Add Project",
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => AddProject()));
                },
                width: getWidth(30)),
            MyButton(
                name: "See Projects",
                onPressed: () async{
                  List<Project> projects = await _getProjects() ;

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => SeeProjects(
                            projects: projects,
                          )));
                },
                width: getWidth(30)),
            MyButton(
                name: "Add Employee",
                onPressed: () async{
                  double employeeID = await _getID() ;


                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => AddEmployee(
                        id:employeeID,

                      )));
                },
                width: getWidth(30)),
            MyButton(name: "Test Schedule", onPressed: ()async{
              DateTime scheduleDate= await _getScheduleDate();
              double employeeID = await _getID() ;
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>TestSchedule(scheduleDate:scheduleDate)));
            }, width: getWidth(30)),
            MyButton(
                name: "Schedule",
                onPressed: () async{
                  List<Project> projects = await _getProjects() ;
                  List<Employee> employees= await _getEmployeeList();
                  DateTime scheduleDate= await _getScheduleDate();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => Schedule(  projects: projects, employees:employees, scheduleDate: scheduleDate
                      )));
                },
                width: getWidth(30)),
            MyButton(
                name: "Gratings",
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => GratingCalculator()));
                },
                width: getWidth(30)),
            MyButton(
              name: "Logout",
              width: getWidth(30),
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
