import 'package:hes_pm/model/task.dart';

class Project{
  final String name;
  final DateTime startDate;
  final DateTime dueDate;
  final String location;
  final hours;
  final List<Task> tasks;






  Project( {required this.hours,required this.tasks,required this.location, required this.startDate,required this.dueDate,required this.name});

}