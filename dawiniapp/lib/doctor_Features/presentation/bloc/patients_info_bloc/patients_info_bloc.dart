// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
part 'patients_info_event.dart';
part 'patients_info_state.dart';

class PatientsInfoBloc extends Bloc<PatientsInfoEvent, PatientsInfoState> {
  PatientsInfoBloc(PatientsInfoState initialState) : super(initialState) {
    final GetDoctorPatinetsInfousecase getDoctorPatinetsInfo =
        GetDoctorPatinetsInfousecase();
    on<PatientsInfoEvent>((event, emit) async {
      if (event is onGetPatinets) {
        try {
          emit(PatientsInfoLoading());
          // updateDoctorCabinData.updateState(
          //     event.doctor.numberInList, event.state);
          final data =
              await getDoctorPatinetsInfo.excute(event.uid, true); // TODO:

          if (kDebugMode) {
            print(data);
          }
          data.fold((l) async {
            await Future.delayed(const Duration(seconds: 5));

            emit(PatientsInfoLoadingError(l.message.toString()));
          }, (r) => emit(PatientsInfoLoaded(r)));
        } catch (e) {
          emit(PatientsInfoLoadingError(e.toString()));
        }
      }
    });
  }
}
