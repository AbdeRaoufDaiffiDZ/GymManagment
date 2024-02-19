import 'package:dartz/dartz.dart';
import 'package:dawini_full/auth/data/FirebaseAuth/authentification.dart';
import 'package:dawini_full/auth/data/models/auth_model.dart';
import 'package:dawini_full/auth/domain/entity/auth_entity.dart';
import 'package:dawini_full/auth/domain/repository/auth_repository.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImp implements AuthRepository {
  FirebaseAuthMethods firebaseAuthMethods = FirebaseAuthMethods();

  @override
  Future<Either<Failure, void>> forgetPassword(AuthEntity authData) {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserCredential>> registerDoctor(
      AuthEntity authData, DoctorEntity doctordata) {
    return firebaseAuthMethods.signUpWithEmail(
        authData: AuthModel.fromMap(authData.toMap()));
  }

  @override
  Future<Either<Failure, UserCredential>> signIn(AuthEntity authData) {
    return firebaseAuthMethods.loginWithEmail(
        authData: AuthModel.fromMap(authData.toMap()));
  }

  @override
  Future<Either<Failure, void>> signOutDoctor() {
    return firebaseAuthMethods.signOut();
  }
}
