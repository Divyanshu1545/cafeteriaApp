import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../constants/routes.dart';
import '../styles/app_style.dart';
import '../utilities/snack_bar.dart';




class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterScreen> {
  bool isLoading = false;
  Future<void> createUserWithEmailAndPassword(email, password) async {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    setState(() {
      isLoading = false;
    });
  }

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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
              "Register, you won't regret",
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
                hintText: "User email",
                border: OutlineInputBorder(
                  gapPadding: 4,
                  borderRadius: BorderRadius.circular(6),
                ),
                prefixIcon: const Icon(
                  Icons.mail,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            TextField(
              obscureText: true,
              controller: _password,
              decoration: InputDecoration(
                hintText: "User password",
                border: OutlineInputBorder(
                  gapPadding: 4,
                  borderRadius: BorderRadius.circular(6),
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
                ),
                prefixIcon: const Icon(
                  Icons.security,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed(loginRoute);
                },
                child: const Text(
                  "Already a user? Sign in",
                  style: TextStyle(color: Colors.blue),
                )),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                onPressed: () async {
                  try {
                    await createUserWithEmailAndPassword(
                            _email.text, _password.text)
                        .then((value) async {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _email.text, password: _password.text);
                      snackBar(context, "Registration Successful", "");
                      Navigator.of(context).popAndPushNamed(homescreenRoute);
                    });
                  } on FirebaseAuthException {
                    setState(() {
                      isLoading = false;
                    });
                    snackBar(context, "Something went Wrong", 'red');
                    build(context);
                  }
                },
                fillColor: accentColor,
                elevation: 00,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Register",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
