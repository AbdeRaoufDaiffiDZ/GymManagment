// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dawini_full/core/constants/constants.dart';
import 'package:dawini_full/core/error/exception.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/data/data_source/local_data_source.dart';
import 'package:dawini_full/doctor_Features/data/models/doctor_model.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/data/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

abstract class DoctorCabinDataSource {
  Future<List<DoctorModel>> getDoctorsInfo();
  Stream<List<DoctorEntity>> streamDoctors();
  Future<void> turnUpdate(int numberInList, int turn);
  Future<void> updatedoctorState(int numberInList, bool state);
  Future<void> updateDoctorInfo(
      int numberInList, dynamic data, String infoToUpdate);
  Future<List<PatientModel>> patinetsInfo(String uid);
  Stream<List<PatientModel>> patinetsInfotest(String uid);
}

class DoctorCabinDataSourceImp implements DoctorCabinDataSource {
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
  Stream<List<DoctorModel>> streamDoctors() {
    final result =
        _databaseReference.ref().child('doctorsList').onValue.map((event) {
      List currapted = event.snapshot.value as List;
      final data = currapted.map((e) {
        return DoctorModel.fromJson(e);
      }).toList();

      return data;
    });

    return result;
  }

  @override
  Stream<List<PatientModel>> patinetsInfotest(String uid) {
    final result = _databaseReference
        .ref()
        .child(
            '/user_data/Doctors/SBad6UjfzMQDjJcw0nUVEYnnZ2F2/Cabin_info/Patients/2024-02-26')
        .onValue
        .map((event) {
      List currapted = event.snapshot.value as List;
      final data = currapted.where((element) => element != null).map((e) {
        return PatientModel.fromJson(e);
      }).toList();

      return data;
    });

    return result;
    // try {
    //   String date = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
    //   final response =
    //       await client.get(Uri.parse(Urls.DoctorpatientsInfoUrl(uid, date)));

    //   if (response.statusCode == 200) {
    //     List<PatientModel> users =
    //         (json.decode(response.body) as List).map((data) {
    //       return PatientModel.fromJson(data);
    //     }).toList();
    //     return users;
    //   } else {
    //     throw ServerFailure(message: response.statusCode.toString());
    //   }
    // } catch (e) {
    //   throw ServerFailure(message: e.toString());
    // }

    // final DataSnapshot result = await _databaseReference
    //     .ref()
    //     .child('/user_data/Doctors/$uid/Cabin_info/Patients/$datetime')
    //     .get();

    // final data = result.value as List;
    // return data.map((e) {
    //   return PatientModel.fromJson(e);
    // }).toList();
  }

  @override
  Future turnUpdate(int numberInList, int turn) async {
    if (turn < 0) {
      turn = 0;
    } else {
      turn = turn;
    }
    await _databaseReference
        .ref("/doctorsList/$numberInList/")
        .update({"turn": turn})
        .then((value) => print("done!"))
        .catchError((e) => print("error"));
  }

  @override
  Future updatedoctorState(int numberInList, bool state) async {
    await _databaseReference
        .ref()
        .update({"/doctorsList/$numberInList/atSerivce": state})
        .then((value) => print("done!"))
        .catchError((e) => print("error"));
  }

  @override
  Future<void> updateDoctorInfo(
      int numberInList, dynamic data, String infoToUpdate) async {
    await _databaseReference
        .ref()
        .update({"/doctorsList/$numberInList/$infoToUpdate": data})
        .then((value) => print("done!"))
        .catchError((e) => print("error"));
  }

  @override
  Future<List<PatientModel>> patinetsInfo(String uid) {
    // TODO: implement patinetsInfo
    throw UnimplementedError();
  }
}
