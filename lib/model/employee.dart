import 'package:hes_pm/model/task.dart';

import 'miscellaneous.dart';

class Employee {
   String name;
   String location;
   String type;
   double salary;
   double id;
   List <Comments> comments;
   List<EmployeeTask> employeeTask;

  Employee(
      {required this.id, required this.name, required this.employeeTask, required this.location, required this.type, required this.salary, required this.comments,});

  Employee.fromJson(parsedJson)
      :id=(parsedJson['id']as num).toDouble(),
        name=parsedJson['name'],
        location=parsedJson['location'],
        type=parsedJson['type'],
        salary=(parsedJson['salary'] as num).toDouble(),
        comments = parsedJson['comments'].map((c)=>Comments.fromJson(c)).toList().cast<Comments>(),
  employeeTask= parsedJson['employeeTask'].map((c)=>EmployeeTask.fromJason(c)).toList().cast<EmployeeTask>()

  ;
  Employee.init({this.name="",this.location="",this.type="",this.salary=0,this.id=0,List<Comments>? commentsInit,List<EmployeeTask>? tasksInit}):this.comments=commentsInit??[Comments.init()],this.employeeTask=tasksInit??[EmployeeTask.init()];

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "location": location,
      "type": type,
      "salary": salary,
      "id": id,
      "employeeTask": [EmployeeTask.init().toMap()],
      "comments": [Comments.init().toMap()]
    };
  }

}