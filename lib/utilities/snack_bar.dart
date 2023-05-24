import 'package:flutter/material.dart';

snackBar(context, String msg, String clr) {
  Color color;
  if (clr.toLowerCase() == 'red') {
    color = const Color.fromARGB(255, 164, 0, 0);
  } else {
    color = const Color.fromARGB(255, 54, 145, 57);
  }

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    showCloseIcon: true,
    backgroundColor: color,
    closeIconColor: Colors.black,
    duration: const Duration(seconds: 2),
  ));
}
