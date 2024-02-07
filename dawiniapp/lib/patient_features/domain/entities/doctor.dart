import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final String location;
  final String date;
  final String experience;
  final String description;

  final String uid;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String wilaya;
  final String city;
  final String speciality;
  final bool atSerivce;
  final int turn;

  DoctorEntity(
      {required this.location,
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
  // TODO: implement props
  List<Object?> get props => [
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
}
