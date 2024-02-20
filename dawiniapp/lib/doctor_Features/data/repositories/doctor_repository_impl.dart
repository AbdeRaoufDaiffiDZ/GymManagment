import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/exception.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/doctor_Features/data/data_source/doctor_cabin_data_source.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/repositories/doctor_repository.dart';

class DcotrRepositoryImpl implements DoctorRepository {
  static final DoctorCabinDataSource doctorRemoteDataSource =
      DoctorCabinDataSourceImp();

  @override
  Future<Either<Failure, List<DoctorEntity>>> getDoctorsInfo() async {
    try {
      final result = await doctorRemoteDataSource.getDoctorsInfo();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(message: 'An error has occured'));
    } on SocketException {
      return Left(
          ConnectionFailure(message: 'Failed to connect to the network'));
    }
  }

  @override
  Stream<List<DoctorEntity>> streamDoctors() {
    try {
      final result = doctorRemoteDataSource.streamDoctors();
      return result;
    } on ServerException {
      throw ServerFailure(message: 'An error has occured');
    } on SocketException {
      throw ConnectionFailure(message: 'Failed to connect to the network');
    }
  }

  Future<Either<Failure, void>> turnUpdate(int numberInList, int turn) {}

  Future<Either<Failure, void>> updatedoctorState(
      int numberInList, bool state) {}
}
