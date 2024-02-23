// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/domain/usecases/patients_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'patients_event.dart';
part 'patients_state.dart';

class PatientsBloc extends Bloc<PatientsEvent, PatientsState> {
  final GetAppointmentLocalusecase getAppointmentLocalusecase;

  final DeleteDoctorAppointmentUseCase deletAppointmentLocalusecase;
  final BookDoctorAppointmentUseCase bookDoctorAppointmentUseCase;
  final GetFavoriteDoctorsUseCase getfavoriteDoctorsUseCase;
  final SetFavoriteDoctorsUseCase setFavoriteDoctorsUseCase;
  final DeleteFavoriteDoctorsUseCase deleteFavoriteDoctorsUseCase;

  PatientsBloc(
      this.getAppointmentLocalusecase,
      this.deletAppointmentLocalusecase,
      this.bookDoctorAppointmentUseCase,
      this.getfavoriteDoctorsUseCase,
      this.setFavoriteDoctorsUseCase,
      this.deleteFavoriteDoctorsUseCase)
      : super(PatientsLoading()) {
    on<PatientsEvent>((event, emit) async {
      emit(PatientsLoading());
      if (event is PatientsinitialEvent) {
        try {
          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoaded(patients));
        } catch (e) {
          emit(PatientsLoadingError(e.toString()));
        }
      } else if (event is onPatientsReload) {
        try {
          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoaded(patients));
        } catch (e) {
          emit(PatientsLoadingError(e.toString()));
        }
      }

      // else if (event is onPatientsInfoUpdated) {
      //   try {
      //     setAppointmentLocalusecase.excute(event.patients);
      //   } catch (e) {
      //     emit(PatientsLoadingError(e.toString()));
      //   }
      // }
      else if (event is onPatientsSetAppointments) {
        try {
          final done =
              await bookDoctorAppointmentUseCase.excute(event.patients);
          if (done) {
            ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
                content: Text("done"), backgroundColor: Colors.green));
          } else {
            ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
                content: Text("try again"), backgroundColor: Colors.red));
          }
          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoading());
          emit(PatientsLoaded(patients));
        } catch (e) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              content: Text("try again"), backgroundColor: Colors.red));
          emit(PatientsLoadingError(e.toString()));
        }
      } else if (event is onPatientsAppointmentDelete) {
        try {
          final result = await deletAppointmentLocalusecase.excute(
              event.patients, event.context);
          if (result) {
            ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
                content: Text("appointment removed sucessusfuly"),
                backgroundColor: Colors.green));
          } else {
            ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
                content: Text("please, try again"),
                backgroundColor: Colors.red));
          }

          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoading());
          emit(PatientsLoaded(patients));
        } catch (e) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              content: Text("try again"), backgroundColor: Colors.red));
          emit(PatientsLoadingError(e.toString()));
        }
      } else if (event is onSetFavoriteDoctor) {
        try {
          await setFavoriteDoctorsUseCase.excute(event.doctorUid);

          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoading());
          emit(PatientsLoaded(patients));
        } catch (e) {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text("try again"), backgroundColor: Colors.red));
          emit(PatientsLoadingError(e.toString()));
        }
      } else if (event is onDeleteFavoriteDoctor) {
        try {
          await deleteFavoriteDoctorsUseCase.excute(event.doctorUid);

          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoading());
          emit(PatientsLoaded(patients));
        } catch (e) {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text("try again"), backgroundColor: Colors.red));
          emit(PatientsLoadingError(e.toString()));
        }
      }
    });
  }
}
