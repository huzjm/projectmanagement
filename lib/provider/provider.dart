import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hes_pm/model/employee.dart';
import 'package:hes_pm/model/miscellaneous.dart';
import 'package:hes_pm/model/project.dart';
import 'package:hes_pm/model/task.dart';

class MainProvider with ChangeNotifier {
  List<Employee> employeeList = [];
  late Employee employee;
  List<Project> projectList = [];
  late Project project;
  late double employeeID;
  late DateTime scheduleDate;



  Future<void> getProjectData() async {
    List<Project> newList = [];
    QuerySnapshot orderSnapshot =
    await FirebaseFirestore.instance.collection("projects").get();
    orderSnapshot.docs.forEach((element) {

      project = Project.fromJson(element


      );
      newList.add(project);
    });
    projectList = newList;
    notifyListeners();
  }

  List<Project> get getProjectList {
    return projectList;
  }
   Stream<QuerySnapshot> employeesStream =
  FirebaseFirestore.instance.collection("employees").snapshots().asBroadcastStream();
   Stream<QuerySnapshot> projectsStream = FirebaseFirestore.instance.collection("projects").snapshots().asBroadcastStream();

  Future<void> getMiscellaneous() async {
    final miscSnapshot = await FirebaseFirestore.instance
        .collection("misc")
        .doc("rTval59GjklHCLKLjao0")
        .get();
    employeeID = (miscSnapshot['IDcount'] as num).toDouble();
    scheduleDate = miscSnapshot['scheduleDate'].toDate();

    notifyListeners();
  }

  double get getID {
    return employeeID;
  }

  DateTime get getScheduleDate {
    return scheduleDate;
  }

  Future<void> getEmployeeData() async {
    List<Employee> newList = [];
    QuerySnapshot orderSnapshot =
    await FirebaseFirestore.instance.collection("employees").get();
    orderSnapshot.docs.forEach((element) {


      employee = Employee.fromJson(element
          );
      newList.add(employee);
    });
    employeeList = newList;
    notifyListeners();
  }

  List<Employee> get getEmployeeList {
    return employeeList;
  }
}
