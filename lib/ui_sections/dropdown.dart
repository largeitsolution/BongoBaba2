// import 'package:flutter/material.dart';

// class Dropdown extends StatefulWidget {
//   // final List<String> itenm;
//   //  String ratingcontrol;
//   //  String hinttext;
//   // Dropdown({ this.itenm, this.hinttext = '', this.ratingcontrol = ''});
  
//   @override
//   _DropdownState createState() => _DropdownState();
// }

// class _DropdownState extends State<Dropdown> {
//   final List<String> items = [
//   'Item1',
//   'Item2',
//   'Item3',
//   'Item4',
// ];
// String selectedValue;
//   @override
//   Widget build(BuildContext context) {
//     return  DropdownButtonHideUnderline(
//         child: DropdownButton2(
//           hint: Text(
//             'Select Item',
//             style: TextStyle(
//               fontSize: 14,
//               color: Theme
//                       .of(context)
//                       .hintColor,
//             ),
//           ),
//           items: items
//                   .map((item) =>
//                   DropdownMenuItem<String>(
//                     value: item,
//                     child: Text(
//                       item,
//                       style: const TextStyle(
//                         fontSize: 14,
//                       ),
//                     ),
//                   ))
//                   .toList(),
//           value: selectedValue,
//           onChanged: (value) {
//             setState(() {
//               selectedValue = value as String;
//             });
//           },
//           buttonHeight: 40,
//           buttonWidth: 140,
//           itemHeight: 40,
//         ),
//       );
//   }
// }