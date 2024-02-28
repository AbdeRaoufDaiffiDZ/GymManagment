// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/data/models/patient_model.dart';

abstract class DoctorRepository {
  Future<Either<Failure, List<DoctorEntity>>> getDoctorsInfo();
  Stream<List<DoctorEntity>> streamDoctors();
  Future<Either<Failure, void>> updatedoctorState(int numberInList, bool state);
  Future<Either<Failure, void>> turnUpdate(int numberInList, int turn);
  Future<Either<Failure, void>> updatedoctorData(
      int numberInList, dynamic data, String infoToUpdate);
  Future<Either<Failure, List<PatientModel>>> patinetsInfo(String uid);
}
