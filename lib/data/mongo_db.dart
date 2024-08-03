import 'dart:developer';

import 'package:admin/Errors/Failure.dart';
import 'package:admin/entities/product_entity.dart';
import 'package:admin/entities/user_data_entity.dart';
import 'package:either_dart/either.dart';
import 'package:mongo_dart/mongo_dart.dart';

// final Db db = Db('mongodb+srv://raoufdaifi:amin2004@cluster0.cpsnp8o.mongodb.net/');
final String mongoUri =
    "mongodb+srv://raoufdaifi:amin2004@cluster0.cpsnp8o.mongodb.net/";

class MongoDatabase {
  static Db? db;

  static Future<void> connect() async {
    try {
      db = await Db.create(mongoUri);
      await db!.open();
      print(db!.isConnected);
      inspect(db);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> close() async {
    try {
      await db!.close();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Either<Failure, String>> InsertUser(
      {required User_Data user, required String collectionName}) async {
    try {
      if (db == null) {
        await connect();
      }
      final collection = db?.collection(collectionName);
      final documentToInsert = {
        '_id': user.id, // Assigning a string value to '_id'
        'fullName': user.fullName,
        'startingDate': user.startingDate,
        'plan': user.plan,
        'endDate': user.endDate,
        'credit': user.credit,
        'lastCheckDate': user.lastCheckDate,
        'sessionLeft': user.sessionLeft,
        'isSessionMarked': user.isSessionMarked
      };

      await collection?.insert(documentToInsert);

      return Right("data setting to mongo done");
    } catch (e) {
      return Left(
          Failure(key: AppError.SettingDataError, message: e.toString()));
    }
  }

  Future<Either<Failure, List<User_Data>>> RetriveData(
      {required String collectionName}) async {
    try {
      if (db == null) {
        await connect();
      }

      final collection = db?.collection(collectionName);
      final result = await collection?.find().toList();
      return Right(result!.map((doc) => User_Data.fromMap(doc)).toList());
    } catch (e) {
      return Left(Failure(key: AppError.NotFound, message: e.toString()));
    }
  }

  Future<Either<Failure, String>> DeleteUser(
      {required User_Data user, required String collectionName}) async {
    try {
      if (db == null) {
        await connect();
      }

      final collection = db?.collection(collectionName);

      await collection?.remove(where.eq('_id', user.id));
      // await collection?.deleteOne({
      //   '_id': user.id, // Assigning a string value to '_id'
      //   'fullName': user.fullName,
      //   'startingDate': user.startingDate,
      //   'plan': user.plan,
      //   'endDate': user.endDate,
      //   'credit': user.credit,
      //   'lastCheckDate':user.lastCheckDate,
      //   'sessionLeft':user.sessionLeft,
      //   'isSessionMarked':user.isSessionMarked
      // });

      return Right("user deletting done");
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }

  Future<Either<Failure, String>> UpdateUserData(
      {required User_Data user, required String collectionName}) async {
    try {
      if (db == null) {
        await connect();
      }
      final data = user.toMap();
      final collection = db?.collection(collectionName);
      data.forEach((key, value) async {
        await collection?.update(
            where.eq('_id', user.id), modify.set(key, value));
      });

      return Right("user deletting done");
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }

/////////////////////////////////////////////////////////////////////////////////////////// product data fucntions
  Future<Either<Failure, bool>> InsertProduct(
      {required ProductEntity product, required String collectionName}) async {
    try {
      if (db == null) {
        await connect();
      }
      final collection = db?.collection(collectionName);
      final documentToInsert = {
        '_id': product.id, // Assigning a string value to '_id'
        'fullName': product.productName,
        'startingDate': product.productPrice,
        'plan': product.sellingDates,
        'endDate': product.quantityleft,
      };

      await collection?.insert(documentToInsert);

      return Right(true);
    } catch (e) {
      return Left(
          Failure(key: AppError.SettingDataError, message: e.toString()));
    }
  }

  Future<Either<Failure, List<ProductEntity>>> RetriveProducts(
      {required String collectionName}) async {
    try {
      if (db == null) {
        await connect();
      }

      final collection = db?.collection(collectionName);
      final result = await collection?.find().toList();
      return Right(result!.map((doc) => ProductEntity.fromMap(doc)).toList());
    } catch (e) {
      return Left(Failure(key: AppError.NotFound, message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> DeleteProduct(
      {required ProductEntity product, required String collectionName}) async {
    try {
      if (db == null) {
        await connect();
      }

      final collection = db?.collection(collectionName);

      await collection?.remove(where.eq('_id', product.id));

      return Right(true);
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> UpdateProductData(
      {required ProductEntity product, required String collectionName}) async {
    try {
      if (db == null) {
        await connect();
      }
      final data = product.toMap();
      final collection = db?.collection(collectionName);
      data.forEach((key, value) async {
        await collection?.update(
            where.eq('_id', product.id), modify.set(key, value));
      });

      return Right(true);
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }
}
