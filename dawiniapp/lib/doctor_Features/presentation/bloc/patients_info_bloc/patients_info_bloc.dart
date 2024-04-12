// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
part 'patients_info_event.dart';
part 'patients_info_state.dart';

class PatientsInfoBloc extends Bloc<PatientsInfoEvent, PatientsInfoState> {
  PatientsInfoBloc(PatientsInfoState initialState) : super(initialState) {
    final GetDoctorPatinetsInfousecase getDoctorPatinetsInfo =
        GetDoctorPatinetsInfousecase();
    on<PatientsInfoEvent>((event, emit) async {
      if (event is onGetPatinets) {
        emit(PatientsInfoLoading());
        // updateDoctorCabinData.updateState(
        //     event.doctor.numberInList, event.state);
        final bool today = event.today;
        final data =
            await getDoctorPatinetsInfo.excute(event.uid, today); // TODO:

        if (kDebugMode) {
          print(data);
        }
        data.fold((l)  {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text(l.message),
              backgroundColor: const Color.fromARGB(255, 255, 58, 58)));
          emit(PatientsInfoLoading());
        }, (r) => emit(PatientsInfoLoaded(r)));
      }
    });
  }
}
