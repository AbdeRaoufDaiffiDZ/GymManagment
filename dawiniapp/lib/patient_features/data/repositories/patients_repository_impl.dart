// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/exception.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/data/data_source/local_data_source.dart';
import 'package:dawini_full/patient_features/data/data_source/remote_data_source.dart';
import 'package:dawini_full/patient_features/data/models/patient_model.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/domain/repositories/patients_repository.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
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
      return const Left(ServerFailure(message: 'An error has occured'));
    } on SocketException {
      return const Left(
          ConnectionFailure(message: 'Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<PatientEntity>>> GetAdoctorAppointment() async {
    try {
      final result = await localDataSourcePatients.MyDoctorsAppointments();
      return Right(result.map((e) => e.toEntity()).toList());
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      switch (e.code) {
        case 'PERMISSION_DENIED':
          return const Left(FirebaseFailure(
              message: "you have no permission to access this data"));
        // bloc.add(const FirebaseErrorEvent.permissionDenied);
        // break;
        case 'DISCONNECTED':
          return const Left(FirebaseFailure(
              message: "please, check your connection and try again"));
        // bloc.add(const FirebaseErrorEvent.disconnected);
        // break;

        default:
          return Left(FirebaseFailure(message: e.message.toString()));
        // bloc.add(const FirebaseErrorEvent.unknown);
        // break;
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Left(ConnectionFailure(message: e.message.toString()));

      // Handle other non-Firebase exceptions
      // print('Unknown error: ${e.toString()}');
      // Consider logging or general error handling
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Left(TimeOutFailure(message: 'Operation timed out: ${e.message}'));
      // print('Operation timed out: ${e.message}');
      // Handle timeouts (e.g., retry the operation)
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Catch other unexpected exceptions
      return Left(UnKnownFailure(message: 'Unknown error: ${e.toString()}'));
      // print('Unknown error: ${e.toString()}');
      // Handle other errors (e.g., log the error for debugging)
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
  Future<bool> DeleteDoctorAppointment(
      PatientEntity patientInfo, context) async {
    try {
      final result = doctorRemoteDataSource.RemoveDoctorAppointment(
          PatientModel.fromMap(patientInfo.toMap()), context);

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
    throw UnimplementedError();
  }
}
