import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/repositories/doctor_repository.dart';
import 'package:dawini_full/doctor_Features/data/repositories/doctor_repository_impl.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';

class GetDoctorsInfoUseCase {
  final DoctorRepository doctorRepository = DcotrRepositoryImpl();

  Future<List<DoctorEntity>> getDoctorsInfo() async {
    Either<Failure, List<DoctorEntity>> info;
    info = await doctorRepository.getDoctorsInfo();

    return info.fold(
        (l) => throw (ServerFailure(message: l.message)), (r) => r);
  }

  Stream<List<DoctorEntity>> streamDoctorInfo() {
    return doctorRepository.streamDoctors();
  }
}

class GetDoctorsStreamInfoUseCase {}

class UpdateDoctorCabinData {
  final DoctorRepository doctorRepository = DcotrRepositoryImpl();

  Future<Either<Failure, void>> updateTurn(
      int numberInList, int turn, String numberOfPatients) {
    return doctorRepository.turnUpdate(numberInList, turn, numberOfPatients);
  }

  Future<Either<Failure, void>> updateState(
      int numberInList, bool state, DoctorEntity doctor) {
    return doctorRepository.updatedoctorState(numberInList, state, doctor);
  }

  Future<Either<Failure, void>> updatedoctorData(DoctorEntity doctor) {
    return doctorRepository.updatedoctorData(doctor);
  }
}

class GetDoctorPatinetsInfousecase {
  final DoctorRepository doctorRepository = DcotrRepositoryImpl();
  Future<Either<Failure, List<PatientEntity>>> excute(
      String uid, bool today) async {
    return doctorRepository.patinetsInfo(uid, today);
  }
}
