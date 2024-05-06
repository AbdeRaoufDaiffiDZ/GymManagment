// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages

import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dawini_full/auth/data/FirebaseAuth/authentification.dart';
import 'package:dawini_full/auth/data/models/auth_model.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/domain/usecases/patients_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'patients_event.dart';
part 'patients_state.dart';

class PatientsBloc extends Bloc<PatientsEvent, PatientsState> {
  final GetAppointmentLocalusecase getAppointmentLocalusecase;

  final DeleteDoctorAppointmentUseCase deletAppointmentLocalusecase;
  final BookDoctorAppointmentUseCase bookDoctorAppointmentUseCase;
  final GetFavoriteDoctorsUseCase getfavoriteDoctorsUseCase;
  final SetFavoriteDoctorsUseCase setFavoriteDoctorsUseCase;
  final DeleteFavoriteDoctorsUseCase deleteFavoriteDoctorsUseCase;
  final FirebaseAuthMethods auth0 = FirebaseAuthMethods();

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
          emit(PatientsLoading());
          loadLastPressedTime(uid: event.uid);

          if (canPressButton(event.ifADoctor)) {
            final AuthModel auth = AuthModel(
                email: "deleteAppointment@gmail.com",
                password: "deleteAppointment");

            if (auth0.user == null) {
              auth0.loginWithEmail(authData: auth);
              ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
                  content: Text("try again"), backgroundColor: Colors.red));
              showlDialog(event.context, false, event.ifADoctor, false);
            } else {
              saveLastPressedTime(uid: event.uid);
              final done =
                  await bookDoctorAppointmentUseCase.excute(event.patients);
              if (auth0.user!.uid == "4OCo8desYHfXftOWtkY7DRHRFLm2") {
                auth0.signOut();
              }
              if (done) {
                ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
                    content:
                        Text("Your appointment has been booked successfully"),
                    backgroundColor: Colors.green));
                showlDialog(event.context, true, event.ifADoctor, true);
              } else {
                ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
                    content: Text("try again"), backgroundColor: Colors.red));
                showlDialog(event.context, false, event.ifADoctor, false);
              }
            }
          } else {
            showlDialog(event.context, false, event.ifADoctor, true);
          }
          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoaded(patients));
        } catch (e) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              content: Text("try again"), backgroundColor: Colors.red));
          showlDialog(event.context, false, event.ifADoctor, false);

          emit(PatientsLoadingError(e.toString()));
        }
      } else if (event is onPatientsAppointmentDelete) {
        try {
          emit(PatientsLoading());

          if (auth0.user == null) {
            final AuthModel auth = AuthModel(
                email: "deleteAppointment@gmail.com",
                password: "deleteAppointment");

            auth0.loginWithEmail(authData: auth);
          }

          final result = await deletAppointmentLocalusecase.excute(
              event.patients, event.context);
          if (auth0.user!.uid == "4OCo8desYHfXftOWtkY7DRHRFLm2") {
            auth0.signOut();
          }
          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();

          if (result) {
            ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
                content: Text("appointment removed sucessusfuly"),
                backgroundColor: Colors.green));
          } else {
            ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
                content: Text("please, try again"),
                backgroundColor: Colors.red));
          }
          emit(PatientsLoaded(patients));
        } catch (e) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              content: Text("try again"), backgroundColor: Colors.red));
          emit(PatientsLoadingError(e.toString()));
        }
      } else if (event is onSetFavoriteDoctor) {
        final AppLocalizations text = AppLocalizations.of(event.context)!;

        try {
          emit(PatientsLoading());

          await setFavoriteDoctorsUseCase.excute(event.doctorUid);

          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoaded(patients));
        } catch (e) {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text(text.try_again), backgroundColor: Colors.red));
          emit(PatientsLoadingError(e.toString()));
        }
      } else if (event is onDeleteFavoriteDoctor) {
        final AppLocalizations text = AppLocalizations.of(event.context)!;

        try {
          emit(PatientsLoading());

          await deleteFavoriteDoctorsUseCase.excute(event.doctorUid);

          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoaded(patients));
        } catch (e) {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text(text.try_again), backgroundColor: Colors.red));
          emit(PatientsLoadingError(e.toString()));
        }
      }
    });
  }

  void saveLastPressedTime({required String uid}) async {
    // Save to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lastPressedTime", DateTime.now().toString());
  }

  void loadLastPressedTime({required String uid}) async {
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
          ? difference.inSeconds >= 5
          : difference.inMinutes >= 10; // Change 1 to your desired limit
    }
  }
}

Future<Object?> showlDialog(
  context,
  bool text,
  bool ifADoctor,
  bool done,
) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
    transitionBuilder: (context, a1, a2, widget) {
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      final AppLocalizations locale = AppLocalizations.of(context)!;

      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: ScaleTransition(
          scale: Tween(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.4, end: 1).animate(a1),
            child: AlertDialog(
              title: Center(
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: text
                        ? locale.your_appointment_has_been_booked
                        : locale.your_appointment_has_not_been_booked,
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w800,
                      fontSize: screenWidth * 0.05, // Responsive font size
                      color: const Color.fromRGBO(32, 32, 32, 0.8),
                    ),
                    children: [
                      TextSpan(
                        text: done
                            ? text
                                ? "${locale.successfully} !"
                                : ",${locale.you_already_booked_an_appointment}"
                            : " ",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w900,
                          fontSize: screenWidth * 0.05, // Responsive font size
                          color: text ? const Color(0XFF0AA9A9) : Colors.red,
                        ),
                      ),
                      TextSpan(
                        text: done
                            ? text
                                ? " "
                                : ifADoctor
                                    ? ",${locale.try_again_after_five_sec}"
                                    : ",${locale.try_again_after_ten_sec}"
                            : ", ${locale.try_again_please}",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w800,
                          fontSize: screenWidth * 0.05, // Responsive font size
                          color: const Color.fromRGBO(32, 32, 32, 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              content: SizedBox(
                height: screenHeight * 0.08,
                child: GestureDetector(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                      if (done) {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                          if (Navigator.canPop(context)) {
                            // TODO:
                            Navigator.pop(context);
                          }
                        }
                        // Navigator.pop(context);
                        // Navigator.pop(context);
                        // Navigator.pop(context);
                      }
                    }
                  },
                  child: Container(
                    height: screenHeight * 0.045,
                    decoration: BoxDecoration(
                      color: const Color(0XFF04CBCB),
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    child: Center(
                      child: Text(
                        done ? locale.my_Appointement : locale.try_again,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Nunito",
                          fontSize: screenWidth * 0.05, // Responsive font size
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.025),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      );
    },
  );
}
