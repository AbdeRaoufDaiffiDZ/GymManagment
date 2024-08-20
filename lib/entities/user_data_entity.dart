
// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class User_Data extends Equatable {
  final String phoneNumber;
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

  User_Data( { this.tapis =false ,this.renew = false,required this.phoneNumber,required this.lastCheckDate,required this.sessionLeft,
    required this.id,required this.sex,
    required this.fullName,
    required this.plan,
    required this.startingDate,
    required this.endDate,
    required this.credit,
    this.isSessionMarked = false, // Initialize to false by default
  });

  @override
  List<Object?> get props => [phoneNumber,renew,sex,tapis,
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
    return User_Data(
      tapis:map['tapis'] ?? false,
      sex:map['sex'] ?? 'Male',
      renew: map['renew'] ?? false,
      phoneNumber: map['phoneNumber'] ?? '',
      lastCheckDate:map['lastCheckDate'] ?? null,
      sessionLeft: map['sessionLeft'] ?? 0,
      id: map['_id'] ?? ObjectId,
      fullName: map['fullName'] ?? '',
      plan: map['plan'] ?? '',
      startingDate: map['startingDate'] ?? DateTime.now(),
      endDate: map['endDate'] ?? DateTime.now(),
      credit: map['credit'] ?? '',
      isSessionMarked: map['isSessionMarked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tapis':tapis,
      'sex':sex,
      'renew':renew,
      'phoneNumber':phoneNumber,
      'lastCheckDate':lastCheckDate,
      'sessionLeft':sessionLeft,
      '_id': id,
      'fullName': fullName,
      'plan': plan,
      'startingDate': startingDate,
      'endDate': endDate,
      'credit': credit,
      'isSessionMarked': isSessionMarked,
    };
  }
   int get daysLeft {
    return endDate.difference(DateTime.now()).inDays;
  }

}
