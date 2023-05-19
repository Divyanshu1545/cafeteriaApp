import 'package:cafeteria/constants/routes.dart';
import 'package:cafeteria/crud/db_user_service.dart';
import 'package:cafeteria/screens/cafeteria_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cafeteria/main.dart';
import 'dart:developer' as devtools show log;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  bool isTapped = false;

  final List<String> imageAssets = [
    'assets/images/imgkj.png',
    'assets/images/imgkl.png',
    'assets/images/imgkk.png',
  ];

  final List<String> titles = [
    'Image 1',
    'Image 2',
    'Image 3',
  ];

  final List<String> descriptions = [
    'Cafeteria A',
    'Cafeteria B',
    'Cafeteria C'
  ];

  void onCarouselPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      currentIndex = index;
    });
  }

  void toggleText() {
    setState(() {
      isTapped = !isTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
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
          SizedBox(height: screenHeight * 0.1),
          Container(
              height: screenHeight * 0.1,
              alignment: Alignment.topCenter,
              child: Text(
                descriptions[currentIndex],
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
          Expanded(
            flex: 2,
            child: CarouselSlider.builder(
              itemCount: imageAssets.length,
              itemBuilder: (context, index, _) {
                return GestureDetector(
                  onVerticalDragEnd: (DragEndDetails details) {
                    if (details.primaryVelocity != null) {
                      toggleText();
                    }
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CafeteriaScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              imageAssets[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Positioned.fill(
                            child: AnimatedOpacity(
                              opacity: isTapped ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 200),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  titles[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: screenHeight * 0.6, // Adjust the height as needed
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                onPageChanged: onCarouselPageChanged,
              ),
            ),
          ),
          const SizedBox(height: 16),
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
