// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/exception.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/data/data_source/local_data_source.dart';
import 'package:dawini_full/patient_features/data/data_source/remote_data_source.dart';
import 'package:dawini_full/patient_features/data/models/patient_model.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/domain/repositories/patients_repository.dart';
import 'package:flutter/foundation.dart';

class PatientRepositoryImpl implements PatientsRepository {
  static final DoctorRemoteDataSource doctorRemoteDataSource =
      DoctorRemoteDataSourceImpl();
  static final LocalDataSourceDoctors localDataSourcePatients =
      LocalDataSourceImplDoctor();

  @override
  Future<Either<Failure, List<String>>> GetFavoriteDoctors() async {
    try {
      final result = await localDataSourcePatients.MyFavoriteDoctors();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(message: 'An error has occured'));
    } on SocketException {
      return Left(
          ConnectionFailure(message: 'Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<PatientEntity>>> GetAdoctorAppointment() async {
    try {
      final result = await localDataSourcePatients.MyDoctorsAppointments();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(message: 'An error has occured'));
    } on SocketException {
      return Left(
          ConnectionFailure(message: 'Failed to connect to the network'));
    }
  }

  @override
  Future<bool> SetFavoriteDoctor(String uid) async {
    try {
      final result = localDataSourcePatients.SetFavoriteDoctors(uid);

      return result;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  @override
  Future<bool> DeleteDoctorAppointment(PatientEntity patientInfo) async {
    try {
      final result = doctorRemoteDataSource.RemoveDoctorAppointment(
          PatientModel.fromMap(patientInfo.toMap()));

      return result;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  @override
  Future<bool> DeleteFavoriteDoctor(String uid) async {
    try {
      final result = localDataSourcePatients.DeleteFavoriteDoctors(uid);

      return result;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  @override
  Future<bool> SetDoctorAppointment(PatientEntity patientInfo) async {
    try {
      final result = doctorRemoteDataSource.SetDoctorAppointment(
          PatientModel.fromMap(patientInfo.toMap()));

      return result;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  @override
  Future<Either<Failure, bool>> DeleteAdoctorAppointment(
      PatientEntity patient) {
    // TODO: implement DeleteAdoctorAppointment
    throw UnimplementedError();
  }
}
