import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hes_pm/shared/constants.dart';

import '../shared/size_config.dart';
class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
final String name;

final Icon icon;

MyTextFormField({required this.controller,required this.name, required this.icon});
  @override
  Widget build(BuildContext context) {
    return TextFormField(

    controller: controller,
      decoration: textInputDecoration.copyWith(
          hintText: name,prefixIcon: GestureDetector(
        onTap: (){FocusScope.of(context).unfocus();},
        child: icon,
      ),

    ));
  }
}
class NumberTextField extends StatelessWidget {
  const NumberTextField({Key? key, required this.controller, required this.labelText}) : super(key: key);
  final TextEditingController controller;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,1}')),
      ],
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.lightBlue, width: 1),
          ),
          border: const OutlineInputBorder(),
          icon: Icon(
            Icons.timelapse_outlined,
            color: Colors.lightBlue,
          ),
          labelText: labelText),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a number';
        }
        return null;
      },
    );
  }
}

// class TaskCheckbox extends StatelessWidget {
//   const TaskCheckbox({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                     width: 1, color: Colors.lightBlue),
//                 borderRadius: BorderRadius.all(Radius.circular(
//                     5.0) //                 <--- border radius here
//                 ),
//               ),
//               width: getWidth(40),
//               child: CheckboxListTile(
//                 title: Text("Welding: "),
//                 value: _welding,
//                 onChanged: (newValue) {
//                   setState(() {
//                     _welding = newValue!;
//                   });
//                 },
//               ),
//             ),
//             Container(
//               width: getWidth(40),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                     width: 1, color: Colors.lightBlue),
//                 borderRadius: BorderRadius.all(Radius.circular(
//                     5.0) //                 <--- border radius here
//                 ),
//               ),
//               child: CheckboxListTile(
//                 title: Text("Helper: "),
//                 value: _helper,
//                 onChanged: (newValue) {
//                   setState(() {
//                     _helper = newValue!;
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//               width: getWidth(40),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                     width: 1, color: Colors.lightBlue),
//                 borderRadius: BorderRadius.all(Radius.circular(
//                     5.0) //                 <--- border radius here
//                 ),
//               ),
//               child: CheckboxListTile(
//                 title: Text("Fitter: "),
//                 value: _fitter,
//                 onChanged: (newValue) {
//                   setState(() {
//                     _fitter = newValue!;
//                   });
//                 },
//               ),
//             ),
//             Container(
//               width: getWidth(50),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                     width: 1, color: Colors.lightBlue),
//                 borderRadius: BorderRadius.all(Radius.circular(
//                     5.0) //                 <--- border radius here
//                 ),
//               ),
//               child: CheckboxListTile(
//                 title: Text("Simultaneous: "),
//                 value: _simul,
//                 onChanged: (newValue) {
//                   setState(() {
//                     _simul = newValue!;
//                   });
//                 },
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }


