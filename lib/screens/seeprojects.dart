import 'package:flutter/material.dart';
import 'package:hes_pm/provider/provider.dart';
import 'package:hes_pm/screens/projectdetail.dart';
import 'package:hes_pm/shared/size_config.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../model/project.dart';

class SeeProjects extends StatefulWidget {
  const SeeProjects( {Key? key, required this.projects}) : super(key: key);
  final List<Project> projects;
  @override
  State<SeeProjects> createState() => _SeeProjectsState();
}



class _SeeProjectsState extends State<SeeProjects> {


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Active Projects", style: TextStyle(color: Colors.black)),
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
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: getHeight(3), horizontal: getWidth(2)),
        child: Column(
          children: [
            // Container(
            //   height: getHeight(5),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Text(
            //         "Projects",
            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //       ),
            //     ],
            //   ),
            // ),
            Container(

              height: getHeight(80),
              child: GridView.count(crossAxisCount: 1
                  ,
                  childAspectRatio: 6,
                  mainAxisSpacing: getHeight(1),
                  scrollDirection: Axis.vertical,
                  children: widget.projects.map((e)=> ElevatedButton(
                    onPressed: (){Project project = Project(hours: e.hours, tasks: e.tasks, location: e.location, startDate: e.startDate, dueDate: e.dueDate, name: e.name);
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ProjectDetail(project:project)));},
                    child: Container(
                      color: Colors.lightBlueAccent,


                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${e.name}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                Text("Start: ${DateFormat.yMMMd().format(e.startDate)}"),
                              ],
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text("${e.location}"),

                              Text("Due: ${DateFormat.yMMMd().format(e.dueDate)}"),
                            ],),
                            SizedBox(height: getHeight(1)),

                          ],
                        ),
                      ),
                    ),
                  )).toList()
              ),
            )
          ],
        ),
      ),
    );
  }
}
