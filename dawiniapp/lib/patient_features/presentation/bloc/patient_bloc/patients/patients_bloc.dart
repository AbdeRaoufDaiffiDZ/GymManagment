// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/domain/usecases/patients_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'patients_event.dart';
part 'patients_state.dart';

class PatientsBloc extends Bloc<PatientsEvent, PatientsState> {
  final GetAppointmentLocalusecase getAppointmentLocalusecase;

  final DeleteDoctorAppointmentUseCase deletAppointmentLocalusecase;
  final BookDoctorAppointmentUseCase bookDoctorAppointmentUseCase;
  final GetFavoriteDoctorsUseCase getfavoriteDoctorsUseCase;
  final SetFavoriteDoctorsUseCase setFavoriteDoctorsUseCase;
  final DeleteFavoriteDoctorsUseCase deleteFavoriteDoctorsUseCase;
  DateTime? lastPressedTime;

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
          if (canPressButton(event.ifADoctor)) {
            saveLastPressedTime();
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
          }
        } catch (e) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              content: Text("try again"), backgroundColor: Colors.red));
          emit(PatientsLoadingError(e.toString()));
        }
      } else if (event is onPatientsAppointmentDelete) {
        try {
          emit(PatientsLoading());

          final result = await deletAppointmentLocalusecase.excute(
              event.patients, event.context);

          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();

          emit(PatientsLoaded(patients));
          if (result) {
            ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
                content: Text("appointment removed sucessusfuly"),
                backgroundColor: Colors.green));
          } else {
            ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
                content: Text("please, try again"),
                backgroundColor: Colors.red));
          }
        } catch (e) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              content: Text("try again"), backgroundColor: Colors.red));
          emit(PatientsLoadingError(e.toString()));
        }
      } else if (event is onSetFavoriteDoctor) {
        try {
          emit(PatientsLoading());

          await setFavoriteDoctorsUseCase.excute(event.doctorUid);

          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoaded(patients));
        } catch (e) {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text("try again"), backgroundColor: Colors.red));
          emit(PatientsLoadingError(e.toString()));
        }
      } else if (event is onDeleteFavoriteDoctor) {
        try {
          emit(PatientsLoading());

          await deleteFavoriteDoctorsUseCase.excute(event.doctorUid);

          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoaded(patients));
        } catch (e) {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text("try again"), backgroundColor: Colors.red));
          emit(PatientsLoadingError(e.toString()));
        }
      }
    });
  }

  void saveLastPressedTime() async {
    // Save to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lastPressedTime", DateTime.now().toString());
  }

  void loadLastPressedTime() async {
    // Load from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lastPressedTime = prefs.getString("lastPressedTime") != null
        ? DateTime.parse(prefs.getString("lastPressedTime")!)
        : null;
  }

  bool canPressButton(ifADoctor) {
    if (lastPressedTime == null) {
      return true;
    } else {
      final difference = DateTime.now().difference(lastPressedTime!);

      return ifADoctor
          ? difference.inSeconds >= 20
          : difference.inMinutes >= 5; // Change 1 to your desired limit
    }
  }
}
