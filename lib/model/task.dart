class Task {
  final String name;
  double days;
  final String projectId;
   int index;
   bool completion;
   List<EmployeeTask> employeeSchedule;
  final bool simul;

  Task(
      {this.projectId="",required this.employeeSchedule,
      this.completion = false,
      required this.index,
      required this.name,
      required this.days,
      required this.simul});

  Task.fromJson(parsedJson)
      : name = parsedJson['name'],
  projectId=parsedJson['projectId'],
       days = (parsedJson['days'] as num).toDouble(),
        index = (parsedJson['index'] as num).toInt(),
        completion = parsedJson['completion'],
        employeeSchedule = parsedJson['employeeSchedule']
            .map((e) => EmployeeTask.fromJason(e))
            .toList()
            .cast<EmployeeTask>(),
        simul = parsedJson['simul'];

  Map<String, dynamic> toMap() {
    return {
      "projectId":projectId,
      "completion": completion,
      "days": days,
      "simul": simul,
      "name": name,
      "index": index,
      "employeeSchedule": employeeSchedule.map((c) => c.toMap()).toList(),
    };
  }
}

class EmployeeTask {
  final hours;
  final DateTime date;
  final String projectId;
  final String task;

  EmployeeTask.init(
      {this.hours = 0,
      DateTime? creation,
      this.projectId = "0",
      this.task = "0"})
      : this.date = creation ?? DateTime.utc(1999);

  EmployeeTask(
      {required this.hours,
      required this.date,
      required this.projectId,
      required this.task});

  EmployeeTask.fromJason(Map<String, dynamic> parsedJson)
      : hours = parsedJson['hours'],
        date = parsedJson['date'].toDate(),
        projectId = parsedJson['projectId'],
        task = parsedJson['task'];

  Map<String, dynamic> toMap() {
    return {"hours": hours, "date": date, "projectId": projectId, "task": task};
  }
}
