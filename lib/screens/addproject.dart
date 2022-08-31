import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../shared/size_config.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

final GlobalKey<ScaffoldState> _addProjectKey = GlobalKey<ScaffoldState>();
final GlobalKey<FormState> _formAddProjectKey = GlobalKey<FormState>();

final TextEditingController _projectname = TextEditingController();
final TextEditingController _dateController = TextEditingController();

class _AddProjectState extends State<AddProject> {
  DateTime selectedDate = DateTime.now();
  DateTime dueDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String? dateinstring = DateFormat.yMMMd().format(selectedDate);
    String? duedateinstring = DateFormat.yMMMd().format(dueDate);

    Future<Null> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
        });
    }

    Future<Null> _selectDueDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: dueDate,
          firstDate: selectedDate,
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
      body: Padding(
        padding:  EdgeInsets.all(getWidth(2)),
        child: Form(
          key: _formAddProjectKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _projectname,
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
              Text("Project Start Date",style: TextStyle(color: Colors.lightBlue),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.calendar_month,color: Colors.lightBlue,),
                  Container(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.lightBlue))),
                    width: getWidth(60),
                    height: getHeight(5),
                    alignment: Alignment.center,
                    child: Text(
                      dateinstring
                          )

                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context), // Refer step 3
                    child: Text(
                      'Select date',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.lightBlue)),
                  ),

                ],
              ),
              SizedBox(
                height: getHeight(5),
              ),
              Text("Project Due Date",style: TextStyle(color: Colors.lightBlue),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.calendar_month,color: Colors.lightBlue,),
                  Container(
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.lightBlue))),
                      width: getWidth(60),
                      height: getHeight(5),
                      alignment: Alignment.center,
                      child: Text(
                          duedateinstring
                      )

                  ),
                  ElevatedButton(
                    onPressed: () => _selectDueDate(context), // Refer step 3
                    child: Text(
                      'Select date',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightBlue)),
                  ),

                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formAddProjectKey.currentState!.validate()) {
                    FirebaseFirestore.instance.collection("projects").add(
                        {"projectName": _projectname.text, "startDate": selectedDate,"dueDate":dueDate});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Successful Submission')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
