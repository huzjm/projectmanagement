import 'package:flutter/material.dart';
import 'package:hes_pm/model/project.dart';
import 'package:hes_pm/model/task.dart';
import 'package:hes_pm/screens/reviewproject.dart';
import 'package:hes_pm/shared/size_config.dart';
import 'package:hes_pm/widgets/mybutton.dart';
import 'package:hes_pm/widgets/mytextformField.dart';
import 'package:hes_pm/widgets/singletask.dart';

class AddTask extends StatefulWidget {
  const AddTask({
    Key? key,
    required this.name,
    required this.startDate,
    required this.dueDate,
    required this.location,
  }) : super(key: key);
  final String name;
  final DateTime startDate;
  final DateTime dueDate;
  final String location;

  @override
  State<AddTask> createState() => _AddTaskState();
}

final GlobalKey<ScaffoldState> _addTaskKey = GlobalKey<ScaffoldState>();
final GlobalKey<FormState> _formAddTaskKey = GlobalKey<FormState>();
final TextEditingController _numberHelper = TextEditingController();
final TextEditingController _numberFitter = TextEditingController();
final TextEditingController _numberWelder = TextEditingController();
final TextEditingController _daysHelper = TextEditingController();
final TextEditingController _daysFitter = TextEditingController();
final TextEditingController _daysWelder = TextEditingController();
final TextEditingController _name = TextEditingController();

bool _simul = false;



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
                    SizedBox(height: getHeight(2),),
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
                      height: getHeight(2),
                    ),


                    Container(
                      height: getHeight(5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Helpers: "),
                            Container(
                              width: getWidth(30),
                              child: NumberTextField(
                                obserIcon: false,
                                labelText: "#",
                                controller: _numberHelper,

                              ),
                            ),
                            Container(
                              width: getWidth(40),
                              child: NumberTextField(
                                  obserIcon: false,

                                  labelText: "Days",
                                  controller: _daysHelper),
                            ),
                          ]),
                    ),
                    SizedBox(height: getHeight(2),),
                    Container(
                      height: getHeight(5),
                      child: Row(
                        children: [
                          Text("Fitters:    "),
                          Container(
                            width: getWidth(30),
                            child: NumberTextField(
                                obserIcon: false,

                                labelText: "#",
                                controller: _numberFitter),
                          ),
                          Container(
                              width: getWidth(40),
                              child: NumberTextField(
                                  obserIcon: false,

                                  labelText: "Days",
                                  controller: _daysFitter)),
                        ],
                      ),
                    ),SizedBox(height: getHeight(2),),
                    Container(
                      height: getHeight(5),
                      child: Row(
                        children: [
                          Text("Welders: "),
                          Container(
                            width: getWidth(30),
                            child: NumberTextField(
                                obserIcon: false,

                                labelText: "#",
                                controller: _numberWelder),
                          ),
                          Container(
                            width: getWidth(40),
                            child: NumberTextField(
                                obserIcon: false,

                                labelText: "Days",
                                controller: _daysWelder),
                          ),
                        ],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [


                          Container(
                            width: getWidth(50),
                            height: getHeight(5),
                            child: CheckboxListTile(
                              title: Text("Simultaneous: "),
                              value: _simul,
                              onChanged: (newValue) {
                                setState(() {
                                  _simul = newValue!;
                                });
                              },
                            ),
                          )
                        ]),
                    SizedBox(
                      height: getHeight(5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyButton(
                            name: "Add Task",
                            onPressed: () {
                              if (_formAddTaskKey.currentState!.validate()) {
                                setState(() {
                                  var task = Task(
                                      days: double.parse(_numberWelder.text) *
                                              double.parse(_daysWelder.text) +
                                          double.parse(_numberFitter.text) *
                                              double.parse(_daysFitter.text) +
                                          double.parse(_numberHelper.text) *
                                              double.parse(_daysHelper.text),

                                      name: _name.text,
                                      simul: _simul,
                                      index: counter,
                                      completion: false,
                                      employeeSchedule: [EmployeeTask.init()]);
                                  taskList.add(task);
                                  _formAddTaskKey.currentState?.reset();

                                  _name.clear();

                                  _numberFitter.clear();
                                  _daysFitter.clear();
                                  _numberHelper.clear();
                                  _daysHelper.clear();
                                  _numberWelder.clear();
                                  _daysWelder.clear();
                                  _simul = false;

                                  counter++;
                                });
                              }
                            },
                            width: getWidth(40)),
                        SizedBox(
                          width: getWidth(5),
                        ),
                        MyButton(
                          onPressed: () {
                            if (taskList.isNotEmpty) {
                              Project project = Project(
                                  complete: false,
                                  days: 0,
                                  tasks: taskList,
                                  name: widget.name,
                                  startDate: widget.startDate,
                                  dueDate: widget.dueDate,
                                  location: widget.location);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) =>
                                      ReviewProject(project: project)));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Add a Task')),
                              );
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
