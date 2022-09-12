import 'package:flutter/material.dart';

import '../widgets/mytextformField.dart';

class GratingCalculator extends StatefulWidget {
  const GratingCalculator({Key? key}) : super(key: key);

  @override
  State<GratingCalculator> createState() => _GratingCalculatorState();
}
final GlobalKey<ScaffoldState> _gratingCalcKey = GlobalKey<ScaffoldState>();
const List<String> materialList = ["SS", "MS"];
const List<String> unitList = ["mm", "inches"];
class _GratingCalculatorState extends State<GratingCalculator> {
  double materialDensity=32;
  String mat='';
  String material = materialList.first;
  double unitDouble =1;
  String unitText='';
  String unit = unitList.first;
  final TextEditingController _crossBarW = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text("Grating Calculator", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),),
      body: Container(
        child: Column(
          children: [

            DropdownButton<String>(
                hint: mat == ''
                    ? Text('Select Material',
                  style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                    : Text(
                    mat,
                    style: TextStyle(fontWeight: FontWeight.bold)
                ),



                elevation: 16,
                underline: Container(
                  height: 1,
                  color: Colors.lightBlue,
                ),
                items: materialList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    if(value=="MS"){
                      materialDensity=32;
                      mat = "MS";
                      material=value!;

                    }
                    if(value=="SS"){
                      materialDensity=64;
                      mat = "SS";
                      material=value!;
                    }
                    print(materialDensity.toString());
                  });
                }),

            DropdownButton<String>(
                hint: unitText == ''
                    ? Text('Select Unit',
                  style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                    : Text(
                    unitText,
                    style: TextStyle(fontWeight: FontWeight.bold)
                ),



                elevation: 16,
                underline: Container(
                  height: 1,
                  color: Colors.lightBlue,
                ),
                items: unitList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    if(value=="mm"){
                      unitDouble=1;
                      unitText = "mm";
                      unit=value!;

                    }
                    if(value=="inches"){
                      unitDouble=2;
                      unitText = "inches";
                      unit=value!;
                    }
                    print(unitDouble.toString());
                  });
                }),
            NumberTextField(labelText: 'CrossBarWidth',controller:  _crossBarW, icon:const Icon(Icons.alarm,
              color: Colors.lightBlue,))
          ],
        ),

      ),
      key: _gratingCalcKey ,
    );
  }
}
