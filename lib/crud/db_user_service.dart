import 'dart:developer' as devTools;

import 'package:cafeteria/constants/mongo_constants.dart';
import 'package:cafeteria/crud/db_user.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DatabaseUserService {
  bool isInitialized = false;
  AppUser? currentUser;

  late final Db db;
  late final userCollection = db.collection("users");
  Future<void> initializeDb() async {
    db = await Db.create(mongoUrl);
    await db.open();
    isInitialized = true;
    
  }

  Future<void> closeDb() async {
    await db.close();
  }

  Future<void> createUser(AppUser appUser) async {
    // if(userCollection.count(where))

    WriteResult result = await userCollection.insertOne({
      "_id": appUser.userEmail,
      "userName": appUser.userName,
      "password": appUser.password
    });
    if (result.hasWriteErrors) {
      throw UserAlreadyExistsException();
    }
  }

  Future<void> deleteUser(AppUser appUser) async {
    await userCollection.deleteOne({"_id": appUser.userEmail});
  }
  // Future<void> loginUser(AppUser appUser)async{
  //   if()
  // }
}

class UserAlreadyExistsException implements Exception {}
