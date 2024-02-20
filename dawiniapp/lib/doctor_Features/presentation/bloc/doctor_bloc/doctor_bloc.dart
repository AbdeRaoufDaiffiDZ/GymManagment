// ignore_for_file: void_checks

import 'package:bloc/bloc.dart';

import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:equatable/equatable.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final GetDoctorsInfoUseCase getDoctorsInfoUseCase;
  final UpdateDoctorCabinData updateDoctorCabinData;
  DoctorBloc(
    this.getDoctorsInfoUseCase,
    this.updateDoctorCabinData,
  ) : super(DoctorLoading()) {
    on<DoctorEvent>((event, emit) async {
      emit(DoctorLoading());
      if (event is doctorsInfoUpdated) {
        emit(DoctorLoaded());
      } else if (event is onDoctorsearchByspeciality) {
        List<DoctorEntity> doctors;

        if (event.speciality.isEmpty || event.speciality == 'all') {
          doctors = event.doctors;
          emit(DoctorLoaded());
        } else {
          doctors = event.doctors
              .where((element) => element.speciality
                  .toLowerCase()
                  .contains(event.speciality.toLowerCase()))
              .toList();
          emit(DoctorFilterSpeciality(
              doctor: doctors, speciality: event.speciality));
        }
      } else if (event is onDoctorChoose) {
        emit(ChossenDoctor());
      } else if (event is onDoctorsearchByName) {
        emit(DoctorSearchName(name: event.doctorName));
      } else if (event is onDoctorsearchByWilaya) {
        emit(FilterByWilaya(wilaya: event.wilaya));
      } else if (event is DoctorinitialEvent) {
        final data = getDoctorsInfoUseCase.excute();

        add(doctorsInfoUpdated(doctors: await data));
      } else if (event is onSeeAllDoctors) {
        emit(SeeAllDoctors());
      } else if (event is onStateUpdate) {
        final result = await updateDoctorCabinData.updateState(
            event.doctor.numberInList, event.state);

        result.fold((l) {
          emit(DoctorLoadingFailure(message: l.message));
        }, (r) async {
          emit(DoctorLoaded());
        });
      } else if (event is onTurnUpdate) {
        final result = await updateDoctorCabinData.updateTurn(
            event.doctor.numberInList, event.turn);
        result.fold((l) {
          emit(DoctorLoadingFailure(message: l.message));
        }, (r) async {
          emit(DoctorLoaded());
        });
      }
    });
  }
}
