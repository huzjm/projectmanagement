import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hes_pm/model/project.dart';
import 'package:hes_pm/screens/addtask.dart';
import 'package:hes_pm/widgets/mytextformField.dart';
import 'package:intl/intl.dart';

import '../model/task.dart';
import '../shared/size_config.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

const List<String> locationList = ["P&G Hub", "P&G Port Qasim", "Grating"];

final GlobalKey<ScaffoldState> _addProjectKey = GlobalKey<ScaffoldState>();
final GlobalKey<FormState> _formAddProjectKey = GlobalKey<FormState>();



class _AddProjectState extends State<AddProject> {
  DateTime startDate = DateTime.now();
  DateTime dueDate = DateTime.now();
  String location = locationList.first;
  final TextEditingController _projectName = TextEditingController();
  final TextEditingController _workHours = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? dateString = DateFormat.yMMMd().format(startDate);
    String? dueDateString = DateFormat.yMMMd().format(dueDate);

    Future<Null> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: startDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != startDate)
        setState(() {
          startDate = picked;
          if (dueDate.isBefore(startDate)) {
            dueDate = picked;
          }
        });
    }

    Future<Null> _selectDueDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: dueDate,
          firstDate: startDate,
          lastDate: DateTime(2101));
      if (picked != null && picked != dueDate)
        setState(() {
          dueDate = picked;
        });
    }

    return Scaffold(
      key: _addProjectKey,
      appBar: AppBar(
        title: Text("Add Project", style: TextStyle(color: Colors.black)),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getWidth(2)),
          child: Form(
            key: _formAddProjectKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _projectName,
                  decoration: InputDecoration(
                      icon: Icon(Icons.file_copy), labelText: 'Project Name'),
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
                Text(
                  "Location",
                  style: TextStyle(color: Colors.lightBlue),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_sharp,
                      color: Colors.lightBlue,
                    ),
                    SizedBox(
                      width: getWidth(1),
                    ),
                    Container(
                      width: getWidth(88),
                      child: DropdownButton<String>(
                          value: location,
                          isExpanded: true,
                          hint: Text("Location"),
                          elevation: 16,
                          underline: Container(
                            height: 1,
                            color: Colors.lightBlue,
                          ),
                          items: locationList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              location = value!;
                            });
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(5),
                ),
                Text(
                  "Start Date",
                  style: TextStyle(color: Colors.lightBlue),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Colors.lightBlue,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.lightBlue))),
                        width: getWidth(60),
                        height: getHeight(5),
                        alignment: Alignment.center,
                        child: Text(dateString)),
                    ElevatedButton(
                      onPressed: () => _selectDate(context), // Refer step 3
                      child: Text(
                        'Select date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightBlue)),
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(5),
                ),
                Text(
                  "Due Date",
                  style: TextStyle(color: Colors.lightBlue),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Colors.lightBlue,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.lightBlue))),
                        width: getWidth(60),
                        height: getHeight(5),
                        alignment: Alignment.center,
                        child: Text(dueDateString)),
                    ElevatedButton(
                      onPressed: () => _selectDueDate(context), // Refer step 3
                      child: Text(
                        'Select date',
                        style: TextStyle(
                             fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightBlue)),
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(5),
                ),
                Container(
                  width: getWidth(60),
                  child: NumberTextField(controller: _workHours, labelText: 'Labor Hours',)

                ),
                SizedBox(
                  height: getHeight(5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(

                      onPressed: () {if (_formAddProjectKey.currentState!.validate()) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AddTask(name:_projectName.text, startDate: startDate, dueDate:dueDate,location:location,hours:double.parse(_workHours.text))));}

                      },
                      child: const Text('Add Tasks'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
