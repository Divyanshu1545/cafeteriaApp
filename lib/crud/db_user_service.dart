import 'dart:developer' as devTools;

import 'package:cafeteria/constants/mongo_constants.dart';
import 'package:cafeteria/crud/db_user.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DatabaseUserService {
  static bool isInitialized = false;
  static AppUser? currentUser;

  static late final Db db;
  static final userCollection = db.collection("users");
  static Future<void> initializeDb() async {
    try {
      db = await Db.create(mongoUrl);
      await db
          .open()
          .onError((error, stackTrace) => throw ErrorConnectingToUserService());
      devTools.log("db initialized");
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
    await db.close();
  }

  static Future<void> createUser(AppUser appUser) async {
    // if(userCollection.count(where))
    ensureInitialized();

    WriteResult result = await userCollection.insertOne({
      "_id": appUser.userEmail,
      "userName": appUser.userName,
      "password": appUser.password
    });
    if (result.hasWriteErrors) {
      throw UserAlreadyExistsException();
    }
  }

  static Future<void> deleteUser(AppUser appUser) async {
    await userCollection.deleteOne({"_id": appUser.userEmail});
  }

  static Future<void> loginUser(String email, String password) async {
    await ensureInitialized();
    final result = await userCollection.findOne(where.eq("_id", email));
    if (result == null) {
      throw InvalidEmailException();
    } else if (!result.containsValue(password)) {
      throw InvalidPasswordException();
    }
    final String userName = result['userName'];
    final String userEmail=result['_id'];
    DatabaseUserService.currentUser = AppUser(
        userEmail: userEmail, userName: userName, password: password);

    devTools.log(result.toString());
  }
}

class UserAlreadyExistsException implements Exception {}

class ErrorConnectingToUserService implements Exception {}

class InvalidCredentialsException implements Exception {}

class InvalidPasswordException implements Exception {}

class InvalidEmailException implements Exception {}
