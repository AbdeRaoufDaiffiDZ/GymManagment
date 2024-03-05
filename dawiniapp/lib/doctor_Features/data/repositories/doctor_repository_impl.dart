import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/exception.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/doctor_Features/data/data_source/doctor_cabin_data_source.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/repositories/doctor_repository.dart';
import 'package:dawini_full/patient_features/data/models/patient_model.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';

class DcotrRepositoryImpl implements DoctorRepository {
  static final DoctorCabinDataSource doctorCabinDataSource =
      DoctorCabinDataSourceImp();

  @override
  Future<Either<Failure, List<DoctorEntity>>> getDoctorsInfo() async {
    try {
      final result = await doctorCabinDataSource.getDoctorsInfo();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(message: 'An error has occured'));
    } on SocketException {
      return const Left(
          ConnectionFailure(message: 'Failed to connect to the network'));
    }
  }

  @override
  Stream<List<DoctorEntity>> streamDoctors() {
    try {
      final result = doctorCabinDataSource.streamDoctors();
      return result;
    } on ServerException {
      throw const ServerFailure(message: 'An error has occured');
    } on SocketException {
      throw const ConnectionFailure(
          message: 'Failed to connect to the network');
    }
  }

  @override
  Future<Either<Failure, void>> turnUpdate(
      int numberInList, int turn, numberOfPatients) async {
    try {
      doctorCabinDataSource.turnUpdate(numberInList, turn, numberOfPatients);
      return const Right(null);
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
  Future<Either<Failure, void>> updatedoctorState(
      int numberInList, bool state) async {
    try {
      doctorCabinDataSource.updatedoctorState(numberInList, state);
      return const Right(null);
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
  Future<Either<Failure, void>> updatedoctorData(
      int numberInList, dynamic data, String infoToUpdate) async {
    try {
      doctorCabinDataSource.updateDoctorInfo(numberInList, data, infoToUpdate);
      return const Right(null);
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
  Future<Either<Failure, List<PatientModel>>> patinetsInfo(
      String uid, bool today) async {
    try {
      final result = await doctorCabinDataSource.patinetsInfo(uid, today);
      return Right(result);
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
}
