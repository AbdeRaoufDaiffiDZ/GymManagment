import 'dart:developer';

import 'package:admin/Errors/Failure.dart';
import 'package:admin/entities/gym_parm_entity.dart';
import 'package:admin/entities/product_entity.dart';
import 'package:admin/entities/user_data_entity.dart';
import 'package:either_dart/either.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart';

// final Db db = Db('mongodb+srv://raoufdaifi:amin2004@cluster0.cpsnp8o.mongodb.net/');
final String mongoUri =
    "mongodb+srv://raoufdaifi:amin2004@cluster0.cpsnp8o.mongodb.net/";
final String gymCollection = "gym";

Map<String, int> PlanPrices = {
  '8 session': 1500,
  '12 session': 1500,
  '16 session': 2000,
  'unlimited': 1500,
};

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

  Future<List<Map<String, dynamic>>?> RetriveDataFDTB() async {
    if (db == null) {
      await connect();
    }
    // final collection = db?.collection(collectionName);
    final collectiongYM = db?.collection(gymCollection);

    final result = await collectiongYM?.find().toList();
    return result!;
  }

  Future<Either<Failure, GymParam>> GymParamRetrive(
      {required String collectionName}) async {
    try {
      final dataFDB = (await RetriveDataFDTB())!;
      final result = dataFDB
          .where((element) => element['plan'] == collectionName)
          .toList();

      if (result.isEmpty) {
        return Right(GymParam(plan: collectionName, totalCredit: 0));
      }
      final Map<String, dynamic>? gymparam = result[0]['GymParam'];
      if (gymparam == null) {
        return Right(GymParam(plan: collectionName, totalCredit: 0));
      }
      return Right(GymParam.fromMap(gymparam));
    } catch (e) {
      return Left(Failure(key: AppError.NotFound, message: e.toString()));
    }
  }

  Future<Either<Failure, List<User_Data>>> RetriveData({
    required String collectionName,
  }) async {
    try {
      // if (db == null) {
      //   await connect();
      // }
      // // final collection = db?.collection(collectionName);
      // final collectiongYM = db?.collection(gymCollection);

      // final result = await collectiongYM?.find().toList();
      final dataFDB = (await RetriveDataFDTB())!;

      final result = dataFDB;

      final List data =
          result.where((element) => element['plan'] == collectionName).toList();
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
      final collectiongYM = db?.collection(gymCollection);
      final dataUser = await RetriveData(collectionName: collectionName);
      if (dataUser.isRight) {
        bool isNotSameCredit = false;
        bool creditType = false;

        /// false for Positive, true for negative
        int credit = int.parse((dataUser.right
            .where((element) => element.id == user.id)
            .first
            .credit));
        if (credit != int.parse(user.credit)) {
          isNotSameCredit = true;
          if (credit < int.parse(user.credit)) {
            creditType = true;
          } else {
            creditType = false;
          }
        }
        if (DateFormat('yyyy-MM-dd').format(user.startingDate) ==
                    DateFormat('yyyy-MM-dd').format(DateTime.now()) &&
                user.renew ||
            isNotSameCredit) {
          GymData(user, collectionName, collectiongYM, creditType, credit);
        }
      }

      final data = user.toMap();
      // final collection = db?.collection(collectionName);

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
      await collectiongYM?.update(
          where
              .eq('plan', collectionName)
              .eq('$collectionName._id', product.id),
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
          if (key == 'productPrice') {
            var gymParam = await GymParamRetrive(collectionName: "Expense");
            if (gymParam.isRight) {
              /////////////////////  check if the data is right

              gymParam.right.peopleIncome.forEach((element) {
                /// here we will remove the expense price from the day income
                /// we will select today total income in order to modify
                if (DateFormat('yyyy-MM-dd').format(element.dateTime) ==
                    DateFormat('yyyy-MM-dd').format(DateTime.now())) {
                  element.dayIncome = element.dayIncome + value.toInt() as int;
                }
              });

              /// here we transform the data to map in order to save it in the databse
              final gymData = gymParam.right.toMap();
              await collectiongYM?.update(
                  where.eq('plan', "Expense"), modify.set("GymParam", gymData));
            }
          }
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

////////////////////// gym expense Databse

  Future<Either<Failure, String>> UpdateExpenseData(
      {required String collectionName, required Expense expense}) async {
    try {
      if (db == null) {
        await connect();
      }
      final collectiongYM = db?.collection(gymCollection);
      var gymParam = await GymParamRetrive(collectionName: "Expense");
      if (gymParam.isRight) {
        /////////////////////  check if the data is right
        var data = gymParam.right.expenses
            .where((element) => element.expenseName == expense.expenseName);
        if (data.isNotEmpty) {
          /// here we check if the
          /// expense we want exist o rnot by name, if yes we edit if not we add it to the list
          data.first.expensePrice = expense.expensePrice;
          data.first.dateTime = expense.dateTime;
        } else {
          /// now if the expense does not exist we add it to the databse

          gymParam.right.expenses.add(expense);
        }
        gymParam.right.peopleIncome.forEach((element) {
          /// here we will remove the expense price from the day income
          /// we will select today total income in order to modify
          if (DateFormat('yyyy-MM-dd').format(element.dateTime) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now())) {
            element.dayIncome = element.dayIncome - expense.expensePrice;
          }
        });

        /// here we transform the data to map in order to save it in the databse
        final gymData = gymParam.right.toMap();
        await collectiongYM?.update(
            where.eq('plan', "Expense"), modify.set("GymParam", gymData));
      }
      return Right('done');
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }

  Future<Either<Failure, GymParam>> RetriveExpense({
    required String collectionName,
  }) async {
    try {
      if (db == null) {
        await connect();
      }
      var gymParam = await GymParamRetrive(collectionName: collectionName);
      if (gymParam.isRight) {
        // final expenses = gymParam.right.expenses;s
        return Right(gymParam.right);
      } else {
        return Left(Failure(
            message: "problem when fetching gym param",
            key: AppError.GettingDataError));
      }
    } catch (e) {
      return Left(Failure(key: AppError.NotFound, message: e.toString()));
    }
  }

  Future<Either<Failure, String>> RemoveExpense(
      {required String collectionName, required Expense expense}) async {
    try {
      if (db == null) {
        await connect();
      }
      final collectiongYM = db?.collection(gymCollection);
      var gymParam = await GymParamRetrive(collectionName: "Expense");
      if (gymParam.isRight) {
        /////////////////////  check if the data is right
        gymParam.right.expenses.remove(expense);

        gymParam.right.peopleIncome.forEach((element) {
          /// here we will remove the expense price from the day income
          /// we will select today total income in order to modify
          if (DateFormat('yyyy-MM-dd').format(element.dateTime) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now())) {
            element.dayIncome = element.dayIncome + expense.expensePrice;
          }
        });

        /// here we transform the data to map in order to save it in the databse
        final gymData = gymParam.right.toMap();
        await collectiongYM?.update(
            where.eq('plan', "Expense"), modify.set("GymParam", gymData));
      }
      return Right('done');
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }

  ////////////////////////////////////////////////////// help functions

  Future GymData(user, collectionName, collectiongYM, bool credittype,
      int oldCredit) async {
    var gymParam = await GymParamRetrive(collectionName: "Expense");
    if (gymParam.isRight) {
      gymParam.right.totalCredit = !credittype
          ? gymParam.right.totalCredit - oldCredit + int.parse(user.credit)
          : gymParam.right.totalCredit + int.parse(user.credit);
      bool cond = gymParam.right.peopleIncome
          .where((element) =>
              DateFormat('yyyy-MM-dd').format(element.dateTime) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now()))
          .isNotEmpty;
      if (cond) {
        gymParam.right.peopleIncome.forEach((element) {
          if (DateFormat('yyyy-MM-dd').format(element.dateTime) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now())) {
            element.dayIncome = element.dayIncome +
                PlanPrices[collectionName]! -
                int.parse(user.credit);
            element.dateTime = DateTime.now();
          }
        });
      } else {
        gymParam.right.peopleIncome.add(PeopleIncome(
            dateTime: DateTime.now(),
            dayIncome: PlanPrices[collectionName]! - int.parse(user.credit)));
      }

      final gymData = gymParam.right.toMap();
      await collectiongYM?.update(
          where.eq('plan', "Expense"), modify.set("GymParam", gymData));
    }
  }

//////////////////////////////////////////////////////////   Rfid card settings
  ///

  Future<Either<Failure, String>> UpdateUserUsingRFID(
      {required String id}) async {
    try {
      if (db == null) {
        await connect();
      }
      String dataBase_Condition = ''; // String to rerutn the databse condition
      final collectiongYM = db?.collection(gymCollection);
      final result = await RetriveDataFDTB();
                bool idFound = false; //

      result!.forEach((element) {
        if (element.keys.toList()[1] == 'plan') {
          /////////  here we eliminate some unwanted data
        } else {
          String planName = element.keys.toList()[
              1]; // this varaible will hold th eplan names automatically
          List users =
              element[planName]; // here we get the list of users of the plan
          users.forEach((user) {
             if (user['_id'] == id) {
                idFound = true;
                //  we check if the user id is the same as the RFID card UID
                if (element.keys.toList()[1] == 'unlimited') {
                  // for unlimited plan has to check to eneding date only
                  DateFormat('yyyy-MM-dd').format(user['endDate']) ==
                          DateFormat('yyyy-MM-dd').format(DateTime.now())
                      ? dataBase_Condition = 'Abonnment ended'
                      : dataBase_Condition = 'session marked';
                } else {
                  if (user['lastCheckDate'] !=
                      DateFormat('yyyy-MM-dd').format(DateTime.now())) {
                    user['isSessionMarked'] = true;
                    user['lastCheckDate'] =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
                    ;

                    user['sessionLeft'] =
                        user['sessionLeft'] <= 0 ? 0 : user['sessionLeft'] - 1;

                    user.forEach((key, value) async {
                      await collectiongYM?.update(
                          // where.eq('_id', user.id), modify.addToSet("hello", {"raouf":"daFFii","test":1}));

                          where
                              .eq('plan', user['plan'])
                              .eq("${user['plan']}._id", user['_id']),
                          modify.set('${user['plan']}.\$.$key', value));
                    });

                    dataBase_Condition = "session marked";

                    ///
                  } else {
                    dataBase_Condition = "user passed before";

                    ///
                  }
                }
              } else {}
            if (idFound) {
             
            } else {
              dataBase_Condition = "try again";
            }
          });
        }
      });

      return Right(dataBase_Condition);
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }
}
