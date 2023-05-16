import 'package:cafeteria/constants/routes.dart';
import 'package:cafeteria/crud/collections_reference.dart';
import 'package:cafeteria/constants/data.dart';
import 'package:cafeteria/styles/app_style.dart';
import 'package:cafeteria/utilities/snack_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer' as devtools show log;

class CafeteriaScreen extends StatefulWidget {
  const CafeteriaScreen({super.key});

  @override
  State<CafeteriaScreen> createState() => _CafeteriaScreenState();
}

class _CafeteriaScreenState extends State<CafeteriaScreen> {
  bool isNonVeg = true;
  bool isVeg = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cafeteria A"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              const Text(
                "Hot Items",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              CarouselSlider(
                options: CarouselOptions(height: 200),
                items: [
                  'assets/images/burger.png',
                  'assets/images/coffee.png',
                  'assets/images/vegSandwich.png',
                  'assets/images/WhiteSaucePasta.png',
                  'assets/images/Samosa.png',
                  'assets/images/garlicBread.png',
                  'assets/images/smoothie.png'
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  i,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (i == 'assets/images/burger.png')
                              Text(
                                "${FoodList[0]} - ${prices[0]}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            if (i == 'assets/images/coffee.png')
                              Text(
                                "${FoodList[1]} - ${prices[1]}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            if (i == 'assets/images/vegSandwich.png')
                              Text(
                                "${FoodList[2]} - ${prices[2]}",
                                style: listingStyle,
                              ),
                            if (i == 'assets/images/WhiteSaucePasta.png')
                              Text("${FoodList[3]} - ${prices[3]}",
                                  style: listingStyle),
                            if (i == 'assets/images/Samosa.png')
                              Text(
                                "${FoodList[4]} - ${prices[4]}",
                                style: listingStyle,
                              ),
                            if (i == 'assets/images/garlicBread.png')
                              Text(
                                "${FoodList[5]} - ${prices[5]}",
                                style: listingStyle,
                              ),
                            if (i == 'assets/images/smoothie.png')
                              Text(
                                "${FoodList[6]} - ${prices[6]}",
                                style: listingStyle,
                              ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                      value: isVeg,
                      onChanged: (value) {
                        setState(() {
                          isVeg = !isVeg;
                        });
                      },
                    ),
                    const Text("Veg"),
                    Checkbox(
                      value: isNonVeg,
                      onChanged: (value) {
                        setState(() {
                          isNonVeg = !isNonVeg;
                        });
                      },
                    ),
                    const Text("Non-Veg"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Menu"),
        icon: const Icon(Icons.menu),
      ),
    );
  }
}
