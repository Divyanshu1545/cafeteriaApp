// import 'package:cafeteria/crud/db_cafeteria_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'dart:developer' as devtools show log;
// import '../widgets/cafeteria_card.dart';

// class HomeStreamBuilder extends StatefulWidget {
//   const HomeStreamBuilder({super.key});

//   @override
//   State<HomeStreamBuilder> createState() => _HomeStreamBuilderState();
// }

// class _HomeStreamBuilderState extends State<HomeStreamBuilder> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             StreamBuilder(
//                 stream: DatabaseCafeteriaService.getAllCafeAsStream(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const CircularProgressIndicator();
//                   } else {
//                     return Expanded(
//                       child: ListView(
                        
//                       ),
//                     );
//                   }
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }
