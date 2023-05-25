import 'package:cafeteria/screens/booking_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:developer' as devtools show log;

class LunchMenu {
  final String type;
  final String breads;
  final String mainCourse;
  final String sides;

  LunchMenu({
    required this.type,
    required this.breads,
    required this.mainCourse,
    required this.sides,
  });
  @override
  String toString() {
    // TODO: implement toString
    return "$type, $breads, $mainCourse, $sides, ";
  }
}

class LunchMenuCard extends StatelessWidget {
  final LunchMenu menu;

  bool isVeg() {
    if (menu.type.toLowerCase() == "veg") {
      return true;
    } else {
      return false;
    }
  }

  const LunchMenuCard({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    devtools.log(menu.toString());
    List<String> breadsList = menu.breads.split(',');
    devtools.log(breadsList.toString());
    List<String> mainCourseList = menu.mainCourse.split(',');
    devtools.log(mainCourseList.toString());
    String url = isVeg()
        ? "https://images.unsplash.com/photo-1579113800032-c38bd7635818?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80"
        : "https://images.unsplash.com/photo-1606502973842-f64bc2785fe5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=464&q=80";
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return BookingScreen(
            menu: menu,
          );
        })));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 10,
          child: Container(
            height: 470,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(url),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.black, Colors.transparent])),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Breads",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: breadsList.length,
                      itemBuilder: (context, index) => Text(
                        "   ${breadsList[index]}",
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    const Text(
                      "Main Course",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: mainCourseList.length,
                      itemBuilder: (context, index) => Text(
                        "   ${mainCourseList[index]}",
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    const Text(
                      "Sides",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "   ${menu.sides}",
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 13),
                    
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: const Text(
                            "",
                            style: TextStyle(color: Colors.white70),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
