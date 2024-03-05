// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:dawini_full/auth/data/FirebaseAuth/authentification.dart';
import 'package:flutter/foundation.dart';

part 'doctor_data_event.dart';
part 'doctor_data_state.dart';

class DoctorPatientsBloc
    extends Bloc<DoctorPatientsEvent, DoctorPatientsState> {
  final GetDoctorsInfoUseCase getDoctorsInfoUseCase = GetDoctorsInfoUseCase();
  final UpdateDoctorCabinData updateDoctorCabinData;
  final FirebaseAuthMethods auth0 = FirebaseAuthMethods();

  DoctorPatientsBloc(
      this.updateDoctorCabinData, DoctorPatientsState initialState)
      : super(initialState) {
    on<DoctorPatientsEvent>((event, emit) async {
      if (event is LoadedDataDoctorPatinetsEvent) {
        try {
          final data = await getDoctorsInfoUseCase.getDoctorsInfo();
          if (auth0.user!.uid == "4OCo8desYHfXftOWtkY7DRHRFLm2") {
            auth0.signOut();
          }
          emit(doctorInfoLoaded(data));
        } catch (e) {
          emit(doctorInfoLoadingError(e.toString()));
        }
      } else if (event is onStateUpdate) {
        try {
          updateDoctorCabinData.updateState(
              event.doctor.numberInList, event.state);
          final data = await getDoctorsInfoUseCase.getDoctorsInfo();

          emit(doctorInfoLoaded(data)); //         });
        } catch (e) {
          emit(doctorInfoLoadingError(e.toString()));
        }
      } else if (event is onTurnUpdate) {
        try {
          if (kDebugMode) {
            print("turn updated");
          }
          await updateDoctorCabinData.updateTurn(
              event.doctor.numberInList, event.turn, event.doctor.uid);
          final data = await getDoctorsInfoUseCase.getDoctorsInfo();
          emit(doctorInfoLoaded(data));
        } catch (e) {
          emit(doctorInfoLoadingError(e.toString()));
        }
      }
      // Stream<List<PatientModel>> doctorStream =
      //     doctorCabinDataSource.patinetsInfotest(uid);
    });
  }
}
// else if (event is onStateUpdate) {
//         final result = await updateDoctorCabinData.updateState(
//             event.doctor.numberInList, event.state);

//         result.fold((l) {
//           emit(DoctorLoadingFailure(message: l.message));
//         }, (r) async {
//           emit(DoctorLoaded());
//         });
//       } 
//else if (event is onTurnUpdate) {
//         final result = await updateDoctorCabinData.updateTurn(
//             event.doctor.numberInList, event.turn);
//         result.fold((l) {
//           emit(DoctorLoadingFailure(message: l.message));
//         }, (r) async {
//           emit(DoctorLoaded());
//         });
//       } else if (event is onDataUpdate) {
//         final result = await updateDoctorCabinData.updatedoctorData(
//             event.numberInList, event.data, event.infoToUpdate);
//         result.fold((l) {
//           emit(DoctorLoadingFailure(message: l.message));
//         }, (r) async {
//           emit(DoctorLoaded());
//         });
//       }
