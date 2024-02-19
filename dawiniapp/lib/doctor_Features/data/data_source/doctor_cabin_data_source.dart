import 'dart:convert';

import 'package:dawini_full/core/constants/constants.dart';
import 'package:dawini_full/core/error/exception.dart';
import 'package:dawini_full/patient_features/data/data_source/local_data_source.dart';
import 'package:dawini_full/doctor_Features/data/models/doctor_model.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

abstract class DoctorCabinDataSource {
  Future<List<DoctorModel>> getDoctorsInfo();
  Stream<List<DoctorEntity>> streamDoctors();
  Future turnUpdate(int numberInList, int turn);
  Future updatedoctorState(int numberInList, bool state);
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
  Future turnUpdate(int numberInList, int turn) async {
    if (turn < 0) {
      turn = 0;
    } else {
      turn = turn;
    }
    await _databaseReference
        .ref()
        .update({"/doctorsList/$numberInList/numberInList": turn})
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
}
