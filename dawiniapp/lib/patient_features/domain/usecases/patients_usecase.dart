import 'package:dawini_full/patient_features/data/repositories/patients_repository_impl.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/domain/repositories/patients_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';

class BookDoctorAppointmentUseCase {
  static final PatientsRepository patientsRepository = PatientRepositoryImpl();

  Future<bool> excute(PatientEntity patientEntity) {
    return patientsRepository.SetDoctorAppointment(patientEntity);
  }
}

class DeleteDoctorAppointmentUseCase {
  static final PatientsRepository patientsRepository = PatientRepositoryImpl();

  Future<bool> excute(PatientEntity patientEntity, context) {
    return patientsRepository.DeleteDoctorAppointment(
      patientEntity,
      context,
    );
  }
}

class GetAppointmentLocalusecase {
  final PatientsRepository patientsRepository = PatientRepositoryImpl();

  Future<List<PatientEntity>> excute() async {
    Either<Failure, List<PatientEntity>> info;
    info = await patientsRepository.GetAdoctorAppointment();

    return info.fold(
        (l) => throw (ServerFailure(message: l.message)), (r) => r);
  }
}

class GetFavoriteDoctorsUseCase {
  static final PatientsRepository patientsRepository = PatientRepositoryImpl();

  static Future<List<String>> excute() async {
    Either<Failure, List<String>> info =
        await patientsRepository.GetFavoriteDoctors();

    return info.fold((l) => [], (r) => r);
  }
}

class SetFavoriteDoctorsUseCase {
  static final PatientsRepository patientsRepository = PatientRepositoryImpl();

  Future<bool> excute(String uid) async {
    return await patientsRepository.SetFavoriteDoctor(uid);
  }
}

class DeleteFavoriteDoctorsUseCase {
  static final PatientsRepository patientsRepository = PatientRepositoryImpl();

  Future<bool> excute(String uid) async {
    return await patientsRepository.DeleteFavoriteDoctor(uid);
  }
}
