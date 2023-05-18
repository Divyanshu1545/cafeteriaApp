import 'package:cafeteria/crud/db_user.dart';
import 'package:flutter/material.dart';
import 'package:cafeteria/screens/login_screen.dart';
import 'constants/routes.dart';
import 'package:cafeteria/screens/cafeteria_screen.dart';
import 'package:cafeteria/screens/login_with_phone_number.dart';
import 'package:cafeteria/screens/register_screen.dart';
import 'package:cafeteria/screens/splash_screen.dart';
import 'dart:developer' as devTools;
import 'package:cafeteria/crud/db_user_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbUserService = DatabaseUserService();
  final user = AppUser(
    userEmail: "daroliadivyanshu45@gmail.com",
    userName: "Divyanshu",
    password: "abcd1234",
  );
  await dbUserService.initializeDb();

  try {
    await dbUserService.createUser(user);
  } on Exception catch (e) {}
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
