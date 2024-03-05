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
  final bool atSerivce;
  final int turn;

  const DoctorEntity(
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
      required this.phoneNumber});

  @override
  List<Object?> get props => [
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
  DoctorEntity copyWith(
      {numberInList,
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
      uid}) {
    return DoctorEntity(
        numberInList: numberInList ?? this.numberInList,
        location: location ?? this.location,
        date: date ?? this.date,
        experience: experience ?? this.experience,
        description: description ?? this.description,
        uid: uid ?? this.uid,
        city: city ?? this.city,
        turn: turn ?? this.turn,
        speciality: speciality ?? this.speciality,
        atSerivce: atSerivce ?? this.atSerivce,
        wilaya: wilaya ?? this.wilaya,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber);
  }
}
