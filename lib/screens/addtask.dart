import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hes_pm/model/project.dart';
import 'package:hes_pm/model/task.dart';
import 'package:hes_pm/screens/reviewproject.dart';
import 'package:hes_pm/shared/size_config.dart';
import 'package:hes_pm/widgets/mybutton.dart';
import 'package:hes_pm/widgets/mytextformField.dart';
import 'package:hes_pm/widgets/singletask.dart';

class AddTask extends StatefulWidget {
  const AddTask(
      {Key? key,
      required this.name,
      required this.startDate,
      required this.dueDate,
      required this.location,
      this.hours})
      : super(key: key);
  final String name;
  final DateTime startDate;
  final DateTime dueDate;
  final String location;
  final hours;

  @override
  State<AddTask> createState() => _AddTaskState();
}

final GlobalKey<ScaffoldState> _addTaskKey = GlobalKey<ScaffoldState>();
final GlobalKey<FormState> _formAddTaskKey = GlobalKey<FormState>();
final TextEditingController _name = TextEditingController();
bool _welding = false;
bool _helper = false;
bool _fitter = false;
bool _simul = false;

TextEditingController _hours = TextEditingController();

class _AddTaskState extends State<AddTask> {
  List<Task> taskList = [];
  int counter = 1;


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Tasks", style: TextStyle(color: Colors.black)),
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
        key: _addTaskKey,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: _formAddTaskKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          'Task: $counter',
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        )
                      ],
                    ),
                    TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.snippet_folder_outlined,
                            color: Colors.lightBlue,
                          ),
                          labelText: 'Task Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: getHeight(5),
                    ),
                    NumberTextField(controller: _hours, labelText: 'Hours'),

                    SizedBox(height: getHeight(5)),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.lightBlue),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        5.0) //                 <--- border radius here
                                    ),
                              ),
                              width: getWidth(40),
                              child: CheckboxListTile(
                                title: Text("Welding: "),
                                value: _welding,
                                onChanged: (newValue) {
                                  setState(() {
                                    _welding = newValue!;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: getWidth(40),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.lightBlue),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        5.0) //                 <--- border radius here
                                    ),
                              ),
                              child: CheckboxListTile(
                                title: Text("Helper: "),
                                value: _helper,
                                onChanged: (newValue) {
                                  setState(() {
                                    _helper = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: getWidth(40),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.lightBlue),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        5.0) //                 <--- border radius here
                                    ),
                              ),
                              child: CheckboxListTile(
                                title: Text("Fitter: "),
                                value: _fitter,
                                onChanged: (newValue) {
                                  setState(() {
                                    _fitter = newValue!;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: getWidth(50),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.lightBlue),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        5.0) //                 <--- border radius here
                                    ),
                              ),
                              child: CheckboxListTile(
                                title: Text("Simultaneous: "),
                                value: _simul,
                                onChanged: (newValue) {
                                  setState(() {
                                    _simul = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: getHeight(5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyButton(
                            name: "Add Task",
                            onPressed: () {if (_formAddTaskKey.currentState!.validate()) {
                              setState(() {
                                var task = Task(
                                    fitter: _fitter,
                                    helper: _helper,
                                    hours: double.parse(_hours.text),
                                    name: _name.text,
                                    simul: _simul,
                                    welding: _welding,
                                    index: counter-1);
                                taskList.add(task);
                                _formAddTaskKey.currentState?.reset();
                                _fitter = false;
                                _helper = false;
                                _name.clear();
                                _hours.clear();
                                _simul = false;
                                _welding = false;
                                counter++;
                              });
                            }},
                            width: getWidth(40)),
                        SizedBox(
                          width: getWidth(5),
                        ),
                        MyButton(
                          onPressed: () {if (taskList.isNotEmpty) {
                            Project project = Project(
                                hours: widget.hours,
                                tasks: taskList,
                                name: widget.name,
                                startDate: widget.startDate,
                                dueDate: widget.dueDate,
                                location: widget.location);
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ReviewProject(project:project)));}
                            else {

                          }
                          },
                          name: "Review Project",
                          width: getWidth(20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(5),
                    ),
                    SingleTask(taskList: taskList)

                  ]),
            ),
          ),
        ));
  }
}
