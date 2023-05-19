import 'package:cafeteria/constants/routes.dart';
import 'package:cafeteria/constants/shared_preferences.dart';
import 'package:cafeteria/crud/db_user.dart';
import 'package:cafeteria/crud/db_user_service.dart';

import 'package:cafeteria/screens/login_with_phone_number.dart';
import 'package:cafeteria/styles/app_style.dart';
import 'package:cafeteria/utilities/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer' as devtools show log;

import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Login "),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Login to grab a meal",
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 44,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "User email",
                  prefixIcon: const Icon(Icons.mail, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              TextField(
                obscureText: _isPasswordVisible,
                controller: _password,
                decoration: InputDecoration(
                    hintText: "User password",
                    border: OutlineInputBorder(
                      gapPadding: 4,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(
                      Icons.security,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )),
              ),
              const SizedBox(
                height: 4,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed(registerRoute);
                  },
                  child: const Text(
                    "Not a user? Register here",
                    style: TextStyle(color: Colors.blue),
                  )),
              SizedBox(
                width: double.infinity,
                child: RawMaterialButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;

                    try {
                      await DatabaseUserService.loginUser(email, password);
                      await prefs.setString("_id", email);

                      devtools
                          .log(await prefs.getString("userEmail") as String);
                      await prefs.setString("password", password);
                      Navigator.pushReplacementNamed(context, homescreenRoute);
                    } on InvalidPasswordException {
                      snackBar(context, "Invalid Password", "red");
                    } on InvalidEmailException {
                      snackBar(context, "Invalid Email", "red");
                    }

                    devtools.log(DatabaseUserService.currentUser.toString());
                  },
                  fillColor: accentColor,
                  elevation: 00,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Login",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Or",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: RawMaterialButton(
                  onPressed: null,
                  fillColor: accentColor,
                  elevation: 00,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Login with Phone Number",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
