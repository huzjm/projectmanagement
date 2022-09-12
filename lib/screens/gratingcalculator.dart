import 'package:flutter/material.dart';

class GratingCalculator extends StatefulWidget {
  const GratingCalculator({Key? key}) : super(key: key);

  @override
  State<GratingCalculator> createState() => _GratingCalculatorState();
}
final GlobalKey<ScaffoldState> _gratingCalcKey = GlobalKey<ScaffoldState>();

class _GratingCalculatorState extends State<GratingCalculator> {
  double material=32;
  String mat='';

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
            Row(
              children: [

                Container(
                  color: Colors.lightBlueAccent,

                  child: DropdownButton(

                    hint: mat == ''
                        ? Text('Select Material',
                      style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                        : Text(
                      mat,
                        style: TextStyle(fontWeight: FontWeight.bold)
                    ),

                    items: ['MS', 'SS'].map(
                          (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(() {

                        if(val=="MS"){
                          material=32;
                          mat = "MS";

                        }
                        if(val=="SS"){
                          material=64;
                          mat = "SS";
                        }
                        print(material.toString());
                      });
                    },
                  ),
                ),

              ],
            )

          ],
        ),
      ),
      key: _gratingCalcKey ,
    );
  }
}
