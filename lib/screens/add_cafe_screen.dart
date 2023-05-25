// import 'dart:ffi';

// import 'package:cafeteria/constants/mongo_constants.dart';
// import 'package:cafeteria/crud/db_cafeteria_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class AddCafescreen extends StatefulWidget {
//   const AddCafescreen({super.key});

//   @override
//   State<AddCafescreen> createState() => _AddCafescreenState();
// }

// TextEditingController _cafeID = TextEditingController();
// TextEditingController _cafeName = TextEditingController();
// TextEditingController _cafeDescription = TextEditingController();
// TextEditingController _seats = TextEditingController();

// class _AddCafescreenState extends State<AddCafescreen> {
//   TextEditingController _email = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Cafe"),
//       ),
//       body: Center(
//           child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               keyboardType: TextInputType.emailAddress,
//               controller: _cafeID,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 hintText: "Cafe ID",
//                 prefixIcon: const Icon(Icons.mail, color: Colors.black),
//               ),
//             ),
//             TextField(
//               keyboardType: TextInputType.emailAddress,
//               controller: _cafeName,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 hintText: "Cafe Name",
//                 prefixIcon: const Icon(Icons.mail, color: Colors.black),
//               ),
//             ),
//             TextField(
//               keyboardType: TextInputType.emailAddress,
//               controller: _cafeDescription,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 hintText: "Description",
//                 prefixIcon: const Icon(Icons.mail, color: Colors.black),
//               ),
//             ),
//             TextField(
//               keyboardType: TextInputType.emailAddress,
//               controller: _seats,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 hintText: "Seats",
//                 prefixIcon: const Icon(Icons.mail, color: Colors.black),
//               ),
//             ),
//             ElevatedButton(
//                 onPressed: () async {
//                   await DatabaseCafeteriaService.cafeDb
//                       .collection(cafeteriaCollectionName)
//                       .insertOne({
//                     "_id": "",
//                     "description": "",
//                     "seats": int.parse(_seats.text),
//                     "name": _cafeName.text
//                   });
//                 },
//                 child: const Text("Add Cafe"))
//           ],
//         ),
//       )),
//     );
//   }
// }
