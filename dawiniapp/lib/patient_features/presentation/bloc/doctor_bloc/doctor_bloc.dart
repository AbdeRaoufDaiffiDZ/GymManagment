// ignore_for_file: void_checks, depend_on_referenced_packages

import 'package:bloc/bloc.dart';

import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:equatable/equatable.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final GetDoctorsInfoUseCase getDoctorsInfoUseCase;
  String? doctorName;
  String? doctorWilaya;
  String? doctorSpeciality;

  DoctorBloc(
    this.getDoctorsInfoUseCase,
  ) : super(DoctorLoading()) {
    on<DoctorEvent>((event, emit) async {
      emit(DoctorLoading());
      if (event is doctorsInfoUpdated) {
        emit(DoctorLoaded());
      } else if (event is onDoctorsearchByspeciality) {
        emit(DoctorLoading());
        doctorSpeciality = event.speciality;

        emit(DoctorFilterSpeciality(
            speciality: doctorSpeciality!,
            doctorWilaya: doctorWilaya,
            doctorName: doctorName));
      } else if (event is onDoctorChoose) {
        emit(ChossenDoctor());
      } else if (event is onDoctorsearchByName) {
        doctorName = event.doctorName;
        emit(DoctorSearchName(
            name: doctorName!,
            doctorWilaya: doctorWilaya,
            doctorSpeciality: doctorSpeciality));
      } else if (event is onDoctorsearchByWilaya) {
        doctorWilaya = event.wilaya;

        emit(FilterByWilaya(
            wilaya: doctorWilaya!,
            doctorName: doctorName,
            doctorSpeciality: doctorSpeciality));
      } else if (event is DoctorinitialEvent) {
        final data = getDoctorsInfoUseCase.getDoctorsInfo();

        add(doctorsInfoUpdated(doctors: await data));
      } else if (event is onSeeAllDoctors) {
        doctorName = null;
        doctorWilaya = null;
        doctorSpeciality = null;
        emit(SeeAllDoctors());
      }
    });
  }
}
