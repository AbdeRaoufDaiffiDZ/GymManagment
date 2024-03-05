// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class PatientEntity extends Equatable {
  final String firstName;
  final bool today;
  final String gender;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String age;
  final String AppointmentDate;
  final int turn;
  final String DoctorName;
  final String uid;
  final String token;
  const PatientEntity(
      {required this.token,
      required this.gender,
      required this.DoctorName,
      required this.uid,
      required this.today,
      required this.AppointmentDate,
      required this.turn,
      required this.age,
      required this.address,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber});

  @override
  List<Object?> get props => [
        token,
        gender,
        DoctorName,
        uid,
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
      'token': token,
      'gender': "gender",
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address,
      'age': age,
      'AppointmentDate': AppointmentDate,
      'turn': turn,
      'today': today,
      'DoctorName': DoctorName,
      'uid': uid
    };
  }

  PatientEntity copyWith({
    token,
    gender,
    DoctorName,
    uid,
    today,
    lastName,
    firstName,
    phoneNumber,
    address,
    age,
    AppointmentDate,
    turn,
  }) {
    return PatientEntity(
        token: token ?? this.token,
        gender: gender ?? this.gender,
        DoctorName: DoctorName ?? this.DoctorName,
        uid: uid ?? this.uid,
        today: today ?? this.today,
        AppointmentDate: AppointmentDate ?? this.AppointmentDate,
        turn: turn ?? this.turn,
        age: age ?? this.age,
        address: address ?? this.address,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber);
  }
}
