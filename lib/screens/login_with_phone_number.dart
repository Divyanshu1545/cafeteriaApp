import 'package:cafeteria/constants/routes.dart';
import 'package:cafeteria/styles/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';




import 'dart:developer' as devtools show log;



class PhoneNumberLogin extends StatefulWidget {
  const PhoneNumberLogin({super.key});

  @override
  State<PhoneNumberLogin> createState() => _PhoneNumberLoginState();
}

class _PhoneNumberLoginState extends State<PhoneNumberLogin> {
  var _phoneNumberController = TextEditingController();
  bool _isPasswordVisible = false;
  Future<void> _loginWithPhoneNumber() async {
    final String phoneNumber = _phoneNumberController.text.trim();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-verification if the SMS code is detected automatically.
        await FirebaseAuth.instance.signInWithCredential(credential);
        // Handle successful login.
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid OTP"),
          showCloseIcon: true,
          backgroundColor: Color.fromARGB(255, 164, 0, 0),
          closeIconColor: Colors.black,
          duration: Duration(seconds: 1),
        ));
      },
      codeSent: (String verificationId, int? resendToken) {
       
      },
      codeAutoRetrievalTimeout: (String verificationId) {
       
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Get some food",
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
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Phone Number",
                prefixIcon: const Icon(Icons.phone, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "OTP",
                prefixIcon: const Icon(Icons.key_outlined, color: Colors.black),
              ),
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
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                onPressed: () {},
                fillColor: accentColor,
                elevation: 00,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: const Text(
                  "Send OTP",
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
                    borderRadius: BorderRadius.circular(12)),
                child: const Text(
                  "Verify",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
