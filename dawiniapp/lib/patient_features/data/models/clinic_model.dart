// ignore_for_file: non_constant_identifier_names, overridden_fields, annotate_overrides

import 'package:dawini_full/patient_features/domain/entities/clinic.dart';

class ClinicModel extends ClinicEntity {
  final String ClinicName;
  final String phoneNumber;
  final String wilaya;
  final String city;
  final String speciality;
  final bool atSerivce;
  final String uid;
  const ClinicModel(
      {required this.uid,
      required this.speciality,
      required this.city,
      required this.atSerivce,
      required this.wilaya,
      required this.ClinicName,
      required this.phoneNumber})
      : super(
            ClinicName: ClinicName,
            city: city,
            atSerivce: atSerivce,
            phoneNumber: phoneNumber,
            wilaya: wilaya,
            uid: uid,
            speciality: speciality);

  @override
  List<Object?> get props =>
      [ClinicName, city, atSerivce, wilaya, phoneNumber, speciality, uid];

  Map<String, dynamic> toMap() {
    return {
      'ClinicName': ClinicName,
      'phoneNumber': phoneNumber,
      'atSerivce': atSerivce,
      'city': city,
      'wilaya': wilaya,
      'uid': uid,
      'speciality': speciality
    };
  }

  factory ClinicModel.fromJson(Map<dynamic, dynamic> json) {
    return ClinicModel(
      ClinicName: json['clinicName'],
      phoneNumber: json['phoneNumber'],
      wilaya: json['Wilaya'],
      city: json[
          'city'], //////////////////////////////////   city must be add to databse
      atSerivce: json['atService'],
      uid: json['uid'],
      speciality: json[
          'speciality'], ///////////////////////////////////////   atService must be add to database
    );
  }

  ClinicEntity toEntity() => ClinicEntity(
      ClinicName: ClinicName,
      phoneNumber: phoneNumber,
      wilaya: wilaya,
      city: city,
      atSerivce: atSerivce,
      speciality: speciality,
      uid: uid);
}
