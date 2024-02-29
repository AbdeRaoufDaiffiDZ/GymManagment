import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/exception.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/doctor_Features/data/data_source/doctor_cabin_data_source.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/repositories/doctor_repository.dart';
import 'package:dawini_full/patient_features/data/models/patient_model.dart';

class DcotrRepositoryImpl implements DoctorRepository {
  static final DoctorCabinDataSource doctorRemoteDataSource =
      DoctorCabinDataSourceImp();

  @override
  Future<Either<Failure, List<DoctorEntity>>> getDoctorsInfo() async {
    try {
      final result = await doctorRemoteDataSource.getDoctorsInfo();
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
      final result = doctorRemoteDataSource.streamDoctors();
      return result;
    } on ServerException {
      throw const ServerFailure(message: 'An error has occured');
    } on SocketException {
      throw const ConnectionFailure(
          message: 'Failed to connect to the network');
    }
  }

  @override
  Future<Either<Failure, void>> turnUpdate(int numberInList, int turn) async {
    try {
      doctorRemoteDataSource.turnUpdate(numberInList, turn);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatedoctorState(
      int numberInList, bool state) async {
    try {
      doctorRemoteDataSource.updatedoctorState(numberInList, state);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatedoctorData(
      int numberInList, dynamic data, String infoToUpdate) async {
    try {
      doctorRemoteDataSource.updateDoctorInfo(numberInList, data, infoToUpdate);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PatientModel>>> patinetsInfo(
      String uid, bool today) async {
    try {
      final result = await doctorRemoteDataSource.patinetsInfo(uid, today);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(message: 'An error has occured'));
    } on SocketException {
      return const Left(
          ConnectionFailure(message: 'Failed to connect to the network'));
    }
  }
}
