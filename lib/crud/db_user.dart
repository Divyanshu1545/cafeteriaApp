// ignore_for_file: unused_import

import 'package:cafeteria/constants/mongo_constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AppUser {
  late final userEmail;
 late final userName;
  late final password;

  AppUser({
    required this.userEmail,
    required this.userName,
    required this.password,
  });
}
