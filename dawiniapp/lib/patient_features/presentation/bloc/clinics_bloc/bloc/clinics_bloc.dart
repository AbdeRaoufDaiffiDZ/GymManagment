import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dawini_full/patient_features/domain/entities/clinic.dart';
import 'package:dawini_full/patient_features/domain/usecases/clinic_usecase.dart';
import 'package:equatable/equatable.dart';

part 'clinics_event.dart';
part 'clinics_state.dart';

class ClinicsBloc extends Bloc<ClinicsEvent, ClinicsState> {
  final GetClinicsInfoUseCase getClinicsInfoUseCase;

  ClinicsBloc({required this.getClinicsInfoUseCase}) : super(ClinicLoading()) {
    on<ClinicsEvent>((event, emit) async {
      emit(ClinicLoading());
      if (event is ClinicInfoUpdated) {
        emit(ClinicLoaded());
      } else if (event is onClinicChoose) {
        emit(ChossenClinic());
      } else if (event is onClinicsearchByName) {
        emit(ClinicsSearchName(name: event.clinicName));
      } else if (event is onClinicsearchByWilaya) {
        emit(FilterByWilayaClinic(wilaya: event.wilaya));
      } else if (event is onSeeAllClinics) {
        emit(SeeAllClinics());
      } else if (event is ClinicinitialEvent) {
        final data = getClinicsInfoUseCase.excute();

        add(ClinicInfoUpdated(clinics: await data));
      }
    });
  }
}
