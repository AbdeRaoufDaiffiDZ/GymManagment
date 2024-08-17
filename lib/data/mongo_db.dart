import 'dart:developer';

import 'package:admin/Errors/Failure.dart';
import 'package:admin/entities/product_entity.dart';
import 'package:admin/entities/user_data_entity.dart';
import 'package:either_dart/either.dart';
import 'package:mongo_dart/mongo_dart.dart';

// final Db db = Db('mongodb+srv://raoufdaifi:amin2004@cluster0.cpsnp8o.mongodb.net/');
final String mongoUri =
    "mongodb+srv://raoufdaifi:amin2004@cluster0.cpsnp8o.mongodb.net/";
final String gymCollection = "gym";

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
      // final collection = db?.collection(collectionName);
      final collectiongYM = db?.collection(gymCollection);

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
      await collectiongYM?.update(where.eq('plan', user.plan),
          modify.addToSet("${user.plan}", documentToInsert));

      // where.eq('plan', user.plan).eq("${user.plan}._id", user.id),
      // modify.set('${user.plan}.\$.$key', value));
      // await collection?.insert(documentToInsert);

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
      // final collection = db?.collection(collectionName);
      final collectiongYM = db?.collection(gymCollection);

      final result = await collectiongYM?.find().toList();
      final List data = result!
          .where((element) => element['plan'] == collectionName)
          .toList();
      final List users = data[0][collectionName];
      return Right(users.map((doc) => User_Data.fromMap(doc)).toList());
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

      final collectiongYM = db?.collection(gymCollection);

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
      await collectiongYM?.update(where.eq('plan', user.plan),
          modify.pull("${user.plan}", documentToInsert));

      // await collection?.remove(where.eq('plan', user.plan).eq("${user.plan}._id", user.id));
      // // await collection?.deleteOne({
      // //   '_id': user.id, // Assigning a string value to '_id'
      // //   'fullName': user.fullName,
      // //   'startingDate': user.startingDate,
      // //   'plan': user.plan,
      // //   'endDate': user.endDate,
      // //   'credit': user.credit,
      // //   'lastCheckDate':user.lastCheckDate,
      // //   'sessionLeft':user.sessionLeft,
      // //   'isSessionMarked':user.isSessionMarked
      // // });

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
      // final collection = db?.collection(collectionName);
      final collectiongYM = db?.collection(gymCollection);

      // await collection?.update(
      //     // where.eq('_id', user.id), modify.addToSet("hello", {"raouf":"daFFii","test":1}));
      //     // where.eq('plan', user.plan).eq("${user.plan}.id", user.id), modify.set('${user.plan}.\$.credit',user.credit));

      //     where.eq('plan', user.plan).eq("hello.raouf", "daFFii"),
      //     modify.set('hello.\$.test', user.credit));

      data.forEach((key, value) async {
        await collectiongYM?.update(
            // where.eq('_id', user.id), modify.addToSet("hello", {"raouf":"daFFii","test":1}));

            where.eq('plan', user.plan).eq("${user.plan}._id", user.id),
            modify.set('${user.plan}.\$.$key', value));
      });
      return Right("user deletting done");
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }

/////////////////////////////////////////////////////////////////////////////////////////// product data fucntions
  Future<Either<Failure, bool>> InsertProduct(
      {required Product product, required String collectionName}) async {
    try {
      if (db == null) {
        await connect();
      }
      // final collection = db?.collection(collectionName);
      final documentToInsert = {
        'productName': product.name,
        'productPrice': product.price,
        '_id': product.id,
        'priceoverview': product.priceoverview,
        'quantityleft': product.quantity,
        'saleRecords': product.saleRecords,
        'sold': product.sold
      };

      final collectiongYM = db?.collection(gymCollection);

      await collectiongYM?.update(where.eq('plan', collectionName),
          modify.addToSet(collectionName, documentToInsert));

      // await collection?.insert(documentToInsert);

      return Right(true);
    } catch (e) {
      return Left(
          Failure(key: AppError.SettingDataError, message: e.toString()));
    }
  }

  Future<Either<Failure, List<Product>>> RetriveProducts(
      {required String collectionName}) async {
    try {
      if (db == null) {
        await connect();
      }
      final collectiongYM = db?.collection(gymCollection);

      final result = await collectiongYM?.find().toList();
      final List data = result!
          .where((element) => element['plan'] == collectionName)
          .toList();
      final List product = data[0][collectionName];
      // final collection = db?.collection(collectionName);
      // final result = await collection?.find().toList();
      return Right(product.map((doc) => Product.fromMap(doc)).toList());
    } catch (e) {
      return Left(Failure(key: AppError.NotFound, message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> DeleteProduct(
      {required Product product, required String collectionName}) async {
    try {
      if (db == null) {
        await connect();
      }

      final collectiongYM = db?.collection(gymCollection);

      final documentToInsert = {
        'productName': product.name,
        'productPrice': product.price,
        '_id': product.id,
        'priceoverview': product.priceoverview,
        'quantityleft': product.quantity,
        'saleRecords': product.saleRecords,
        'sold': product.sold
      };
      await collectiongYM?.update(where.eq('plan', collectionName).eq('$collectionName._id', product.id),
          modify.pull(collectionName, documentToInsert));

      // final collection = db?.collection(collectionName);

      // await collection?.remove(where.eq('_id', product.id));

      return Right(true);
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> UpdateProductData(
      {required Product product, required String collectionName}) async {
    try {
      if (db == null) {
        await connect();
      }
      final collectiongYM = db?.collection(gymCollection);

      final data = product.toMap();
      data.forEach((key, value) async {
        if (key == "saleRecords") {
          final List<SaleRecord> sale = value;
          // where.eq('plan', user.plan).eq("${user.plan}._id", user.id),
          // modify.set('${user.plan}.\$.$key', value));
          await collectiongYM?.update(
              where
                  .eq('plan', collectionName)
                  .eq("$collectionName._id", product.id),
              modify.set('$collectionName.\$.saleRecords',
                  convertSaleRecordsToMap(sale)));
        } else {
          await collectiongYM?.update(
              where
                  .eq('plan', collectionName)
                  .eq("$collectionName._id", product.id),
              modify.set('$collectionName.\$.$key', value));
        }
      });

      return Right(true);
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }

  List<Map<String, dynamic>> convertSaleRecordsToMap(List<SaleRecord> sales) {
    return sales.map((sale) => sale.toMap()).toList();
  }
}
