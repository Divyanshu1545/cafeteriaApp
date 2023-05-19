// ignore_for_file: unused_import

import 'package:cafeteria/constants/mongo_constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AppUser {
  late final String userEmail;
  late final String userName;
  late final String password;
  late final String userOrganisation;

  AppUser(
      {required this.userEmail,
      required this.userName,
      required this.password,
      required this.userOrganisation});
  Map<String, String> toMap(AppUser user) {
    return {
      "_id": user.userEmail,
      "userName": user.userName,
      "password": user.password,
      "organisation":user.userOrganisation
    };
  }

  @override
  String toString() {
    // TODO: implement toString

    return 'User {username: $userName, userEmail: $userEmail, organisation: $userOrganisation}';
  }
}
