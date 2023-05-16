import 'package:flutter/material.dart';
import 'package:cafeteria/screens/login_screen.dart';
import 'constants/routes.dart';
import 'package:cafeteria/screens/cafeteria_screen.dart';
import 'package:cafeteria/screens/login_with_phone_number.dart';
import 'package:cafeteria/screens/register_screen.dart';
import 'package:cafeteria/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        loginRoute: (context) => const LoginScreen(),
        registerRoute: (context) => const RegisterScreen(),
        homescreenRoute: (context) => const CafeteriaScreen(),
        loginWithPhoneNumberRoute: (context) => const PhoneNumberLogin(),
      },
      home: const SplashScreen(),
    );
  }
}
