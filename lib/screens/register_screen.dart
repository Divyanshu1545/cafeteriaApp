import 'package:cafeteria/crud/db_user.dart';
import 'package:cafeteria/crud/db_user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:developer' as devTools;
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

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final DatabaseUserService userService = DatabaseUserService();

    TextEditingController _userName = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _organisation = TextEditingController();
    return FutureBuilder(
        future: DatabaseUserService.initializeDb(),
        builder: (context, snapshot) {
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
                    keyboardType: TextInputType.name,
                    controller: _organisation,
                    decoration: InputDecoration(
                      hintText: "Organisation",
                      border: OutlineInputBorder(
                        gapPadding: 4,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      prefixIcon: const Icon(
                        Icons.forest,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _userName,
                    decoration: InputDecoration(
                      hintText: "User Name",
                      border: OutlineInputBorder(
                        gapPadding: 4,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      prefixIcon: const Icon(
                        Icons.person_2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
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
                    obscureText: _isPasswordVisible,
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
                        AppUser appUser = AppUser(
                          userOrganisation: _organisation.text.trim(),
                          userEmail: _email.text.trim(),
                          userName: _userName.text.trim(),
                          password: _password.text.trim(),
                        );
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          await DatabaseUserService.createUser(appUser);
                          setState(() {
                            isLoading = false;
                          });
                          snackBar(
                              context, "User Successfully Created", "green");
                          Navigator.popAndPushNamed(context, loginRoute);
                        } on UserAlreadyExistsException {
                          snackBar(context,
                              "User Already Exists with this email", "red");
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            resizeToAvoidBottomInset: false,
          );
        });
  }
}
