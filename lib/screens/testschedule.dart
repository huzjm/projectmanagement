import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hes_pm/model/employee.dart';
import 'package:hes_pm/screens/homepage.dart';
import 'package:hes_pm/widgets/mybutton.dart';

import '../model/project.dart';
import '../model/task.dart';
import '../shared/size_config.dart';

class TestSchedule extends StatefulWidget {
  final DateTime scheduleDate;
  @override
  State<TestSchedule> createState() => _TestScheduleState();
  TestSchedule({required this.scheduleDate});
}

class _TestScheduleState extends State<TestSchedule> {
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

  List<Employee> sortEmployee(List<Employee> employees, DateTime scheduleDate) {
    List<Employee> employeeList = employees.where((i) {
      bool checkTask = true;
      for (var s = 0; s < i.employeeTask.length; s++) {
        if (i.employeeTask[s].date.month == scheduleDate.month &&
            i.employeeTask[s].date.day == scheduleDate.day) {
          checkTask = false;
        }
      }
      return checkTask;
    }).toList();
    employeeList.sort((b, a) => (a.id).compareTo(b.id));
    return employeeList;
  }

  List<Project> activeProjects = [];
  List<Employee> activeEmployees = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: provider.employeesStream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> employeeSnapshot) {
          if (employeeSnapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          if (employeeSnapshot.hasError) {
            return Container();
          }
          List<Employee> employeeList = [];
          employeeSnapshot.data?.docs.forEach((element) {
            Employee employee = Employee.fromJson(element);
            employeeList.add(employee);
          });
          return StreamBuilder(
              stream: provider.projectsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> projectSnapshot) {
                if (projectSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container();
                }
                if (projectSnapshot.hasError) {
                  return Container();
                }
                List<Project> projectList = [];
                projectSnapshot.data?.docs.forEach((element) {
                  Project project = Project.fromJson(element);
                  projectList.add(project);
                });
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      "Test Schedule",
                      style: TextStyle(color: Colors.black),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  body: Column(
                    children: [
                      MyButton(
                          name: "Generate Schedule",
                          onPressed: () {
                            activeProjects = sortProjects(projectList);
                            activeEmployees = sortEmployee(employeeList, DateTime.now());
                            List<Task> taskList=[];
                            activeProjects.forEach((element) {
                              taskList=taskList+element.tasks;
                            });
                            for (var i=0;i<activeProjects.length;i++){
                            }





                            },
                          width: getWidth(30))
                    ],
                  ),
                );
              });
        });


  }
}
