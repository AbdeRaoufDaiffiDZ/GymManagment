import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/domain/entities/clinic.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ClinicRepository {
  Future<Either<Failure, List<ClinicEntity>>> getClincsInfo();
  Stream<List<ClinicEntity>> streamClincss();
  Future<Either<Failure, UserCredential>> authClinic(email, password);
}
