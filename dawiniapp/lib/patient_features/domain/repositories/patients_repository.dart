// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';

abstract class PatientsRepository {
  Future<Either<Failure, List<PatientEntity>>> GetAdoctorAppointment();
  Future<Either<Failure, bool>> DeleteAdoctorAppointment(PatientEntity patient);
  Future<Either<Failure, List<String>>> GetFavoriteDoctors();
  Future<bool> SetFavoriteDoctor(String uid);
  Future<bool> DeleteFavoriteDoctor(String uid);

  Future<bool> SetDoctorAppointment(PatientEntity patientInfo);
  Future<bool> DeleteDoctorAppointment(
    PatientEntity patientInfo,
    context,
  );
}
