// ignore_for_file: non_constant_identifier_names, avoid_print, deprecated_member_use

import 'dart:convert';

import 'package:dawini_full/core/constants/constants.dart';
import 'package:dawini_full/core/error/exception.dart';
import 'package:dawini_full/doctor_Features/data/data_source/doctor_cabin_data_source.dart';
import 'package:dawini_full/patient_features/data/data_source/local_data_source.dart';
import 'package:dawini_full/patient_features/data/models/clinic_model.dart';
import 'package:dawini_full/doctor_Features/data/models/doctor_model.dart';
import 'package:dawini_full/patient_features/data/models/patient_model.dart';
import 'package:dawini_full/patient_features/domain/entities/clinic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

abstract class DoctorRemoteDataSource {
  Future<bool> SetDoctorAppointment(PatientModel patientInfo);
  Future<bool> RemoveDoctorAppointment(PatientModel patientInfo, context);
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final http.Client client = http.Client();
  final FirebaseDatabase _databaseReference = FirebaseDatabase.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final LocalDataSourceDoctors localDataSourcePatients =
      LocalDataSourceImplDoctor();
  final DoctorCabinDataSource doctorCabinDataSource =
      DoctorCabinDataSourceImp();

  @override
  Future<bool> SetDoctorAppointment(PatientModel patientInfo) async {
    // DateTime date = DateTime.parse(patientInfo.AppointmentDate);

    final refs = _databaseReference.ref().child(
        "/user_data/Doctors/${patientInfo.uid}/Cabin_info/Patients/${patientInfo.AppointmentDate}");
    // var data = await getDoctorPatients(patientInfo);
    final DatabaseReference newChildRef = refs.push();
    final String? idkey = newChildRef.key;
    final DatabaseEvent snapshot =
        await refs.once(); //////////////////////////////////////////////
    patientInfo.turn = snapshot.snapshot.children.length + 1;

    // print(patientInfo.turn);
    try {
      await _databaseReference
          .reference()
          .child(
              "/user_data/Doctors/${patientInfo.uid}/Cabin_info/Patients/${patientInfo.AppointmentDate}/${patientInfo.turn}")
          .set({
        'firstName': patientInfo.firstName,
        'lastName': patientInfo.lastName,
        'phoneNumber': patientInfo.phoneNumber,
        'address': patientInfo.address,
        'AppointmentDate': patientInfo.AppointmentDate,
        'age': patientInfo.age,

        'turn': patientInfo.turn,
        'idkey': idkey,
        // 'age': patientInfo.age,
      });

      await localDataSourcePatients.SetDoctorAppointmentLocal(patientInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> RemoveDoctorAppointment(
      PatientModel patientInfo, context) async {
    String uid = "";
    List<DoctorModel> doctors = await doctorCabinDataSource.getDoctorsInfo();
    doctors.where((element) => element.uid == patientInfo.DoctorName);
    // doctorCabinDataSource.getDoctorsInfo().then((value) {
    //   DoctorModel doctor = value.singleWhere(
    //       (element) => element.firstName == patientInfo.DoctorName);
    // });
    uid = patientInfo.uid;

    String date = patientInfo.AppointmentDate;
    String id = patientInfo.turn.toString();
    final bool result = await _databaseReference
        .ref("/user_data/Doctors/$uid/Cabin_info/Patients/$date/$id")
        .remove()
        .then((value) => true)
        .catchError((e) => false);

    if (result) {
      await localDataSourcePatients.DeleteDoctorAppointmentLocal(
          PatientModel.fromMap(patientInfo.toMap()));
      return true;
    } else {
      return false;
    }
  }
}

abstract class ClinicsRemoteDataSource {
  Future<List<ClinicModel>> getClincsInfo();
  Stream<List<ClinicEntity>> streamClincss();
}

class ClinicsRemoteDataSourceImpl implements ClinicsRemoteDataSource {
  static final http.Client client = http.Client();
  static final FirebaseDatabase _databaseReference = FirebaseDatabase.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<List<ClinicModel>> getClincsInfo() async {
    final response = await client.get(Uri.parse(Urls.clinicInfoUrl()));
    if (response.statusCode == 200) {
      List<ClinicModel> users =
          (json.decode(response.body) as List).map((data) {
        return ClinicModel.fromJson(data);
      }).toList();
      return users;
    } else {
      throw ServerException();
    }
  }

  @override
  Stream<List<ClinicModel>> streamClincss() {
    List<ClinicModel> resulted = [];
    final result =
        _databaseReference.ref().child('clinics').onValue.map((event) {
      resulted.clear();

      List currapted = event.snapshot.value as List;
      final data = currapted.map((e) {
        return ClinicModel.fromJson(e);
      }).toList();

      return data;
    });
    return result;
  }
}
