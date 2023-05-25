import 'package:cafeteria/constants/mongo_constants.dart';
import 'package:cafeteria/widgets/cafeteria_card.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:developer' as devtools show log;

class DatabaseCafeteriaService {
  static late final Db cafeDb;
  static List<Cafeteria> cafeList = [];
  static final cafeteriaColleciton = cafeDb.collection(cafeteriaCollectionName);
  static bool isInitialized = false;

  static Future<void> initializeCafeDb() async {
    devtools.log("Initializing Cafe DB");
    cafeDb = await Db.create(mongoUrl);
    await cafeDb.open().onError((error, stackTrace) => throw ErrorConnecting());
    DatabaseCafeteriaService.isInitialized = true;
    devtools.log("Getting List of cafeterias");
    await DatabaseCafeteriaService.getAllCafe();
  }

  static Cafeteria mapToCafeteria(Map<String, dynamic> cafeMap) {
    return Cafeteria(
        name: cafeMap["name"],
        cafeId: cafeMap["_id"],
        description: cafeMap["description"],
        seats: cafeMap["seats"]);
  }

  static Future<void> getAllCafe() async {
    var result = await cafeteriaColleciton.find().toList();
    devtools.log('Results fetched: ${result.length.toString()}');
    for (Map<String, dynamic> cafe in result) {
    
        Cafeteria cafeteria = Cafeteria(
            name: cafe["name"],
            cafeId: cafe["_id"],
            description: cafe["description"],
            seats: cafe["seats"]);
        devtools.log(cafeteria.toString());
        cafeList.add(cafeteria);
        isInitialized = true;
      
    }
    devtools.log(cafeList.toString());
    devtools.log("No. of cafeterias: ${cafeList.length}");
  }
}

class ErrorConnecting implements Exception {}
