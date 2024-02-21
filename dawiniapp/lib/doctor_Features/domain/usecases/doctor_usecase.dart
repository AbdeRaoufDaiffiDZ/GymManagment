import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/repositories/doctor_repository.dart';
import 'package:dawini_full/doctor_Features/data/repositories/doctor_repository_impl.dart';

class GetDoctorsInfoUseCase {
  final DoctorRepository doctorRepository;

  GetDoctorsInfoUseCase({required this.doctorRepository});

  Future<List<DoctorEntity>> excute() async {
    Either<Failure, List<DoctorEntity>> info;
    info = await doctorRepository.getDoctorsInfo();

    return info.fold(
        (l) => throw (ServerFailure(message: l.message)), (r) => r);
  }
}

class GetDoctorsStreamInfoUseCase {
  static final DoctorRepository doctorRepository = DcotrRepositoryImpl();

  static Stream<List<DoctorEntity>> excute() {
    return doctorRepository.streamDoctors();
  }
}

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
