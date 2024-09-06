// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class User_Data extends Equatable {
  final String phoneNumber;
  final int buyingCredit;
  final String id;
  final bool renew;
  final bool tapis;
  final String fullName;
  final String plan;
  final String sex;
  String? lastCheckDate;
  DateTime startingDate;
  DateTime endDate;
  String credit;
  int sessionLeft;
  bool isSessionMarked;
  bool isEdit;
  bool isNewUser;

  bool isUncheck;

  User_Data({
    this.isEdit = false,
    this.isUncheck = false,
    this.buyingCredit = 0,
    this.tapis = false,
    this.renew = false,
    this.isNewUser = false,
    required this.phoneNumber,
    required this.lastCheckDate,
    required this.sessionLeft,
    required this.id,
    required this.sex,
    required this.fullName,
    required this.plan,
    required this.startingDate,
    required this.endDate,
    required this.credit,
    this.isSessionMarked = false, // Initialize to false by default
  });

  @override
  List<Object?> get props => [
        isNewUser,
        isEdit,
        isUncheck,
        phoneNumber,
        renew,
        sex,
        tapis,
        buyingCredit,
        lastCheckDate,
        sessionLeft,
        fullName,
        plan,
        startingDate,
        endDate,
        credit,
        id,
        isSessionMarked,
      ];

  factory User_Data.fromMap(Map<String, dynamic> map) {
    late DateTime? startingDate;
    late DateTime? endDate;

    if (map['startingDate'] is String) {
      startingDate = DateTime.parse(map['startingDate']);
    } else {
      startingDate = map['startingDate'];
    }
    if (map['endDate'] is String) {
      endDate = DateTime.parse(map['endDate']);
    } else {
      endDate = map['endDate'];
    }

    return User_Data(
      buyingCredit: map['buyingCredit'] ?? 0,
      tapis: map['tapis'] ?? false,
      sex: map['sex'] ?? 'Male',
      phoneNumber: map['phoneNumber'] ?? '',
      lastCheckDate: map['lastCheckDate'] ?? null,
      sessionLeft: map['sessionLeft'] ?? 0,
      id: map['_id'] ?? '',
      fullName: map['fullName'] ?? '',
      plan: map['plan'] ?? '',
      startingDate: startingDate ?? DateTime.now(),
      endDate: endDate ?? DateTime.now(),
      credit: map['credit'] ?? '',
      isSessionMarked: map['isSessionMarked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'buyingCredit': buyingCredit,
      'tapis': tapis,
      'sex': sex,
      'phoneNumber': phoneNumber,
      'lastCheckDate': lastCheckDate,
      'sessionLeft': sessionLeft,
      '_id': id,
      'fullName': fullName,
      'plan': plan,
      'startingDate': DateFormat('yyyy-MM-dd').format(startingDate),
      'endDate': DateFormat('yyyy-MM-dd').format(endDate),
      'credit': credit,
      'isSessionMarked': isSessionMarked,
    };
  }

  int get daysLeft {
    return endDate.difference(DateTime.now()).inDays;
  }
}
