import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/repositories/doctor_repository.dart';
import 'package:dawini_full/doctor_Features/data/repositories/doctor_repository_impl.dart';
import 'package:dawini_full/patient_features/data/models/patient_model.dart';

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

  Future<Either<Failure, void>> updateTurn(int numberInList, int turn) {
    return doctorRepository.turnUpdate(numberInList, turn);
  }

  Future<Either<Failure, void>> updateState(int numberInList, bool state) {
    return doctorRepository.updatedoctorState(numberInList, state);
  }

  Future<Either<Failure, void>> updatedoctorData(
      int numberInList, dynamic data, String infoToUpdate) {
    return doctorRepository.updatedoctorData(numberInList, data, infoToUpdate);
  }
}

class GetDoctorPatinetsInfousecase {
  final DoctorRepository doctorRepository = DcotrRepositoryImpl();
  Future<Either<Failure, List<PatientModel>>> excute(
      String uid, bool today) async {
    return doctorRepository.patinetsInfo(uid, today);
  }
}
