// ignore_for_file: implementation_imports, unnecessary_import

import 'package:cafeteria/crud/db_menu_item_service.dart';
import 'package:cafeteria/screens/home.dart';
import 'package:cafeteria/widgets/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer' as devtools show log;
import '../constants/routes.dart';
import '../crud/db_user_service.dart';
import '../widgets/cafeteria_card.dart';

class CafeMenuScreen extends StatefulWidget {
  final Cafeteria cafeteria;
  const CafeMenuScreen({super.key, required this.cafeteria});

  @override
  State<CafeMenuScreen> createState() => _CafeMenuScreenState();
}

class _CafeMenuScreenState extends State<CafeMenuScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return FutureBuilder(
        future: LunchMenuService.initializeCafeMenuDb(
            widget.cafeteria, DateTime.now()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Lunch Booking"),
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
                        style: GoogleFonts.acme(
                            fontWeight: FontWeight.bold, fontSize: 28),
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
                        devtools.log(DateTime.parse("${DateTime.now()}")
                            .weekday
                            .toString());
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
                          devtools
                              .log(DatabaseUserService.currentUser.toString());
                        }),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Text(
                    "Today's Menu",
                    style: GoogleFonts.dmSans(
                        fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: widget.cafeteria.cafeMenuList.length,
                        itemBuilder: (context, index) => LunchMenuCard(
                            menu: widget.cafeteria.cafeMenuList[index])),
                  )
                ],
              ),
              endDrawerEnableOpenDragGesture: true,
              backgroundColor: Colors.deepPurple[100],
            );
          }
        });
  }
}
