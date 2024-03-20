// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final String location;
  final String date;
  final String experience;
  final String description;
  final int numberInList;
  final String uid;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String wilaya;
  final String city;
  final String speciality;
  final int numberOfPatient;
  bool atSerivce;
  int turn;

  DoctorEntity(
      {required this.numberOfPatient,
      required this.numberInList,
      required this.location,
      required this.date,
      required this.experience,
      required this.description,
      required this.uid,
      required this.city,
      required this.turn,
      required this.speciality,
      required this.atSerivce,
      required this.wilaya,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber});

  @override
  List<Object?> get props => [
        numberOfPatient,
        numberInList,
        location,
        date,
        experience,
        description,
        lastName,
        firstName,
        phoneNumber,
        speciality,
        city,
        atSerivce,
        wilaya,
        turn,
        uid
      ];

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'date': date,
      'experience': experience,
      'description': description,
      'numberInList': numberInList,
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'wilaya': wilaya,
      'city': city,
      'speciality': speciality,
      'numberOfPatient': numberOfPatient,
      'atSerivce': atSerivce,
      'turn': turn,
    };
  }

  String toJson() => json.encode(toMap());
}
