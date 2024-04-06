// ignore_for_file: annotate_overrides, overridden_fields, must_be_immutable

import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';

class DoctorModel extends DoctorEntity {
  final String ImageProfileurl;

  final String firstNameArabic;
  final String lastNameArabic;
  final String specialityArabic;
  final int recommanded;
  final int numberInList;
  final String location;
  final String date;
  final String experience;
  final String description;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String wilaya;
  final String city;
  final String speciality;
  final bool atSerivce;
  final int turn;
  final String uid;
  final int numberOfPatient;
  DoctorModel(
      {required this.firstNameArabic,
      required this.lastNameArabic,
      required this.specialityArabic,
      required this.ImageProfileurl,
      required this.recommanded,
      required this.numberOfPatient,
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
      required this.phoneNumber})
      : super(
            firstNameArabic: firstNameArabic,
            lastNameArabic: lastNameArabic,
            specialityArabic: specialityArabic,
            ImageProfileurl: ImageProfileurl,
            recommanded: recommanded,
            numberOfPatient: numberOfPatient,
            numberInList: numberInList,
            location: location,
            date: date,
            description: description,
            experience: experience,
            uid: uid,
            turn: turn,
            city: city,
            speciality: speciality,
            atSerivce: atSerivce,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            wilaya: wilaya);

  @override
  List<Object?> get props => [
        firstNameArabic,
        lastNameArabic,
        specialityArabic,
        ImageProfileurl,
        numberOfPatient,
        location,
        date,
        experience,
        description,
        lastName,
        firstName,
        phoneNumber,
        turn,
        speciality,
        atSerivce,
        wilaya,
        city,
        uid,
        recommanded
      ];

  Map<String, dynamic> toMap() {
    return {
      'ImageProfileurl': ImageProfileurl,
      'firstNameArabic': firstNameArabic,
      'specialityArabic': specialityArabic,
      'lastNameArabic': lastNameArabic,
      'recommanded': recommanded,
      'numberOfPatient': numberOfPatient,
      'location': location,
      'date': date,
      'experience': experience,
      'description': description,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'atSerivce': atSerivce,
      'speciality': speciality,
      'city': city,
      'Wilaya': wilaya,
      'turn': turn,
      'uid': uid
    };
  }

  factory DoctorModel.fromJson(Map<dynamic, dynamic> json) {
    return DoctorModel(
        recommanded: json['recommanded'] ?? 0,
        numberOfPatient: json['numberOfPatient'] ?? 0,
        numberInList: json['numberInList'] ?? 0,
        firstName: json['firstName'] ?? " ",
        lastName: json['lastName'] ?? " ",
        phoneNumber: json['phoneNumber'] ?? " ",
        wilaya: json['Wilaya'] ?? " ",
        city: json['city'] ??
            " ", //////////////////////////////////   city must be add to databse
        speciality: json['speciality'] ?? " ",
        atSerivce: json['atSerivce'] ??
            " ", ///////////////////////////////////////   atService must be add to database
        turn: json['turn'] ?? " ",
        uid: json['uid'] ?? " ",
        location: json['location'] ?? " ",
        date: json['date'] ?? " ",
        experience: json['experience'] ?? " ",
        description: json['description'] ?? " ",
        firstNameArabic: json['firstNameArabic'] ?? " ",
        lastNameArabic: json['lastNameArabic'] ?? " ",
        ImageProfileurl: json['ImageProfileurl'] ?? " ",
        specialityArabic: json['specialityArabic'] ?? " ");
  }

  DoctorEntity toEntity() => DoctorEntity(
      numberOfPatient: numberOfPatient,
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      wilaya: wilaya,
      city: city,
      speciality: speciality,
      atSerivce: atSerivce,
      turn: turn,
      location: location,
      date: date,
      experience: experience,
      description: description,
      numberInList: numberInList,
      recommanded: recommanded,
      firstNameArabic: firstNameArabic,
      lastNameArabic: lastNameArabic,
      specialityArabic: specialityArabic,
      ImageProfileurl: ImageProfileurl);
}
