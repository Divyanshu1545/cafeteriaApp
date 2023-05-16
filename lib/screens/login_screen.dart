
import 'package:cafeteria/constants/routes.dart';
import 'package:cafeteria/crud/collections_reference.dart';
import 'package:cafeteria/styles/app_style.dart';
import 'package:cafeteria/utilities/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer' as devtools show log;



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
  

  Future<void> loginWithEmailAndPassword(email, password) async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              "Notes",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Login to your app",
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
                        ? Icons.visibility
                        : Icons.visibility_off),
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
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                onPressed: () async {
                  try {
                    loginWithEmailAndPassword(_email.text, _password.text).then(
                        (value) => Navigator.popAndPushNamed(
                            context, homescreenRoute));
                    user = FirebaseAuth.instance.currentUser;

                    userId = user?.uid as String;
                    devtools.log(userId);
                  } on FirebaseAuthException {
                    snackBar(context, "Invalid Credentials", "red");
                  }
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
            Container(
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
                  children: [
                    SvgPicture.asset(
                      'assets/google.svg',
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Sign in with google",
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
  }
}
