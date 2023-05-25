import 'package:cafeteria/crud/db_cafeteria_service.dart';
import 'package:cafeteria/screens/dummy_card.dart';
import 'package:cafeteria/widgets/cafeteria_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer' as devtools show log;
import '../constants/routes.dart';
import '../crud/db_user_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  var _selectedIndex = 0;
  // Future<void> initializeDB() async {
  //   devtools.log("Getting cafe to list");
  //   await DatabaseCafeteriaService.getAllCafe();
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseCafeteriaService.initializeCafeDb(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            devtools.log("Waiting");
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            devtools.log("Done");
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
                backgroundColor: const Color.fromARGB(255, 233, 233, 233),
                selectedItemColor: Colors.deepOrangeAccent,
                currentIndex: _selectedIndex,
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
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            );
          }
        });
  }
}
