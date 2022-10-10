import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hes_pm/model/employee.dart';
import 'package:hes_pm/widgets/mybutton.dart';
import 'package:hes_pm/widgets/mytextformField.dart';

import '../shared/size_config.dart';

class AddEmployee extends StatefulWidget {
  final double id;
   AddEmployee({ required this.id}) ;

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

final GlobalKey<ScaffoldState> _addEmployeeKey = GlobalKey<ScaffoldState>();
final GlobalKey<FormState> _formAddEmployeeKey = GlobalKey<FormState>();
const List<String> locationList = ["P&G Hub", "P&G Port Qasim", "Grating"];
class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController _employeeName = TextEditingController();
  final TextEditingController _salary = TextEditingController();
  bool _welding = false;
  bool _helper = false;
  bool _fitter = false;
  String location = locationList.first;
  String type='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee", style: TextStyle(color: Colors.black)),
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
      key: _addEmployeeKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getWidth(2)),
          child: Form(
            key: _formAddEmployeeKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyTextFormField(
                    controller: _employeeName,
                    name: "Employee Name",
                    icon: Icon(Icons.person)),
                SizedBox(
                  height: getHeight(5),
                ),
                Container(
                    width: getWidth(60),
                    child: NumberTextField(obserIcon:true,
                        labelText: "Salary",
                        controller: _salary,
                        icon: Icon(Icons.monetization_on_rounded))),
                SizedBox(
                  height: getHeight(5),
                ),
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
                      width: getWidth(30),
                      child: CheckboxListTile(
                        title: Text("Welding: "),
                        value: _welding,
                        onChanged: (newValue) {
                          setState(() {
                            if (!newValue!){
                              type = type.replaceAll("W","");
                            }
                            if(newValue){
                              type=type+'W';
                            }
                            _welding = newValue;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: getWidth(30),
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
                            if (!newValue!){
                              type = type.replaceAll("H","");
                            }
                            if(newValue){
                              type=type+'H';
                            }
                            _helper = newValue;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: getWidth(30),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Colors.lightBlue),
                        borderRadius: BorderRadius.all(Radius.circular(
                            5.0) //                 <--- border radius here
                        ),
                      ),
                      child: CheckboxListTile(
                        title: Text("Fitter: ",style: TextStyle(fontSize: 15),),
                        value: _fitter,
                        onChanged: (newValue) {
                          setState(() {
                            if (!newValue!){
                              type = type.replaceAll("F","");
                            }
                            if(newValue){
                              type=type+'F';
                            }
                            _fitter = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),SizedBox(
                  height: getHeight(5),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      onPressed: () {
                        if (_formAddEmployeeKey.currentState!.validate()) {
                          Employee employee = Employee.init(name: _employeeName.text,location: location,type: type,salary: double.parse(_salary.text),id:widget.id);


                          FirebaseFirestore.instance
                              .collection("employees")
                              .add(
                            employee.toMap()


                          );
                          updateID();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Employee Added Successfully')),
                          );
                          while(Navigator.canPop(context)){ // Navigator.canPop return true if can pop
                            Navigator.pop(context);
                          }
                        }
                      },name:
                       'Add Employee', width: getWidth(30),

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

  Future<void> updateID() async {
    var users = FirebaseFirestore.instance.collection('misc');
    return users.doc("rTval59GjklHCLKLjao0").update({'IDcount': widget.id+1});
  }
}
