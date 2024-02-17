import 'package:dartz/dartz.dart';
import 'package:dawini_full/auth/domain/entity/auth_entity.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> signIn(AuthEntity authData);
  Future<Either<Failure, void>> signOutDoctor();
  Future<Either<Failure, UserCredential>> registerDoctor(
    AuthEntity authData,
    DoctorEntity doctordata,
  );
  Future<Either<Failure, void>> forgetPassword(AuthEntity authData);
}
