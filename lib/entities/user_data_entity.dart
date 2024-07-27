// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class User_Data extends Equatable {
  final String id;
  final String fullName;
  final String plan;
   DateTime startingDate;
   DateTime endDate;
  final String credit;

  User_Data({required this.id, 
      required this.fullName,
      required this.plan,
      required this.startingDate,
      required this.endDate,
      required this.credit});
  @override
  List<Object?> get props => [fullName, plan, startingDate, endDate, credit, id];

  factory User_Data.fromMap(Map<String, dynamic> map) {
    return User_Data(
      id: map['_id'] ?? ObjectId,
        fullName: map['fullName'] ?? '',
        plan: map['plan'] ?? '',
        startingDate: map['startingDate'] ?? DateTime.now() ,
        endDate: map['endDate'] ?? DateTime.now(),
        credit: map['credit'] ?? '');
  }
    Map<String, dynamic> toMap() {
    return {
      '_id':id,
      'fullName': fullName,
      'plan': plan,
      'startingDate': startingDate,
      'endDate':endDate,
      'credit':credit
    };
  }
}
