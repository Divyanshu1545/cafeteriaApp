import 'package:cafeteria/constants/routes.dart';
import 'package:cafeteria/crud/db_user_service.dart';
import 'package:cafeteria/screens/cafeteria_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cafeteria/main.dart';
import 'dart:developer' as devtools show log;

import '../constants/data.dart';
import '../crud/db_cafeteria_service.dart';
import '../widgets/cafeteria_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
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
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CafeteriaCard(
                cafe: DatabaseCafeteriaService.cafeList[index],
              ),
              itemCount: DatabaseCafeteriaService.cafeList.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Cafe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Tuckshop',
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
