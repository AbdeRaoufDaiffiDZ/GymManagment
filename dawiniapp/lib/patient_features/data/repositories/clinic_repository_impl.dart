import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/exception.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/data/data_source/remote_data_source.dart';
import 'package:dawini_full/patient_features/domain/entities/clinic.dart';
import 'package:dawini_full/patient_features/domain/repositories/clinic_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClinicRepositoryImpl implements ClinicRepository {
  static final ClinicsRemoteDataSource clinicsRemoteDataSource =
      ClinicsRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<ClinicEntity>>> getClincsInfo() async {
    try {
      final result = await clinicsRemoteDataSource.getClincsInfo();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(message: 'An error has occured'));
    } on SocketException {
      return Left(
          ConnectionFailure(message: 'Failed to connect to the network'));
    }
  }

  @override
  Stream<List<ClinicEntity>> streamClincss() {
    try {
      final result = clinicsRemoteDataSource.streamClincss();
      return result;
    } on ServerException {
      throw ServerFailure(message: 'An error has occured');
    } on SocketException {
      throw ConnectionFailure(message: 'Failed to connect to the network');
    }
  }

  @override
  Future<Either<Failure, UserCredential>> authClinic(email, password) async {
    try {
      final result = await clinicsRemoteDataSource.authClinic(email, password);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AuthenticatinFailure(message: e.code));
    }
  }
}
