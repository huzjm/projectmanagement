import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hes_pm/model/project.dart';
import 'package:hes_pm/shared/size_config.dart';
import 'package:hes_pm/widgets/mybutton.dart';
import 'package:hes_pm/widgets/singletask.dart';
import 'package:intl/intl.dart';

class ReviewProject extends StatefulWidget {
  const ReviewProject({Key? key, required this.project}) : super(key: key);
  final Project project;

  @override
  State<ReviewProject> createState() => _ReviewProjectState();
}

class _ReviewProjectState extends State<ReviewProject> {

  @override
  Widget build(BuildContext context) {
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
              Text(
                "Tasks",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
              SingleTask(taskList: widget.project.tasks),

              MyButton(name: "Add Project", onPressed: (){
                FirebaseFirestore.instance
                      .collection("projects")
                      .add({
                    "projectName": widget.project.name,
                    "startDate": widget.project.startDate,
                    "dueDate": widget.project.dueDate,
                    "location": widget.project.location,
                    "hours": widget.project.hours,
                    "tasks": widget.project.tasks
                        .map((c) => {
                              "hours": c.hours,
                              "welding": c.welding,
                              "helper": c.helper,
                              "fitter": c.fitter,
                              "simul": c.simul,
                              "name": c.name,
                            })
                        .toList(),
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Successful Submission')),
                  );
                while(Navigator.canPop(context)){ // Navigator.canPop return true if can pop
                  Navigator.pop(context);
                }
              }, width: getWidth(20))
            ],
          ),
        ),
      ),
    );
  }
}
