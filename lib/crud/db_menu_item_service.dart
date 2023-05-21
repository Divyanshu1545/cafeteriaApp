import 'dart:math';

import 'package:cafeteria/widgets/menu_card.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:developer' as devtools show log;
import '../constants/mongo_constants.dart';
import '../widgets/cafeteria_card.dart';
import 'db_cafeteria_service.dart';

class LunchMenuService {
  static late final Db cafeMenuDb;
  static bool isInitialized = false;
  static List<LunchMenu> menuList = [];

  static Future<void> initializeCafeMenuDb(
      Cafeteria cafe, DateTime dateTime) async {
    devtools.log("Initializing Lunch Menu DB");
    devtools.log(menuList.length.toString());
    cafeMenuDb = await Db.create(mongoUrl);
    await cafeMenuDb
        .open()
        .onError((error, stackTrace) => throw ErrorConnecting());
    DatabaseCafeteriaService.isInitialized = true;
    devtools.log("Getting List of Lunch Menu");
    await LunchMenuService.getAllMenu(cafe, dateTime);
  }

  static Future<void> getAllMenu(Cafeteria cafe, DateTime dateTime) async {
    
    final dayNumber = dateTime.weekday;
    var result = await cafeMenuDb
        .collection(menuCollectionName)
        .find(where.eq("cafe_id", cafe.cafeId).and(where.eq('day', 1)))
        .toList();

    for (Map<String, dynamic> element in result) {
      String type = element["type"] ?? "";
      String breads = element["breads"] ?? "";
      String mainCourse = element["main_course"] ?? "";
      String sides = element['sides'] ?? "";
      String salad = element['salad'] ?? "";
      String sweets = element['sweets'] ?? "";
      
      LunchMenu menu = LunchMenu(
          type: type,
          breads: breads,
          mainCourse: mainCourse,
          sides: sides,
          salad: salad,
          sweets: sweets);
      cafe.cafeMenuList.add(menu);
    }
    devtools.log("Cafe Menu fetched: ${cafe.cafeMenuList.toString()}");
  }
}
