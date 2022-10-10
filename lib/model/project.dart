import 'package:hes_pm/model/task.dart';

class Project {
  final String name;
  final DateTime startDate;
  final DateTime dueDate;
  final String location;
  double days;
  List<Task> tasks;
   bool complete;
final String id;

  Project(
      {this.id="",this.complete = false,
      required this.days,
      required this.tasks,
      required this.location,
      required this.startDate,
      required this.dueDate,
      required this.name});

  Project.fromJson(parsedJson)
      : name = parsedJson['name'],
  id =parsedJson['id'],
        startDate = parsedJson['startDate'].toDate(),
        dueDate = parsedJson['dueDate'].toDate(),
        location = parsedJson['location'],
        days = (parsedJson['days']as num).toDouble(),
       tasks = parsedJson['tasks'].map((e)=>Task.fromJson(e)).toList().cast<Task>(),
   complete=parsedJson['complete'];

  Map<String,dynamic> toMap(){
    return{
      "projectId":id,
      "name": name,
      "startDate":startDate,
      "dueDate": dueDate,
      "location": location,
      "days": days,
      "complete": complete,
      "tasks": tasks
          .map((c) =>
        c.toMap()
      )
          .toList(),

    };
  }

}
