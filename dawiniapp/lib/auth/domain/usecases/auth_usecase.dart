import 'package:dartz/dartz.dart';
import 'package:dawini_full/auth/domain/entity/auth_entity.dart';
import 'package:dawini_full/auth/domain/repository/auth_repository.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorAuthStateUseCase {
  final AuthRepository auth;

  DoctorAuthStateUseCase({required this.auth});

  Future<Either<Failure, UserCredential>> signIn(AuthEntity authData) async {
    return auth.signIn(authData);
  }

  Future<Either<Failure, void>> signOutDoctor() async {
    return auth.signOutDoctor();
  }

  Future<Either<Failure, UserCredential>> registerDoctor(
    AuthEntity authData,
    DoctorEntity doctordata,
  ) async {
    return auth.registerDoctor(authData, doctordata);
  }

  Future<Either<Failure, void>> forgetPassword(AuthEntity authData) async {
    return auth.forgetPassword(authData);
  }
}
