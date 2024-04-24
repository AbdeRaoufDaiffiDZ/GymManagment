// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final int recommanded;
  final String gender;
  final String location;
  final String date;
  final String experience;
  final int max_number;
  final int numberInList;
  final String uid;
  final String firstName;
  final String lastName;
  String ImageProfileurl;
  final String firstNameArabic;
  final String lastNameArabic;
  final String specialityArabic;
  final String phoneNumber;
  final String wilaya;
  final String city;
  final String speciality;
  final int numberOfPatient;
  bool atSerivce;
  int turn;

  DoctorEntity(
      {required this.gender,required this.firstNameArabic,
      required this.lastNameArabic,
      required this.specialityArabic,
      required this.ImageProfileurl,
      required this.recommanded,
      required this.numberOfPatient,
      required this.numberInList,
      required this.location,
      required this.date,
      required this.experience,
      required this.max_number,
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
  List<Object?> get props => [gender,
        firstName,
        firstNameArabic,
        lastNameArabic,
        specialityArabic,
        ImageProfileurl,
        recommanded,
        numberOfPatient,
        numberInList,
        location,
        date,
        experience,
        max_number,
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
      'gender':gender,
      'ImageProfileurl': ImageProfileurl,
      'firstNameArabic': firstNameArabic,
      'specialityArabic': specialityArabic,
      'lastNameArabic': lastNameArabic,
      'recommanded': recommanded,
      'location': location,
      'date': date,
      'experience': experience,
      'max_number': max_number,
      'numberInList': numberInList,
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'Wilaya': wilaya,
      'city': city,
      'speciality': speciality,
      'numberOfPatient': numberOfPatient,
      'atSerivce': atSerivce,
      'turn': turn,
    };
  }

  String toJson() => json.encode(toMap());
}
