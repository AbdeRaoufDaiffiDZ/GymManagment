// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:dawini_full/core/constants/constants.dart';
import 'package:dawini_full/core/error/exception.dart';
import 'package:dawini_full/patient_features/data/data_source/local_data_source.dart';
import 'package:dawini_full/patient_features/data/models/clinic_model.dart';
import 'package:dawini_full/patient_features/data/models/doctor_model.dart';
import 'package:dawini_full/patient_features/data/models/patient_model.dart';
import 'package:dawini_full/patient_features/domain/entities/clinic.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

abstract class DoctorRemoteDataSource {
  Future<List<DoctorModel>> getDoctorsInfo();
  Stream<List<DoctorEntity>> streamDoctors();
  Future<UserCredential> authDoctor(email, password);
  Future<bool> SetDoctorAppointment(PatientModel patientInfo);
  Future<bool> RemoveDoctorAppointment(PatientModel patientInfo);
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  static final http.Client client = http.Client();
  static final FirebaseDatabase _databaseReference = FirebaseDatabase.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final LocalDataSourceDoctors localDataSourcePatients =
      LocalDataSourceImplDoctor();
  @override
  Future<List<DoctorModel>> getDoctorsInfo() async {
    try {
      final response = await client.get(Uri.parse(Urls.doctorInfoUrl()));
      if (response.statusCode == 200) {
        List<DoctorModel> users =
            (json.decode(response.body) as List).map((data) {
          return DoctorModel.fromJson(data);
        }).toList();
        return users;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> SetDoctorAppointment(PatientModel patientInfo) async {
    // DateTime date = DateTime.parse(patientInfo.AppointmentDate);
    final refs = _databaseReference.ref().child(
        "/user_data/Doctors/${patientInfo.uid}/Cabin_info/Patients/${patientInfo.AppointmentDate}");
    final DatabaseReference newChildRef = refs.push();
    final String? idkey = newChildRef.key;
    final DatabaseEvent snapshot =
        await refs.once(); //////////////////////////////////////////////
    final id = snapshot.snapshot.children.length + 1;
    patientInfo.turn = id;
    print(id);
    try {
      await _databaseReference
          .reference()
          .child(
              "/user_data/Doctors/${patientInfo.uid}/Cabin_info/Patients/${patientInfo.AppointmentDate}/$id")
          .set({
        'firstName': patientInfo.firstName,
        'lastName': patientInfo.lastName,
        'phoneNumber': patientInfo.phoneNumber,
        'address': patientInfo.address,
        'Booking_date': patientInfo.AppointmentDate,

        'id': id,
        'idkey': idkey,
        // 'age': patientInfo.age,
      });
      await localDataSourcePatients.SetDoctorAppointmentLocal(
          PatientModel.fromMap(patientInfo.toMap()));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<List<DoctorModel>> streamDoctors() {
    List<DoctorModel> resulted = [];
    final result =
        _databaseReference.ref().child('doctorsList').onValue.map((event) {
      resulted.clear();

      List currapted = event.snapshot.value as List;
      final data = currapted.map((e) {
        return DoctorModel.fromJson(e);
      }).toList();

      return data;
    });

    return result;
  }

  @override
  Future<UserCredential> authDoctor(email, password) async {
    final response =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return response;
  }

  @override
  Future<bool> RemoveDoctorAppointment(PatientModel patientInfo) async {
    await localDataSourcePatients.DeleteDoctorAppointmentLocal(
        PatientModel.fromMap(patientInfo.toMap()));
    return true;
  }
}

abstract class ClinicsRemoteDataSource {
  Future<List<ClinicModel>> getClincsInfo();
  Stream<List<ClinicEntity>> streamClincss();
  Future<UserCredential> authClinic(email, password);
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

  @override
  Future<UserCredential> authClinic(email, password) async {
    final response =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return response;
  }
}
