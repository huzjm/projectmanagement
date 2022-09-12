import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hes_pm/model/project.dart';
import 'package:hes_pm/model/task.dart';


class MainProvider with ChangeNotifier{

  List<Project> projectList = [];
  late Project project;

  Future<void> getProjectData() async {
    List<Project> newList = [];
    QuerySnapshot orderSnapshot =
    await FirebaseFirestore.instance.collection("projects").get();
    orderSnapshot.docs.forEach((element) {
      List<Task> taskList = element["tasks"]
          .map((e) => Task(hours: (e["hours"] as num).toDouble(), name:e["name"] ,fitter:e["fitter"] ,helper:e["helper"] ,index: (e["index"] as num).toInt(),simul: e["simul"],welding:e["welding"] ))
          .toList()
          .cast<Task>();

      project = Project(name:element["projectName"] ,hours:(element["hours"] as num).toDouble() ,tasks:taskList ,startDate:element["startDate"].toDate() ,location: element["location"],dueDate:element["dueDate"].toDate() ,
         );
      newList.add(project);
    });
    projectList = newList;

    
  }
  List<Project> get getProjectList {

    return projectList;
  }

}


