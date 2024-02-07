import 'dart:developer';

import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/data/data_source/db_helper/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDataBase {
  static var db, userCollection;
  static connection() async {
    db = await Db.create(MONGO_COMN_URL);
    await db.open();
    inspect(db);
  }

  static Future<bool> insertData(Map<String, dynamic> data,
      {String COLLECTION = USER_COLLECTION}) async {
    userCollection = db.collection(COLLECTION);

    try {
      final result = await userCollection.insertOne(data);
      if (result.isSuccess) {
        return true;
      } else {
        throw ServerFailure(message: result.toString());
      }
    } catch (e) {
      print(e.toString());
      throw Exception(
          "can not insert data to collection $userCollection, ${e.toString()}");
    }
  }

  static Stream<Map<String, dynamic>> readData(
      {String COLLECTION = USER_COLLECTION}) {
    userCollection = db.collection(COLLECTION);

    try {
      final result = userCollection.find();
      return result;
    } catch (e) {
      print(e.toString());
      throw Exception(
          "can not retrive data from collection $userCollection, ${e.toString()}");
    }
  }
}
