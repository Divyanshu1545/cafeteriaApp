import 'package:cafeteria/widgets/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:qr/qr.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:developer' as devtools show log;

import '../constants/routes.dart';
import '../crud/db_user_service.dart';

class BookingScreen extends StatefulWidget {
  final LunchMenu menu;
  const BookingScreen({super.key, required this.menu});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String _selectedSlot = '';
  final List<String> _slots = [
    '12:00 PM',
    '12:30 PM',
    '1:00 PM',
    '1:30 PM',
    '2:00 PM',
    '2:30 PM',
    '3:00 PM',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cafeterias"),
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xff764abc)),
              accountName: Text(
                DatabaseUserService.currentUser?.userName ?? "",
                style:
                    GoogleFonts.acme(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              accountEmail: Text(
                DatabaseUserService.currentUser?.userEmail ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: const FlutterLogo(),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                devtools.log(
                    DateTime.parse("${DateTime.now()}").weekday.toString());
                Navigator.pop(context);
              },
            ),
            ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text('Logout'),
                onTap: () {
                  DatabaseUserService.logOut();
                  Navigator.popAndPushNamed(context, loginRoute);
                  devtools.log(DatabaseUserService.currentUser.toString());
                }),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            QrImage(
              data:
                  "UserID: ${DatabaseUserService.currentUser?.userEmail}, UserName: ${DatabaseUserService.currentUser?.userName}, Slot: ${DateTime.now()}",
              size: 200,version: QrVersions.auto,
              eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square),
            )
          ],
        ),
      ),
    );
  }
}
