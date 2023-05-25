import 'dart:developer' as devTools;

import 'package:cafeteria/constants/mongo_constants.dart';
import 'package:cafeteria/constants/shared_preferences.dart';
import 'package:cafeteria/crud/db_user.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DatabaseUserService {
  static bool isInitialized = false;
  static AppUser? currentUser;

  static late final Db userDb;
  static final userCollection = userDb.collection(usersCollectionName);
  static Future<void> initializeDb() async {
    try {
      userDb = await Db.create(mongoUrl);
      await userDb
          .open()
          .onError((error, stackTrace) => throw ErrorConnectingToUserService());
      devTools.log("db initialized");
      List userList = await userCollection.find().toList();
      devTools.log(userList.length.toString());
    } on ErrorConnectingToUserService {
      devTools.log("Could not open connection");
    }
    isInitialized = true;
  }

  static Future<void> ensureInitialized() async {
    if (!isInitialized) {
      await DatabaseUserService.initializeDb();
    }
  }

  static Future<void> closeDb() async {
    await userDb.close();
  }

  static Future<void> createUser(AppUser appUser) async {
    // if(userCollection.count(where))
    ensureInitialized();
    passwordStrengthValidator(appUser.password);
    WriteResult result = await userCollection.insertOne({
      "_id": appUser.userEmail,
      "userName": appUser.userName,
      "password": appUser.password,
      "organisation": appUser.userOrganisation
    });
    if (result.hasWriteErrors) {
      throw UserAlreadyExistsException();
    }
  }

  static Future<void> deleteUser(AppUser appUser) async {
    await userCollection.deleteOne({"_id": appUser.userEmail});
  }

  static logOut() async {
    DatabaseUserService.currentUser = null;
    await prefs.setString('_id', "");
    await prefs.setString('password', "");
  }

  static Future<void> loginUser(String email, String password) async {
    await ensureInitialized();
    final result = await userCollection.findOne(where.eq("_id", email));
    if (result == null) {
      throw InvalidEmailException();
    } else if (!result.containsValue(password)) {
      throw InvalidPasswordException();
    }
    try {
      final String userName = result['userName'];
      final String userEmail = result['_id'];
      final String userOrganisation = result['organisation'];
      DatabaseUserService.currentUser = AppUser(
          userEmail: userEmail,
          userName: userName,
          password: password,
          userOrganisation: userOrganisation);
    } on Exception {
      throw InvalidCredentialsException();
    }

    devTools.log(result.toString());
  }

  static void passwordStrengthValidator(String password) {
    final RegExp uppercaseRegex = RegExp(r'[A-Z]');
    final RegExp lowercaseRegex = RegExp(r'[a-z]');
    final RegExp digitRegex = RegExp(r'\d');
    final RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (!uppercaseRegex.hasMatch(password)) {
      throw WeakPasswordException(
          'Password must include at least one uppercase letter');
    }

    if (!lowercaseRegex.hasMatch(password)) {
      throw WeakPasswordException(
          'Password must include at least one lowercase letter');
    }

    if (!digitRegex.hasMatch(password)) {
      throw WeakPasswordException('Password must include at least one digit');
    }

    if (!specialCharRegex.hasMatch(password)) {
      throw WeakPasswordException(
          'Password must include at least one special character');
    }
  }
}

class WeakPasswordException implements Exception {
  final String message;

  WeakPasswordException(this.message);
  @override
  String toString() {
    return message;
  }
}

class UserAlreadyExistsException implements Exception {}

class ErrorConnectingToUserService implements Exception {}

class InvalidCredentialsException implements Exception {}

class InvalidPasswordException implements Exception {}

class InvalidEmailException implements Exception {}
