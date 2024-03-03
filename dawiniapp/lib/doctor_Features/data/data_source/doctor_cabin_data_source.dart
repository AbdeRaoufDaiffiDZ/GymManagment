// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dawini_full/core/constants/constants.dart';
import 'package:dawini_full/core/error/exception.dart';
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
  Future<void> turnUpdate(int numberInList, int turn, String numberOfPatients);
  Future<void> updatedoctorState(int numberInList, bool state);
  Future<void> updateDoctorInfo(
      int numberInList, dynamic data, String infoToUpdate);
  Future<List<PatientModel>> patinetsInfo(
    String uid,
    bool today,
  );
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
  Future<List<PatientModel>> patinetsInfo(String uid, bool today) async {
    DateTime now = DateTime.now();

// Add one day to the current date
    DateTime oneDayAdded = now.add(Duration(days: !today ? 1 : 0));

// Format the date string with the desired format
    String formattedDate = DateFormat("yyyy-MM-dd").format(oneDayAdded);

    final result = await _databaseReference
        .ref()
        .child('/user_data/Doctors/$uid/Cabin_info/Patients/$formattedDate')
        .get();
    Map<String, dynamic> convertedMap = {};

    if (result.value != null) {
      List data = result.value as List;
      List dataInfo = data.where((element) => element != null).toList();
      final info = dataInfo.map((e) {
        e.forEach((key, value) {
          if (key is String && value != null) {
            convertedMap[key] = value;
          }
        });

        return PatientModel.fromMap(convertedMap);
      }).toList();
      return info;
    } else {
      final data = [PatientModel.fromMap(convertedMap)];
      return data;
    }
  }

  @override
  Future turnUpdate(int numberInList, int turn, String numberOfPatients) async {
    final data = await patinetsInfo(numberOfPatients, true);
    if (turn < 0) {
      turn = 0;
    } else if (turn > data.length) {
      turn = data.length;
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
}
