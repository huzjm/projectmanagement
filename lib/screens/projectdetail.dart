import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../shared/size_config.dart';
import '../widgets/mybutton.dart';
import '../widgets/singletask.dart';
class ProjectDetail extends StatelessWidget {
  const ProjectDetail({Key? key,required this.project}) : super(key: key);
  final project;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text(project.name, style: TextStyle(color: Colors.black)),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ),body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: getHeight(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Location: ${project.location}"),
            Text(
                "Start Date: ${DateFormat.yMMMd().format(project.startDate)}"),
            Text(
                "Due Date: ${DateFormat.yMMMd().format(project.dueDate)}"),
            Text("Labor Days: ${project.days.toString()}"),
            Text(
              "Tasks",
              style: TextStyle(fontSize: 18, decoration: TextDecoration.underline),
            ),
            SingleTask(taskList: project.tasks),


          ],
        ),
      ),
    ),);
  }
}
