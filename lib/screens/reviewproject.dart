import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hes_pm/model/project.dart';
import 'package:hes_pm/shared/size_config.dart';
import 'package:hes_pm/widgets/mybutton.dart';
import 'package:hes_pm/widgets/singletask.dart';
import 'package:intl/intl.dart';

import '../model/task.dart';

class ReviewProject extends StatefulWidget {
  const ReviewProject({Key? key, required this.project}) : super(key: key);
  final Project project;

  @override
  State<ReviewProject> createState() => _ReviewProjectState();
}

class _ReviewProjectState extends State<ReviewProject> {

  @override
  Widget build(BuildContext context) {
    double getDays(Project project) {
      double days=0;
      project.tasks.forEach((element){days=days+element.days;});
      return days;
      
    }


    return Scaffold(
      appBar: AppBar(
        title: Text("Review Project", style: TextStyle(color: Colors.black)),
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
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: getHeight(100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${widget.project.name}"),
              Text("Location: ${widget.project.location}"),
              Text(
                  "Start Date: ${DateFormat.yMMMd().format(widget.project.startDate)}"),
              Text(
                  "Due Date: ${DateFormat.yMMMd().format(widget.project.dueDate)}"),
              Text("Labor Days: ${getDays(widget.project).toString()}"),
              Text(
                "Tasks",
                style: TextStyle(fontSize: 18, decoration: TextDecoration.underline),
              ),
              SingleTask(taskList: widget.project.tasks),

              Row(
                  mainAxisAlignment:MainAxisAlignment.center,children:[Container(width: getWidth(80),
                child: MyButton(name: "Add Project", onPressed: (){
                  FirebaseFirestore.instance
                        .collection("projects")
                        .add({

                    }).then((value) {
                      List<Task> taskList=widget.project.tasks.map((element) {return Task(name: element.name,days: element.days,employeeSchedule: element.employeeSchedule,index: element.index,simul: element.simul,completion: element.completion,projectId: value.id);}).toList();
                      Project project = Project(id:value.id,days: getDays(widget.project), tasks: taskList, location: widget.project.location, startDate: widget.project.startDate, dueDate: widget.project.dueDate, name: widget.project.name);
                      FirebaseFirestore.instance.collection("projects").doc(value.id).set(
                        project.toMap()

                          );
                  });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Successful Submission')),
                    );
                  while(Navigator.canPop(context)){ // Navigator.canPop return true if can pop
                    Navigator.pop(context);
                  }
                }, width: getWidth(20)),
              )])
            ],
          ),
        ),
      ),
    );
  }
}
