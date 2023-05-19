// ignore_for_file: await_only_futures, use_build_context_synchronously

import 'package:cafeteria/constants/shared_preferences.dart';
import 'package:cafeteria/crud/db_user_service.dart';
import 'package:cafeteria/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await DatabaseUserService.initializeDb();
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString("_id") == null) {
// ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      final email = await prefs.getString("_id");
      final password = await prefs.getString("password");
      try {
        await DatabaseUserService.loginUser(
            email as String, password as String);
      } on Exception {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF800B),
              Color(0xFFCE1010),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "./assets/images/plate.png",
                  height: 300.0,
                  width: 300.0,
                ),
                const Text(
                  "Cafeteria",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0,
                  ),
                ),
              ],
            ),
            const SpinKitSpinningLines(
              color: Colors.white,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
