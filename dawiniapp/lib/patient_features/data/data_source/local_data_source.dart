// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:dawini_full/patient_features/data/models/patient_model.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSourceDoctors {
  Future<List<PatientModel>> MyDoctorsAppointments();
  Future<String> SetDoctorAppointmentLocal(PatientModel patient);
  Future<String> DeleteDoctorAppointmentLocal(PatientModel patient);

  Future<bool> SetFavoriteDoctors(String doctorUid);
  Future<bool> DeleteFavoriteDoctors(String doctorUid);

  Future<List<String>> MyFavoriteDoctors();
}

class LocalDataSourceImplDoctor extends LocalDataSourceDoctors {
  static final Future<SharedPreferences> prefs =
      SharedPreferences.getInstance();

  @override
  Future<List<PatientModel>> MyDoctorsAppointments() async {
    String datetime =
        DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
    SharedPreferences pref = await prefs;
    String? patientsString = pref.getString('patients');
    if (patientsString == null) {
      return [];
    } else {
      var patientMapList = jsonDecode(patientsString) as List;
      List<PatientModel> patients = patientMapList
          .map((patientMap) => PatientModel.fromJson(patientMap))
          .toList();
      patients.forEach((element) {
        if (element.AppointmentDate == datetime) {
          element.today = true;
        } else {
          element.today = false;
        }
      });
      return patients;
    }
  }

  @override
  Future<bool> SetFavoriteDoctors(String doctorUid) async {
    SharedPreferences pref = await prefs;

    List<String> favorite = await MyFavoriteDoctors();
    try {
      favorite.add(doctorUid);

      pref.setStringList("FavoriteDoctros", favorite);

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  @override
  Future<String> SetDoctorAppointmentLocal(PatientModel patient) async {
    try {
      List<PatientModel> patients = await MyDoctorsAppointments();
      SharedPreferences pref = await prefs;

      patients.add(patient);
      String patientsString = jsonEncode(patients
          .map((patient) => patient.toJson())
          .toList()); // Assuming you have a toJson method in your PatientEntity class
      pref.setString('patients', patientsString);

      return 'Info Saving done';
    } catch (e) {
      throw 'error when saving info Try again please';
    }
  }

  @override
  Future<List<String>> MyFavoriteDoctors() async {
    SharedPreferences pref = await prefs;
    List<String>? patientsString = pref.getStringList('FavoriteDoctros');
    if (patientsString == null) {
      return [];
    } else {
      return patientsString;
    }
  }

  @override
  Future<String> DeleteDoctorAppointmentLocal(PatientModel patient) async {
    try {
      SharedPreferences pref = await prefs;

      List<PatientModel> patients = await MyDoctorsAppointments();
      patients.remove(patient);
      String patientsString = jsonEncode(patients
          .map((patient) => patient.toJson())
          .toList()); // Assuming you have a toJson method in your PatientEntity class
      pref.setString('patients', patientsString);

      return 'patient removed';
    } catch (e) {
      throw 'error when saving info Try again please';
    }
  }

  @override
  Future<bool> DeleteFavoriteDoctors(String doctorUid) async {
    SharedPreferences pref = await prefs;

    List<String> favorite = await MyFavoriteDoctors();
    try {
      favorite.remove(doctorUid);
      pref.setStringList("FavoriteDoctros", favorite);

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }
}
