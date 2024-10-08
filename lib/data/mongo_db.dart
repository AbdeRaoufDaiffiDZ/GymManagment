import 'dart:developer';

import 'package:admin/Errors/Failure.dart';
import 'package:admin/const/const.dart';
import 'package:admin/entities/gym_parm_entity.dart';
import 'package:admin/entities/product_entity.dart';
import 'package:admin/entities/user_data_entity.dart';
import 'package:admin/main.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart';

// final Db db = Db('mongodb+srv://raoufdaifi:amin2004@cluster0.cpsnp8o.mongodb.net/');

class MongoDatabase {
  static Db? db;

  static Future<void> connect() async {
    try {
      db = await Db.create(mongoUri);
      await db!.open(secure: true);
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
      {required User_Data user,
      required String collectionName,
      required BuildContext context}) async {
    try {
      if (db == null) {
        await connect();
      }
      final gender = MyInheritedWidget.of(context)?.geneder;
      // final collection = db?.collection(collectionName);
      final collectiongYM = db?.collection(gymCollection + gender.toString());

      // final documentToInsert = {
      //   '_id': user.id, // Assigning a string value to '_id'
      //   'fullName': user.fullName,
      //   'startingDate': user.startingDate,
      //   'plan': user.plan,
      //   'endDate': user.endDate,
      //   'credit': user.credit,
      //   'lastCheckDate': user.lastCheckDate,
      //   'sessionLeft': user.sessionLeft,
      //   'isSessionMarked': user.isSessionMarked
      // };
      final documentToInsert = user.toMap();
      await collectiongYM?.update(where.eq('plan', user.plan),
          modify.addToSet("${user.plan}", documentToInsert));

      GymData(user, collectionName, collectiongYM, 0, context: context);

      // where.eq('plan', user.plan).eq("${user.plan}._id", user.id),
      // modify.set('${user.plan}.\$.$key', value));
      // await collection?.insert(documentToInsert);

      return Right("data setting to mongo done");
    } catch (e) {
      return Left(
          Failure(key: AppError.SettingDataError, message: e.toString()));
    }
  }

  Future<List<Map<String, dynamic>>?> RetriveDataFDTB(String gender) async {
    if (db == null) {
      await connect();
    }
    // final collection = db?.collection(collectionName);
    final collectiongYM = db?.collection(gymCollection + gender);

    final result = await collectiongYM?.find().toList();
    return result!;
  }

  Future<Either<Failure, GymParam>> GymParamRetrive(
      {required String collectionName,
      required BuildContext context,
      String geender = ""}) async {
    try {
      String? gender;
      if (geender == "") {
        gender = MyInheritedWidget.of(context)?.geneder;
      } else {
        gender = geender;
      }
      final dataFDB = (await RetriveDataFDTB(gender!))!;
      final result = dataFDB
          .where((element) => element['plan'] == collectionName)
          .toList();

      if (result.isEmpty) {
        return Right(
            GymParam(plan: collectionName, totalCredit: 0, PlanPrices: {}));
      }
      final Map<String, dynamic>? gymparam = result[0]['GymParam'];
      if (gymparam == null) {
        return Right(
            GymParam(plan: collectionName, totalCredit: 0, PlanPrices: {}));
      }
      return Right(GymParam.fromMap(gymparam));
    } catch (e) {
      return Left(Failure(key: AppError.NotFound, message: e.toString()));
    }
  }

  Future<Either<Failure, List<User_Data>>> RetriveData(
      {required String collectionName, required BuildContext context}) async {
    try {
      final gender = MyInheritedWidget.of(context)?.geneder;
      // if (db == null) {
      //   await connect();
      // }
      // // final collection = db?.collection(collectionName);
      // final collectiongYM = db?.collection(gymCollection);

      // final result = await collectiongYM?.find().toList();
      final dataFDB = (await RetriveDataFDTB(gender!))!;

      final result = dataFDB;

      final List data =
          result.where((element) => element['plan'] == collectionName).toList();
      final List users = data[0][collectionName].toList();
      return Right(users.map((doc) => User_Data.fromMap(doc)).toList());
    } catch (e) {
      return Left(Failure(key: AppError.NotFound, message: e.toString()));
    }
  }

  Future<Either<Failure, String>> DeleteUser(
      {required User_Data user,
      required String collectionName,
      required BuildContext context}) async {
    try {
      if (db == null) {
        await connect();
      }
      final gender = MyInheritedWidget.of(context)?.geneder;
      final collectiongYM = db?.collection(gymCollection + gender.toString());

      final documentToInsert = user.toMap();
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
      {required User_Data user,
      required String collectionName,
      required BuildContext context}) async {
    try {
      if (db == null) {
        await connect();
      }
      final gender = MyInheritedWidget.of(context)?.geneder;
      final collectiongYM = db?.collection(gymCollection + gender.toString());
      final dataUser = await RetriveData(
        collectionName: collectionName,
        context: context,
      );
      if (dataUser.isRight) {
        bool isNotSameCredit = false;

        /// false for Positive, true for negative
        int credit = int.parse((dataUser.right
            .where((element) => element.id == user.id)
            .first
            .credit));
        if (credit != int.parse(user.credit)) {
          isNotSameCredit = true;
        }
        if (user.renew || isNotSameCredit) {
          GymData(user, collectionName, collectiongYM, credit,
              context: context);
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
      {required Product product,
      required String collectionName,
      required BuildContext context}) async {
    try {
      if (db == null) {
        await connect();
      }
      // final collection = db?.collection(collectionName);
      final documentToInsert = product.toMap();
      final gender = MyInheritedWidget.of(context)?.geneder;
      final collectiongYM = db?.collection(gymCollection + "Femme");
      final collectiongYMSecond = db?.collection(gymCollection + "Homme");

      await collectiongYM?.update(where.eq('plan', collectionName),
          modify.addToSet(collectionName, documentToInsert));

      await collectiongYMSecond?.update(where.eq('plan', collectionName),
          modify.addToSet(collectionName, documentToInsert));
      // await collection?.insert(documentToInsert);

      return Right(true);
    } catch (e) {
      return Left(
          Failure(key: AppError.SettingDataError, message: e.toString()));
    }
  }

  Future<Either<Failure, List<Product>>> RetriveProducts(
      {required String collectionName, required BuildContext context}) async {
    try {
      if (db == null) {
        await connect();
      }
      final gender = MyInheritedWidget.of(context)?.geneder;
      final collectiongYM = db?.collection(gymCollection + gender.toString());

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
      {required Product product,
      required String collectionName,
      required BuildContext context}) async {
    try {
      if (db == null) {
        await connect();
      }
      final gender = MyInheritedWidget.of(context)?.geneder;
      final collectiongYM = db?.collection(gymCollection + gender.toString());

      // final documentToInsert = product.toMap();
      final documentToInsert = {
        'productName': product.name,
        'productPrice': product.price,
        '_id': product.id,
        'priceoverview': product.priceoverview,
        'quantityleft': product.quantity,
        'saleRecords': product.saleRecords,
        'priceoverviewfemme': product.priceoverviewfemme,
        'soldHomme': product.soldHomme,
        'soldFemme': product.soldFemme
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
      {required Product product,
      required String collectionName,
      required String? id,
      required BuildContext context}) async {
    try {
      if (db == null) {
        await connect();
      }
      final gender = MyInheritedWidget.of(context)?.geneder;
      final collectiongYMChoosenGender =
          db?.collection(gymCollection + gender.toString());

      final collectiongYM = db?.collection(gymCollection + "Femme");
      final collectiongYMSecond = db?.collection(gymCollection + "Homme");
      final data = product.toMap();
      if (id != null && id != '') {
        var dataReturn = await UpdateUserUsingRFID(
            context: context,
            id: id,
            ISbuyer: true,
            buyingPrice: product.price);
        if (dataReturn.isRight) {
          if (dataReturn.right[2]) {
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
                await collectiongYMSecond?.update(
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
                await collectiongYMSecond?.update(
                    where
                        .eq('plan', collectionName)
                        .eq("$collectionName._id", product.id),
                    modify.set('$collectionName.\$.$key', value));
                if (key == 'productPrice') {
                  var gymParam = await GymParamRetrive(
                      collectionName: "Expense", context: context);
                  if (gymParam.isRight) {
                    /////////////////////  check if the data is right

                    gymParam.right.peopleIncome.forEach((element) {
                      /// here we will remove the expense price from the day income
                      /// we will select today total income in order to modify
                      if (DateFormat('yyyy-MM-dd').format(element.dateTime) ==
                          DateFormat('yyyy-MM-dd').format(DateTime.now())) {
                        element.dayIncome =
                            element.dayIncome + value.toInt() as int;
                      }
                    });

                    /// here we transform the data to map in order to save it in the databse
                    final gymData = gymParam.right.toMap();
                    await collectiongYM?.update(where.eq('plan', "Expense"),
                        modify.set("GymParam", gymData));
                  }
                }
              }
            });

            _showDialog(context, "Product Price Addition Done", Colors.green);
          } else {
            _showDialog(context, "Error, Try Again", Colors.red);
          }
        }
      } else {
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

            await collectiongYMSecond?.update(
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
            await collectiongYMSecond?.update(
                where
                    .eq('plan', collectionName)
                    .eq("$collectionName._id", product.id),
                modify.set('$collectionName.\$.$key', value));
            if (key == 'productPrice') {
              var gymParam = await GymParamRetrive(
                  collectionName: "Expense", context: context);
              if (gymParam.isRight && id == '') {
                /////////////////////  check if the data is right
                bool todayExist = gymParam.right.peopleIncome
                    .where((element) =>
                        DateFormat('yyyy-MM-dd').format(element.dateTime) ==
                        DateFormat('yyyy-MM-dd').format(DateTime.now()))
                    .isNotEmpty;
                if (todayExist) {
                  gymParam.right.peopleIncome.forEach((element) {
                    /// here we will remove the expense price from the day income
                    /// we will select today total income in order to modify
                    if (DateFormat('yyyy-MM-dd').format(element.dateTime) ==
                        DateFormat('yyyy-MM-dd').format(DateTime.now())) {
                      element.dayIncome =
                          element.dayIncome + value.toInt() as int;
                    }
                  });
                } else {
                  gymParam.right.peopleIncome.add(PeopleIncome(
                      dayIncome: value.toInt() as int,
                      dateTime: DateTime.now()));
                }

                /// here we transform the data to map in order to save it in the databse
                final gymData = gymParam.right.toMap();
                await collectiongYMChoosenGender?.update(
                    where.eq('plan', "Expense"),
                    modify.set("GymParam", gymData));
              }
            }
          }
        });
      }

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
      {required String collectionName,
      required Expense expense,
      required BuildContext context,
      Expense? oldExpense = null}) async {
    try {
      if (db == null) {
        await connect();
      }
      final gender = MyInheritedWidget.of(context)?.geneder;
      final collectiongYM = db?.collection(gymCollection + gender.toString());
      var gymParam =
          await GymParamRetrive(collectionName: "Expense", context: context);
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
            int newexpensePrice = 0;
            if (oldExpense != null) {
              if (oldExpense.expensePrice != expense.expensePrice) {
                newexpensePrice =
                    -(oldExpense.expensePrice - expense.expensePrice);
              }
            } else {
              newexpensePrice = expense.expensePrice;
            }
            element.dayIncome = element.dayIncome - newexpensePrice;
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

  Future<Either<Failure, GymParam>> RetriveExpense(
      {required String collectionName, required BuildContext context}) async {
    try {
      if (db == null) {
        await connect();
      }
      var gymParam = await GymParamRetrive(
          collectionName: collectionName, context: context);
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
      {required String collectionName,
      required Expense expense,
      required BuildContext context}) async {
    try {
      if (db == null) {
        await connect();
      }
      final gender = MyInheritedWidget.of(context)?.geneder;
      final collectiongYM = db?.collection(gymCollection + gender.toString());
      var gymParam =
          await GymParamRetrive(collectionName: "Expense", context: context);
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

  Future GymData(User_Data user, collectionName, collectiongYM, int oldCredit,
      {required BuildContext context}) async {
    var gymParam = await GymParamRetrive(
        context: context,
        collectionName: "Expense"); // here we get the Expenses from our databse
    if (gymParam.isRight) {
      int money = oldCredit - int.parse(user.credit);
      if (money == oldCredit) {
// if the old - the new is the same as the old means the new is 0, means the credit has been payed
        gymParam.right.totalCredit = gymParam.right.totalCredit - oldCredit;
      } else if (money < 0) {
        /// if the old - the new is < 0 means there is new credit which is | money|
        gymParam.right.totalCredit = gymParam.right.totalCredit - money;
      } else if (money == 0) {
        /// means the old credit and the new are the same
        gymParam.right.totalCredit = gymParam.right.totalCredit;
      } else if (money < oldCredit && money > 0) {
        /// means the user payed some money
        gymParam.right.totalCredit = gymParam.right.totalCredit - money;
      }
      // gymParam.right.totalCredit =
      //     !credittype // this logic modifies the total creadit eihter by increment or decrement
      //         // if credit is beleow the old one we substract else we  add
      //         ? gymParam.right.totalCredit - oldCredit + int.parse(user.credit)
      //         : gymParam.right.totalCredit + int.parse(user.credit);
      bool cond = gymParam.right.peopleIncome
          .where((element) =>
              DateFormat('yyyy-MM-dd').format(element.dateTime) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now()))
          .isNotEmpty;
      if (cond) {
        gymParam.right.peopleIncome.forEach((element) {
          if (DateFormat('yyyy-MM-dd').format(element.dateTime) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now())) {
// we check if the user has edited his credit or not since the credit is the only editable thing
            /// if yes we increment the income by the credit
            if (user.isEdit) {
              if (money <= oldCredit && money >= 0) {
                element.dayIncome = element.dayIncome + money;
                element.dateTime = DateTime.now();
              }
            } else {
              oldCredit = oldCredit + gymParam.right.PlanPrices[user.plan]!;
              money = oldCredit - int.parse(user.credit);

              if (user.renew) {
                if (money <= oldCredit && money > 0) {
                  // here we check if the old credit has been payed or not old - new = old
                  element.dayIncome = element.dayIncome +
                      money + // here we renew and we add the plan price - what remains from the creadite payment
                      (user.tapis ? gymParam.right.PlanPrices['tapis']! : 0);
                } else {
                  element.dayIncome = element.dayIncome;
                }
              } else if (user.isNewUser) {
                element.dayIncome = element.dayIncome +
                    money + // here we renew and we add the plan price - what remains from the creadite payment
                    (user.tapis ? gymParam.right.PlanPrices['tapis']! : 0);
              }

              element.dateTime = DateTime.now();
            }
          }
        });
      } else {
        if (user.isEdit) {
          if (money <= oldCredit && money >= 0) {
            gymParam.right.peopleIncome
                .add(PeopleIncome(dayIncome: money, dateTime: DateTime.now()));
          }
        } else {
          oldCredit = oldCredit + gymParam.right.PlanPrices[user.plan]!;
          money = oldCredit - int.parse(user.credit);

          if (user.renew) {
            if (money <= oldCredit && money > 0) {
              // here we check if the old credit has been payed or not old - new = old
              gymParam.right.peopleIncome.add(PeopleIncome(
                  dayIncome: money +
                      (user.tapis ? gymParam.right.PlanPrices['tapis']! : 0),
                  dateTime: DateTime.now()));
            } else {
              gymParam.right.peopleIncome
                  .add(PeopleIncome(dayIncome: 0, dateTime: DateTime.now()));
            }
          } else if (user.isNewUser) {

gymParam.right.peopleIncome.add(PeopleIncome(
                  dayIncome: money + // here we renew and we add the plan price - what remains from the creadite payment
                (user.tapis ? gymParam.right.PlanPrices['tapis']! : 0),
                  dateTime: DateTime.now()));   

                
          }

        }

        // oldCredit = oldCredit  + gymParam.right.PlanPrices[user.plan]!;
        // money = oldCredit - int.parse(user.credit);

        // if (money <= oldCredit && money > 0) {
        //   gymParam.right.peopleIncome.add(PeopleIncome(
        //       dateTime: DateTime.now(),
        //       dayIncome: money +
        //           (user.tapis ? gymParam.right.PlanPrices['tapis']! : 0)));
        //   // here we check if the old credit has been payed or not old - new = old
        // } else {
        //   gymParam.right.peopleIncome
        //       .add(PeopleIncome(dateTime: DateTime.now(), dayIncome: 0));
        //   // here we check if the old credit has been payed or not old - new = old
        // }
      }

      final gymData = gymParam.right.toMap();
      await collectiongYM?.update(
          where.eq('plan', "Expense"), modify.set("GymParam", gymData));
    }
  }

//////////////////////////////////////////////////////////////////////
  ///
  void EditIncome(String value,
      {required BuildContext context, String gendeer = ""}) async {
    var gymParam = await GymParamRetrive(
        collectionName: "Expense", context: context, geender: gendeer);
    String? gender;
    if (gendeer == "") {
      gender = MyInheritedWidget.of(context)?.geneder;
    } else {
      gender = gendeer;
    }

    final collectiongYM = db?.collection(gymCollection + gender.toString());

    if (gymParam.isRight) {
      /////////////////////  check if the data is right
      bool todayExist = gymParam.right.peopleIncome
          .where((element) =>
              DateFormat('yyyy-MM-dd').format(element.dateTime) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now()))
          .isNotEmpty;
      if (todayExist) {
        gymParam.right.peopleIncome.forEach((element) {
          /// here we will remove the expense price from the day income
          /// we will select today total income in order to modify
          if (DateFormat('yyyy-MM-dd').format(element.dateTime) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now())) {
            element.dayIncome = double.parse(value).toInt();
          }
        });
      } else {
        gymParam.right.peopleIncome.add(PeopleIncome(
            dayIncome: int.parse(value), dateTime: DateTime.now()));
      }

      /// here we transform the data to map in order to save it in the databse
      final gymData = gymParam.right.toMap();
      await collectiongYM?.update(
          where.eq('plan', "Expense"), modify.set("GymParam", gymData));
    }
  }

//////////////////////////////////////////////////////////   Rfid card settings
  ///

  Future<Either<Failure, List<dynamic>>> UpdateUserUsingRFID(
      {required String id,
      required BuildContext context,
      bool ISbuyer = false,
      double buyingPrice = 0}) async {
    try {
      if (db == null) {
        await connect();
      }
      final gender = MyInheritedWidget.of(context)?.geneder;
      String dataBase_Condition = ''; // String to rerutn the databse condition
      final collectiongYM = db?.collection(gymCollection + gender.toString());
      final result = await RetriveDataFDTB(gender!);
      bool idFound = false; //
      User_Data? userDataToGet;
      bool isFromBuyer = false;
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
              if (ISbuyer) {
                isFromBuyer = true;
                int oldCredit = int.parse(user['credit']);
                user['credit'] =
                    (int.parse(user['credit']) + buyingPrice.toInt())
                        .toString();
                GymData(User_Data.fromMap(user), user['plan'], collectiongYM,
                    oldCredit,
                    context: context);

                user.forEach((key, value) async {
                  await collectiongYM?.update(
                      // where.eq('_id', user.id), modify.addToSet("hello", {"raouf":"daFFii","test":1}));

                      where
                          .eq('plan', user['plan'])
                          .eq("${user['plan']}._id", user['_id']),
                      modify.set('${user['plan']}.\$.$key', value));
                });
              } else {
                if (element.keys.toList()[1] == 'unlimited') {
                  // for unlimited plan has to check to eneding date only
                  user['endDate'] ==
                          DateFormat('yyyy-MM-dd').format(DateTime.now())
                      ? dataBase_Condition = 'Abonnment ended'
                      : dataBase_Condition = 'Unlimited Abonnment';
                } else {
                  if (user['isSessionMarked'] == false) {
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
                userDataToGet = User_Data.fromMap(user);
              }
            } else {}
            if (idFound) {
            } else {
              dataBase_Condition = "try again";
            }
          });
        }
      });
      List dataReturn = [dataBase_Condition, userDataToGet, isFromBuyer];
      return Right(dataReturn);
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }

  void _showDialog(BuildContext context, String message, Color color) {
    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Return the Dialog widget here
        return AlertDialog(
            backgroundColor: Colors.white,
            content: Text(
              message,
              style: TextStyle(color: color, fontSize: 20),
              textAlign: TextAlign.center,
            ));
      },
    );

    // Automatically dismiss after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }

  Future<Either<Failure, String>> eraseAllDate(bool all,
      {required BuildContext context, String gendeer = ""}) async {
    try {
      if (db == null) {
        await connect();
      }
      String? gender;
      if (gendeer == "") {
        gender = MyInheritedWidget.of(context)?.geneder;
      } else {
        gender = gendeer;
      }
      final collectiongYM = db?.collection(gymCollection + gender.toString());
      var data = await RetriveDataFDTB(gender!);
      if (data != null && data.isNotEmpty) {
        if (all) {
          data.forEach((element) async {
            String planname = element['plan'];
            if (planname == "unlimited" ||
                planname == "12 session" ||
                planname == "8 session" ||
                planname == "16 session") {
              // element[element['plan']].forEach((user) async {
              //   await collectiongYM?.update(where.eq('plan', element['plan']),
              //       modify.pull("${element['plan']}", user));
              // });

              final List userMap = element[element['plan']];
              userMap.forEach((usersss) async {
                await collectiongYM?.update(where.eq('plan', usersss['plan']),
                    modify.pull('${usersss['plan']}', usersss));
              });
            } else if (planname == "Prodcuts") {
              element[element['plan']].forEach((product) async {
                await collectiongYM?.update(where.eq('plan', element['plan']),
                    modify.pull("${element['plan']}", product));
              });
            } else if (planname == "Expense") {
              Map<String, int> prices = {};

              if (element["GymParam"]['planPrices'] != null) {
                Map<String, dynamic> planprices =
                    element["GymParam"]['planPrices'];
                planprices.forEach((key, value) {
                  prices.addAll({key: value});
                });
              }
              GymParam gymParam = GymParam(
                  PlanPrices: prices,
                  password: element["GymParam"]['password'],
                  plan: planname,
                  totalCredit: 0);
              final gymData = gymParam.toMap();

              await collectiongYM?.update(
                  where.eq('plan', "Expense"), modify.set("GymParam", gymData));
            }
          });
        } else {
          data.forEach((element) async {
            String planname = element['plan'];
            if (planname == "unlimited" ||
                planname == "12 session" ||
                planname == "8 session" ||
                planname == "16 session") {
              final List userMap = element[element['plan']];
              userMap.forEach((elemenNt) {
                elemenNt["credit"] = "0";
              });
              await collectiongYM?.update(where.eq('plan', element['plan']),
                  modify.set('${element['plan']}', userMap));
            } else if (planname == "Expense") {
              Map<String, int> prices = {};

              if (element["GymParam"]['planPrices'] != null) {
                Map<String, dynamic> planprices =
                    element["GymParam"]['planPrices'];
                planprices.forEach((key, value) {
                  prices.addAll({key: value});
                });
              }
              GymParam gymParam = GymParam(
                  PlanPrices: prices,
                  password: element["GymParam"]['password'],
                  plan: planname,
                  totalCredit: 0);
              final gymData = gymParam.toMap();

              await collectiongYM?.update(
                  where.eq('plan', "Expense"), modify.set("GymParam", gymData));
            }
          });
        }
      }
      return Right('done');
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }

  Future<Either<Failure, String>> ChangePassword(String password,
      {required BuildContext context, required String gender}) async {
    try {
      if (db == null) {
        await connect();
      }
      final collectiongYM = db?.collection(gymCollection + gender.toString());
      var gymParam = await GymParamRetrive(
          collectionName: "Expense", context: context, geender: gender);
      gymParam.right.password = password;
      final gymData = gymParam.right.toMap();
      await collectiongYM?.update(
          where.eq('plan', "Expense"), modify.set("GymParam", gymData));
      return Right('done');
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }
}
/*
import 'dart:developer';

import 'package:admin/Errors/Failure.dart';
import 'package:admin/const/const.dart';
import 'package:admin/data/http_local_data.dart';
import 'package:admin/entities/gym_parm_entity.dart';
import 'package:admin/entities/product_entity.dart';
import 'package:admin/entities/user_data_entity.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart';

// final Db db = Db('mongodb+srv://raoufdaifi:amin2004@cluster0.cpsnp8o.mongodb.net/');

class MongoDatabase {
  static Db? db;
  GetDataFromHttp httpData = GetDataFromHttp();
  static Future<void> connect() async {
    try {
      db = await Db.create(mongoUri);
      await db!.open(secure: true);
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

      // final documentToInsert = {
      //   '_id': user.id, // Assigning a string value to '_id'
      //   'fullName': user.fullName,
      //   'startingDate': user.startingDate,
      //   'plan': user.plan,
      //   'endDate': user.endDate,
      //   'credit': user.credit,
      //   'lastCheckDate': user.lastCheckDate,
      //   'sessionLeft': user.sessionLeft,
      //   'isSessionMarked': user.isSessionMarked
      // };
      final documentToInsert = user.toMap();
      final res = await httpData.SetDataHttp(collectionName: collectionName, data: documentToInsert);
      await collectiongYM?.update(where.eq('plan', user.plan),
          modify.addToSet("${user.plan}", documentToInsert));

      GymData(user, collectionName, collectiongYM, 0);

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
   final data =  await httpData.GetDataHttp();
    // final collection = db?.collection(collectionName);
    // final collectiongYM = db?.collection(gymCollection);
if(data.isRight){
  return data.right!;
}
else {
  return [];

}
    // final result = await collectiongYM?.find().toList();
    // return !;
  }

  Future<Either<Failure, GymParam>> GymParamRetrive(
      {required String collectionName}) async {
    try {
      final dataFDB = (await RetriveDataFDTB())!;
      final result = dataFDB
          .where((element) => element['plan'] == collectionName)
          .toList();

      if (result.isEmpty) {
        return Right(
            GymParam(plan: collectionName, totalCredit: 0, PlanPrices: {}));
      }
      final Map<String, dynamic>? gymparam = result[0]['GymParam'];
      if (gymparam == null) {
        return Right(
            GymParam(plan: collectionName, totalCredit: 0, PlanPrices: {}));
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
      final List users = data[0][collectionName].toList();
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

      final documentToInsert = user.toMap();
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

        /// false for Positive, true for negative
        int credit = int.parse((dataUser.right
            .where((element) => element.id == user.id)
            .first
            .credit));
        if (credit != int.parse(user.credit)) {
          isNotSameCredit = true;
        }
        if (user.renew || isNotSameCredit) {
          GymData(user, collectionName, collectiongYM, credit);
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
      {required Product product,
      required String collectionName,
      required String? id,
      required BuildContext context}) async {
    try {
      if (db == null) {
        await connect();
      }
      final collectiongYM = db?.collection(gymCollection);

      final data = product.toMap();
      if (id != null && id != '') {
        var dataReturn = await UpdateUserUsingRFID(
            id: id, ISbuyer: true, buyingPrice: product.price);
        if (dataReturn.isRight) {
          if (dataReturn.right[2]) {
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
                  var gymParam =
                      await GymParamRetrive(collectionName: "Expense");
                  if (gymParam.isRight) {
                    /////////////////////  check if the data is right

                    gymParam.right.peopleIncome.forEach((element) {
                      /// here we will remove the expense price from the day income
                      /// we will select today total income in order to modify
                      if (DateFormat('yyyy-MM-dd').format(element.dateTime) ==
                          DateFormat('yyyy-MM-dd').format(DateTime.now())) {
                        element.dayIncome =
                            element.dayIncome + value.toInt() as int;
                      }
                    });

                    /// here we transform the data to map in order to save it in the databse
                    final gymData = gymParam.right.toMap();
                    await collectiongYM?.update(where.eq('plan', "Expense"),
                        modify.set("GymParam", gymData));
                  }
                }
              }
            });

            _showDialog(context, "Product Price Addition Done", Colors.green);
          } else {
            _showDialog(context, "Error, Try Again", Colors.red);
          }
        }
      } else {
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
              if (gymParam.isRight && id == '') {
                /////////////////////  check if the data is right
                bool todayExist = gymParam.right.peopleIncome
                    .where((element) =>
                        DateFormat('yyyy-MM-dd').format(element.dateTime) ==
                        DateFormat('yyyy-MM-dd').format(DateTime.now()))
                    .isNotEmpty;
                if (todayExist) {
                  gymParam.right.peopleIncome.forEach((element) {
                    /// here we will remove the expense price from the day income
                    /// we will select today total income in order to modify
                    if (DateFormat('yyyy-MM-dd').format(element.dateTime) ==
                        DateFormat('yyyy-MM-dd').format(DateTime.now())) {
                      element.dayIncome =
                          element.dayIncome + value.toInt() as int;
                    }
                  });
                } else {
                  gymParam.right.peopleIncome.add(PeopleIncome(
                      dayIncome: value.toInt() as int,
                      dateTime: DateTime.now()));
                }

                /// here we transform the data to map in order to save it in the databse
                final gymData = gymParam.right.toMap();
                await collectiongYM?.update(where.eq('plan', "Expense"),
                    modify.set("GymParam", gymData));
              }
            }
          }
        });
      }

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
      {required String collectionName,
      required Expense expense,
      Expense? oldExpense = null}) async {
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
            int newexpensePrice = 0;
            if (oldExpense != null) {
              if (oldExpense.expensePrice != expense.expensePrice) {
                newexpensePrice =
                    -(oldExpense.expensePrice - expense.expensePrice);
              }
            } else {
              newexpensePrice = expense.expensePrice;
            }
            element.dayIncome = element.dayIncome - newexpensePrice;
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

  Future GymData(
      User_Data user, collectionName, collectiongYM, int oldCredit) async {
    var gymParam = await GymParamRetrive(
        collectionName: "Expense"); // here we get the Expenses from our databse
    if (gymParam.isRight) {
      int money = oldCredit - int.parse(user.credit);
      if (money == oldCredit) {
// if the old - the new is the same as the old means the new is 0, means the credit has been payed
        gymParam.right.totalCredit = gymParam.right.totalCredit - oldCredit;
      } else if (money < 0) {
        /// if the old - the new is < 0 means there is new credit which is | money|
        gymParam.right.totalCredit = gymParam.right.totalCredit - money;
      } else if (money == 0) {
        /// means the old credit and the new are the same
        gymParam.right.totalCredit = gymParam.right.totalCredit;
      } else if (money < oldCredit && money > 0) {
        /// means the user payed some money
        gymParam.right.totalCredit = gymParam.right.totalCredit - money;
      }
      // gymParam.right.totalCredit =
      //     !credittype // this logic modifies the total creadit eihter by increment or decrement
      //         // if credit is beleow the old one we substract else we  add
      //         ? gymParam.right.totalCredit - oldCredit + int.parse(user.credit)
      //         : gymParam.right.totalCredit + int.parse(user.credit);
      bool cond = gymParam.right.peopleIncome
          .where((element) =>
              DateFormat('yyyy-MM-dd').format(element.dateTime) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now()))
          .isNotEmpty;
      if (cond) {
        gymParam.right.peopleIncome.forEach((element) {
          if (DateFormat('yyyy-MM-dd').format(element.dateTime) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now())) {
// we check if the user has edited his credit or not since the credit is the only editable thing
            /// if yes we increment the income by the credit
            if (user.isEdit) {
              if (money <= oldCredit && money >= 0) {
                element.dayIncome = element.dayIncome + money;
                element.dateTime = DateTime.now();
              }
            } else {
              oldCredit = oldCredit + gymParam.right.PlanPrices[user.plan]!;
              money = oldCredit - int.parse(user.credit);

              if (user.renew) {
                if (money <= oldCredit && money > 0) {
                  // here we check if the old credit has been payed or not old - new = old
                  element.dayIncome = element.dayIncome +
                      money + // here we renew and we add the plan price - what remains from the creadite payment
                      (user.tapis ? gymParam.right.PlanPrices['tapis']! : 0);
                } else {
                  element.dayIncome = element.dayIncome;
                }
              } else if (user.isNewUser) {
                element.dayIncome = element.dayIncome +
                    money + // here we renew and we add the plan price - what remains from the creadite payment
                    (user.tapis ? gymParam.right.PlanPrices['tapis']! : 0);
              }

              element.dateTime = DateTime.now();
            }
          }
        });
      } else {
        oldCredit = oldCredit + gymParam.right.PlanPrices[user.plan]!;
        money = oldCredit - int.parse(user.credit);

        if (money <= oldCredit && money > 0) {
          gymParam.right.peopleIncome.add(PeopleIncome(
              dateTime: DateTime.now(),
              dayIncome: money +
                  (user.tapis ? gymParam.right.PlanPrices['tapis']! : 0)));
          // here we check if the old credit has been payed or not old - new = old
        } else {
          gymParam.right.peopleIncome
              .add(PeopleIncome(dateTime: DateTime.now(), dayIncome: 0));
          // here we check if the old credit has been payed or not old - new = old
        }
      }

      final gymData = gymParam.right.toMap();
      await collectiongYM?.update(
          where.eq('plan', "Expense"), modify.set("GymParam", gymData));
    }
  }

//////////////////////////////////////////////////////////////////////
  ///
  void EditIncome(String value) async {
    var gymParam = await GymParamRetrive(collectionName: "Expense");
    final collectiongYM = db?.collection(gymCollection);

    if (gymParam.isRight) {
      /////////////////////  check if the data is right
      bool todayExist = gymParam.right.peopleIncome
          .where((element) =>
              DateFormat('yyyy-MM-dd').format(element.dateTime) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now()))
          .isNotEmpty;
      if (todayExist) {
        gymParam.right.peopleIncome.forEach((element) {
          /// here we will remove the expense price from the day income
          /// we will select today total income in order to modify
          if (DateFormat('yyyy-MM-dd').format(element.dateTime) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now())) {
            element.dayIncome = double.parse(value).toInt();
          }
        });
      } else {
        gymParam.right.peopleIncome.add(PeopleIncome(
            dayIncome: int.parse(value), dateTime: DateTime.now()));
      }

      /// here we transform the data to map in order to save it in the databse
      final gymData = gymParam.right.toMap();
      await collectiongYM?.update(
          where.eq('plan', "Expense"), modify.set("GymParam", gymData));
    }
  }

//////////////////////////////////////////////////////////   Rfid card settings
  ///

  Future<Either<Failure, List<dynamic>>> UpdateUserUsingRFID(
      {required String id,
      bool ISbuyer = false,
      double buyingPrice = 0}) async {
    try {
      if (db == null) {
        await connect();
      }
      String dataBase_Condition = ''; // String to rerutn the databse condition
      final collectiongYM = db?.collection(gymCollection);
      final result = await RetriveDataFDTB();
      bool idFound = false; //
      User_Data? userDataToGet;
      bool isFromBuyer = false;
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
              if (ISbuyer) {
                isFromBuyer = true;
                int oldCredit = int.parse(user['credit']);
                user['credit'] =
                    (int.parse(user['credit']) + buyingPrice.toInt())
                        .toString();
                GymData(User_Data.fromMap(user), user['plan'], collectiongYM,
                    oldCredit);

                user.forEach((key, value) async {
                  await collectiongYM?.update(
                      // where.eq('_id', user.id), modify.addToSet("hello", {"raouf":"daFFii","test":1}));

                      where
                          .eq('plan', user['plan'])
                          .eq("${user['plan']}._id", user['_id']),
                      modify.set('${user['plan']}.\$.$key', value));
                });
              } else {
                if (element.keys.toList()[1] == 'unlimited') {
                  // for unlimited plan has to check to eneding date only
                  DateFormat('yyyy-MM-dd').format(user['endDate']) ==
                          DateFormat('yyyy-MM-dd').format(DateTime.now())
                      ? dataBase_Condition = 'Abonnment ended'
                      : dataBase_Condition = 'Unlimited Abonnment';
                } else {
                  if (user['isSessionMarked'] == false) {
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
                userDataToGet = User_Data.fromMap(user);
              }
            } else {}
            if (idFound) {
            } else {
              dataBase_Condition = "try again";
            }
          });
        }
      });
      List dataReturn = [dataBase_Condition, userDataToGet, isFromBuyer];
      return Right(dataReturn);
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }

  void _showDialog(BuildContext context, String message, Color color) {
    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Return the Dialog widget here
        return AlertDialog(
            backgroundColor: Colors.white,
            content: Text(
              message,
              style: TextStyle(color: color, fontSize: 20),
              textAlign: TextAlign.center,
            ));
      },
    );

    // Automatically dismiss after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }

  Future<Either<Failure, String>> eraseAllDate(bool all) async {
    try {
      if (db == null) {
        await connect();
      }

      final collectiongYM = db?.collection(gymCollection);
      var data = await RetriveDataFDTB();
      if (data != null && data.isNotEmpty) {
        if (all) {
          data.forEach((element) async {
            String planname = element['plan'];
            if (planname == "unlimited" ||
                planname == "12 session" ||
                planname == "8 session" ||
                planname == "16 session") {
              // element[element['plan']].forEach((user) async {
              //   await collectiongYM?.update(where.eq('plan', element['plan']),
              //       modify.pull("${element['plan']}", user));
              // });

              final List userMap = element[element['plan']];
              userMap.forEach((usersss) async {
                await collectiongYM?.update(where.eq('plan', usersss['plan']),
                    modify.pull('${usersss['plan']}', usersss));
              });
            } else if (planname == "Prodcuts") {
              element[element['plan']].forEach((product) async {
                await collectiongYM?.update(where.eq('plan', element['plan']),
                    modify.pull("${element['plan']}", product));
              });
            } else if (planname == "Expense") {
              Map<String, int> prices = {};

              if (element["GymParam"]['planPrices'] != null) {
                Map<String, dynamic> planprices =
                    element["GymParam"]['planPrices'];
                planprices.forEach((key, value) {
                  prices.addAll({key: value});
                });
              }
              GymParam gymParam = GymParam(
                  PlanPrices: prices,
                  password: element["GymParam"]['password'],
                  plan: planname,
                  totalCredit: 0);
              final gymData = gymParam.toMap();

              await collectiongYM?.update(
                  where.eq('plan', "Expense"), modify.set("GymParam", gymData));
            }

          });
        } else {
          data.forEach((element) async {
            String planname = element['plan'];
            if (planname == "unlimited" ||
                planname == "12 session" ||
                planname == "8 session" ||
                planname == "16 session") {
              final List userMap = element[element['plan']];
              userMap.forEach((elemenNt) {
                elemenNt["credit"] = "0";
              });
              await collectiongYM?.update(where.eq('plan', element['plan']),
                  modify.set('${element['plan']}', userMap));
            } else if (planname == "Expense") {
              Map<String, int> prices = {};

              if (element["GymParam"]['planPrices'] != null) {
                Map<String, dynamic> planprices =
                    element["GymParam"]['planPrices'];
                planprices.forEach((key, value) {
                  prices.addAll({key: value});
                });
              }
              GymParam gymParam = GymParam(
                  PlanPrices: prices,
                  password: element["GymParam"]['password'],
                  plan: planname,
                  totalCredit: 0);
              final gymData = gymParam.toMap();

              await collectiongYM?.update(
                  where.eq('plan', "Expense"), modify.set("GymParam", gymData));
            }

          });
        }
      }
      return Right('done');
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }

  Future<Either<Failure, String>> ChangePassword(String password) async {
    try {
      if (db == null) {
        await connect();
      }
      final collectiongYM = db?.collection(gymCollection);
      var gymParam = await GymParamRetrive(collectionName: "Expense");
      gymParam.right.password = password;
      final gymData = gymParam.right.toMap();
      await collectiongYM?.update(
          where.eq('plan', "Expense"), modify.set("GymParam", gymData));
      return Right('done');
    } catch (e) {
      return Left(
          Failure(key: AppError.DelettingUserError, message: e.toString()));
    }
  }
}
*/