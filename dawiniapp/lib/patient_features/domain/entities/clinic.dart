import 'package:equatable/equatable.dart';

class ClinicEntity extends Equatable {
  final String ClinicName;
  final String phoneNumber;
  final String wilaya;
  final String city;
  final String speciality;
  final bool atSerivce;
  final String uid;

  ClinicEntity(
      {required this.uid,
      required this.speciality,
      required this.city,
      required this.atSerivce,
      required this.wilaya,
      required this.ClinicName,
      required this.phoneNumber});

  @override
  // TODO: implement props
  List<Object?> get props => [
        ClinicName,
        phoneNumber,
        city,
        atSerivce,
        wilaya,
        uid,
        speciality,
        atSerivce
      ];
}
