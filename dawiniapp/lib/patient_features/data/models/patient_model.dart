// ignore_for_file: overridden_fields, annotate_overrides, non_constant_identifier_names, must_be_immutable

import 'dart:convert';

import 'package:dawini_full/patient_features/domain/entities/patient.dart';

class PatientModel extends PatientEntity {
  final String firstName;
  bool today;

  final String lastName;
  final String phoneNumber;
  final String address;
  final String age;
  final String AppointmentDate;
  int turn;
  final String DoctorName;
  final String uid;

  PatientModel(
      {required this.today,
      required this.uid,
      required this.DoctorName,
      required this.AppointmentDate,
      required this.turn,
      required this.age,
      required this.address,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber})
      : super(
            uid: uid,
            DoctorName: DoctorName,
            today: today,
            AppointmentDate: AppointmentDate,
            turn: turn,
            age: age,
            address: address,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber);

  @override
  List<Object?> get props => [
        today,
        lastName,
        firstName,
        phoneNumber,
        address,
        age,
        AppointmentDate,
        turn,
      ];

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address,
      'age': age,
      'AppointmentDate': AppointmentDate,
      'turn': turn,
      'today': today,
      'uid': uid,
      'DoctorName': DoctorName
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      age: map['age'] ?? '',
      AppointmentDate: map['AppointmentDate'] ?? '',
      turn: map['id']?.toInt() ?? 0,
      uid: map['uid'] ?? "0",
      DoctorName: map['DoctorName'] ?? "0",
      today: map['today'] ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientModel.fromJson(String source) =>
      PatientModel.fromMap(json.decode(source));
}
