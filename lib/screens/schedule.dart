import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hes_pm/screens/projectdetail.dart';
import 'package:hes_pm/shared/size_config.dart';
import 'package:hes_pm/widgets/mybutton.dart';
import 'package:intl/intl.dart';

import '../model/employee.dart';
import '../model/project.dart';

class Schedule extends StatefulWidget {
  const Schedule(
      {required this.scheduleDate,
      required this.projects,
      required this.employees});

  final DateTime scheduleDate;
  final List<Project> projects;
  final List<Employee> employees;

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  double daysBetween(DateTime from, DateTime to, double days) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);

    print((days / (to.difference(from).inHours / 24)));
    return (days / (to.difference(from).inHours / 24));
  }

  List<Project> sortProjects(List<Project> project) {
    List<Project> projects = project.where((a) => a.complete == false).toList();
    projects.sort((b, a) => daysBetween(a.startDate, a.dueDate, a.days)
        .compareTo(daysBetween(b.startDate, b.dueDate, b.days)));
    return projects;
  }
  List<Employee> sortEmployee(List<Employee> employees,DateTime scheduleDate)
  {
    List<Employee> employeeList=employees.where((i){
      bool checkTask=true;
      for (var s=0;s<i.employeeTask.length;s++){
        if(i.employeeTask[s].date.month==scheduleDate.month&&i.employeeTask[s].date.day==scheduleDate.day){
          checkTask=false;
        }
      }
      return checkTask;
    }).toList();
    employeeList.sort((b,a)=>(a.id).compareTo(b.id));
    return employeeList;
  }
  List<Project> activeProjects = [];
  List<Employee> employeeList=[];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          child: Column(
            children: [
              MyButton(
                  name: "Generate Schedule",
                  onPressed: () async {
                    List<Employee> employeeList = sortEmployee(widget.employees,widget.scheduleDate);

                    setState(() {
                      activeProjects = sortProjects(widget.projects);
                    });
                    int projectLength = activeProjects.length;

                    for (var k = 0; k < 5; k++) {
                      DateTime weekDay =
                    widget.scheduleDate.add(Duration(days: k));
                      for (var i = 0; i < projectLength; i++) {

                        for (var j = 0; j < employeeList.length; j++) {
                          if (employeeList[j].location ==
                              activeProjects[i].location) {
                            Project project = activeProjects[i];

                            // await FirebaseFirestore.instance
                            //     .collection("employees")
                            //     .where('id', isEqualTo: employeeList[j].id)
                            //     .get()
                            //     .then((orderSnapshot) {
                            //   orderSnapshot.docs.forEach((element) async {
                            //     await FirebaseFirestore.instance
                            //         .collection("employees")
                            //         .doc(element.id)
                            //         .update({
                            //       "employeeTask": FieldValue.arrayUnion([
                            //         {
                            //           'hours': 1,
                            //           'date': weekDay,
                            //           'projectId': project.name,
                            //           'tasks': project.tasks[0].index,
                            //         }
                            //       ]),
                            //     });
                            //   });
                            // });
                          }
                        }
                      }
                    }
                  },
                  width: getWidth(50)),
              if(activeProjects.isNotEmpty)Container(
                height: getHeight(50),
                child: GridView.count(
                    crossAxisCount: 1,
                    childAspectRatio: 6,
                    mainAxisSpacing: 1,
                    scrollDirection: Axis.vertical,
                    children: activeProjects
                        .map((e) => ElevatedButton(
                              onPressed: () {
                                Project project = Project(
                                    complete: e.complete,
                                    days: e.days,
                                    tasks: e.tasks,
                                    location: e.location,
                                    startDate: e.startDate,
                                    dueDate: e.dueDate,
                                    name: e.name);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) =>
                                        ProjectDetail(project: project)));
                              },
                              child: Container(
                                color: Colors.lightBlueAccent,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${e.name}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              "Start: ${DateFormat.yMMMd().format(e.startDate)}"),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${e.location}"),
                                          Text(
                                              "Due: ${DateFormat.yMMMd().format(e.dueDate)}"),
                                        ],
                                      ),
                                      SizedBox(height: getHeight(1)),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
