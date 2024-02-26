// ignore_for_file: annotate_overrides, overridden_fields

import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';

class DoctorModel extends DoctorEntity {
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

  const DoctorModel(
      {required this.numberInList,
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
        uid
      ];

  Map<String, dynamic> toMap() {
    return {
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
      'turn': turn,
      'uid': uid
    };
  }

  factory DoctorModel.fromJson(Map<dynamic, dynamic> json) {
    return DoctorModel(
        numberInList: json['numberInList'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phoneNumber: json['phoneNumber'],
        wilaya: json['Wilaya'],
        city: json[
            'city'], //////////////////////////////////   city must be add to databse
        speciality: json['speciality'],
        atSerivce: json[
            'atSerivce'], ///////////////////////////////////////   atService must be add to database
        turn: json['turn'],
        uid: json['uid'],
        location: json['location'],
        date: json['date'],
        experience: json['experience'],
        description: json['description']);
  }

  DoctorEntity toEntity() => DoctorEntity(
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
      numberInList: numberInList);
}
