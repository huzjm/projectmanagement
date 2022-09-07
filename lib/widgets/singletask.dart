import 'package:flutter/material.dart';
import 'package:hes_pm/shared/size_config.dart';

import '../model/task.dart';

class SingleTask extends StatefulWidget {
  SingleTask({required this.taskList});

  final List<Task> taskList;

  @override
  State<SingleTask> createState() => _SingleTaskState();
}

class _SingleTaskState extends State<SingleTask> {
  List<TableRow> getList() {
    List<TableRow> tableRows = widget.taskList
        .map((e) => TableRow(children: <Widget>[
              Center(
                child: Container(height: getHeight(4),
                  child: Text(e.index.toString()),
                ),
              ),
              Center(
                child: Container(
                  height: getHeight(4),
                  child: Text(e.name),
                ),
              ),
              Center(
                child: Container(height: getHeight(4),
                  child: Text(e.hours.toString()),
                ),
              ),
              Center(
                child: Container(height: getHeight(4),
                  width: getWidth(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (e.welding) Text('W'),
                      if (e.helper) Text('H'),
                      if (e.fitter) Text('F'),
                      if (e.simul) Text('S'),
                    ],
                  ),
                ),
              )
            ]))
        .toList();
    return tableRows;
  }

  @override
  Widget build(BuildContext context) {

    return
      Container(
        height: getHeight(30),
        child: SingleChildScrollView(
        child: Table(
          border: TableBorder(
              horizontalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid)
          ),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(0.3),
            1: FlexColumnWidth(1.0),
            2: FlexColumnWidth(0.4),
            3: FlexColumnWidth(0.5),
          },
          defaultVerticalAlignment:
          TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(
              children: <Widget>[
                Center(
                  child: Container(
                    height: getHeight(5),
                    child: Text(
                      "S.no",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 18,),
                    ),
                  ),
                ),
                Center(
                  child: Container(height: getHeight(5),
                    child: Text("Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18)),
                  ),
                ),
                Center(
                  child: Container(height: getHeight(5),
                    child: Text("Hours",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18)),
                  ),
                ),
                Center(
                  child: Container(height: getHeight(5),
                    child: Text("Type",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18)),
                  ),
                )
              ],
            ),

            ...getList(),
          ],
        ),
    ),
      );
  }
}
