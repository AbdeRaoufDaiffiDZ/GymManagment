import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/doctor_bloc.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/doctorsList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: non_constant_identifier_names
Widget DoctorStateConditions(DoctorState state, List<DoctorEntity> data,
    {required int fontSize, required context}) {
  // ignore: non_constant_identifier_names
  final String Languge = Localizations.localeOf(context).languageCode;
    final AppLocalizations text = AppLocalizations.of(context)!;

  if (Languge == "ar") {
    if (state is DoctorLoading) {
      return const Loading();
    } else if (state is SeeAllDoctors) {
      return Doctors(doctors: data, fontSize: fontSize);
    } else if (state is DoctorLoaded) {
      return Doctors(doctors: data, fontSize: fontSize);
    } else if (state is FilterByWilaya) {
      List<DoctorEntity> doctors;

      if (state.wilaya.isEmpty || state.wilaya == "province") {
        doctors = data;
      } else {
        doctors = data
            .where((element) => element.wilaya
                .toLowerCase()
                .contains(state.wilaya.toLowerCase()))
            .toList();
      }
      if (state.doctorSpeciality != null) {
        if (state.doctorSpeciality!.isEmpty ||
            state.doctorSpeciality == text.all) {
          doctors = doctors;
        } else {
          doctors = doctors
              .where((element) => element.specialityArabic
                  .toLowerCase()
                  .contains(state.doctorSpeciality!.toLowerCase()))
              .toList();
        }
      }
      if (state.doctorName != null) {
        doctors = doctors
            .where((element) => element.lastNameArabic
                .toLowerCase()
                .contains(state.doctorName!.toLowerCase()))
            .toList();
        if (doctors.isEmpty) {
          doctors = doctors
              .where((element) => element.firstNameArabic
                  .toLowerCase()
                  .contains(state.doctorName!.toLowerCase()))
              .toList();
        }
      }
      return Doctors(
        doctors: doctors,
        fontSize: fontSize,
      );
    } else if (state is DoctorSearchName) {
      List<DoctorEntity>? doctors;
      if (state.name.isEmpty) {
        doctors = data;
      } else {
        doctors = data
            .where((element) => element.lastNameArabic
                .toLowerCase()
                .contains(state.name.toLowerCase()))
            .toList();
      }
      if (doctors.isEmpty) {
        doctors = data
            .where((element) => element.firstNameArabic
                .toLowerCase()
                .contains(state.name.toLowerCase()))
            .toList();
      }
      if (state.doctorSpeciality != null) {
        if (state.doctorSpeciality!.isEmpty ||
            state.doctorSpeciality == text.all) {
          doctors = doctors;
        } else {
          doctors = doctors
              .where((element) => element.specialityArabic
                  .toLowerCase()
                  .contains(state.doctorSpeciality!.toLowerCase()))
              .toList();
        }
      }
      if (state.doctorWilaya != null) {
        if (state.doctorWilaya!.isEmpty || state.doctorWilaya == "province") {
          doctors = doctors;
        } else {
          doctors = doctors
              .where((element) => element.wilaya
                  .toLowerCase()
                  .contains(state.doctorWilaya!.toLowerCase()))
              .toList();
        }
      }

      return Doctors(doctors: doctors, fontSize: fontSize);
    } else if (state is DoctorFilterSpeciality) {
      List<DoctorEntity>? doctors;
      if (state.speciality.toLowerCase() == text.all) {
        doctors = data;
      } else {
        doctors = data
            .where((element) => element.specialityArabic
                .toLowerCase()
                .contains(state.speciality.toLowerCase()))
            .toList();
      }

      if (state.doctorName != null) {
        doctors = doctors
            .where((element) => element.lastNameArabic
                .toLowerCase()
                .contains(state.doctorName!.toLowerCase()))
            .toList();
        if (doctors.isEmpty) {
          doctors = doctors
              .where((element) => element.firstNameArabic
                  .toLowerCase()
                  .contains(state.doctorName!.toLowerCase()))
              .toList();
        }
      }
      if (state.doctorWilaya != null) {
        if (state.doctorWilaya!.isEmpty || state.doctorWilaya == "province") {
          doctors = doctors;
        } else {
          doctors = doctors
              .where((element) => element.wilaya
                  .toLowerCase()
                  .contains(state.doctorWilaya!.toLowerCase()))
              .toList();
        }
      }
      return Doctors(doctors: doctors, fontSize: fontSize);
    } else if (state is DoctorLoadingFailure) {
      return ErrorWidget(state.message);
    } else {
      return Container();
    }
  } else if (Languge == "fr") {
    if (state is DoctorLoading) {
      return const Loading();
    } else if (state is SeeAllDoctors) {
      return Doctors(doctors: data, fontSize: fontSize);
    } else if (state is DoctorLoaded) {
      return Doctors(doctors: data, fontSize: fontSize);
    } else if (state is FilterByWilaya) {
      List<DoctorEntity> doctors;

      if (state.wilaya.isEmpty || state.wilaya == 'province') {
        doctors = data;
      } else {
        doctors = data
            .where((element) => element.wilaya
                .toLowerCase()
                .contains(state.wilaya.toLowerCase()))
            .toList();
      }
      if (state.doctorSpeciality != null) {
        if (state.doctorSpeciality!.isEmpty ||
            state.doctorSpeciality == 'all') {
          doctors = doctors;
        } else {
          doctors = doctors
              .where((element) => element.speciality
                  .toLowerCase()
                  .contains(state.doctorSpeciality!.toLowerCase()))
              .toList();
        }
      }
      if (state.doctorName != null) {
        doctors = doctors
            .where((element) => element.lastName
                .toLowerCase()
                .contains(state.doctorName!.toLowerCase()))
            .toList();
        if (doctors.isEmpty) {
          doctors = doctors
              .where((element) => element.firstName
                  .toLowerCase()
                  .contains(state.doctorName!.toLowerCase()))
              .toList();
        }
      }
      return Doctors(
        doctors: doctors,
        fontSize: fontSize,
      );
    } else if (state is DoctorSearchName) {
      List<DoctorEntity>? doctors;
      if (state.name.isEmpty) {
        doctors = data;
      } else {
        doctors = data
            .where((element) => element.lastName
                .toLowerCase()
                .contains(state.name.toLowerCase()))
            .toList();
      }
      if (doctors.isEmpty) {
        doctors = data
            .where((element) => element.firstName
                .toLowerCase()
                .contains(state.name.toLowerCase()))
            .toList();
      }
      if (state.doctorSpeciality != null) {
        if (state.doctorSpeciality!.isEmpty ||
            state.doctorSpeciality == 'all') {
          doctors = doctors;
        } else {
          doctors = doctors
              .where((element) => element.speciality
                  .toLowerCase()
                  .contains(state.doctorSpeciality!.toLowerCase()))
              .toList();
        }
      }
      if (state.doctorWilaya != null) {
        if (state.doctorWilaya!.isEmpty || state.doctorWilaya == 'province') {
          doctors = doctors;
        } else {
          doctors = doctors
              .where((element) => element.wilaya
                  .toLowerCase()
                  .contains(state.doctorWilaya!.toLowerCase()))
              .toList();
        }
      }

      return Doctors(doctors: doctors, fontSize: fontSize);
    } else if (state is DoctorFilterSpeciality) {
      List<DoctorEntity>? doctors;
      if (state.speciality.toLowerCase() == 'all') {
        doctors = data;
      } else {
        doctors = data
            .where((element) => element.speciality
                .toLowerCase()
                .contains(state.speciality.toLowerCase()))
            .toList();
      }

      if (state.doctorName != null) {
        doctors = doctors
            .where((element) => element.lastName
                .toLowerCase()
                .contains(state.doctorName!.toLowerCase()))
            .toList();
        if (doctors.isEmpty) {
          doctors = doctors
              .where((element) => element.firstName
                  .toLowerCase()
                  .contains(state.doctorName!.toLowerCase()))
              .toList();
        }
      }
      if (state.doctorWilaya != null) {
        if (state.doctorWilaya!.isEmpty || state.doctorWilaya == 'province') {
          doctors = doctors;
        } else {
          doctors = doctors
              .where((element) => element.wilaya
                  .toLowerCase()
                  .contains(state.doctorWilaya!.toLowerCase()))
              .toList();
        }
      }
      return Doctors(doctors: doctors, fontSize: fontSize);
    } else if (state is DoctorLoadingFailure) {
      return ErrorWidget(state.message);
    } else {
      return Container();
    }
  } else {
    if (state is DoctorLoading) {
      return const Loading();
    } else if (state is SeeAllDoctors) {
      return Doctors(doctors: data, fontSize: fontSize);
    } else if (state is DoctorLoaded) {
      return Doctors(doctors: data, fontSize: fontSize);
    } else if (state is FilterByWilaya) {
      List<DoctorEntity> doctors;

      if (state.wilaya.isEmpty || state.wilaya == 'province') {
        doctors = data;
      } else {
        doctors = data
            .where((element) => element.wilaya
                .toLowerCase()
                .contains(state.wilaya.toLowerCase()))
            .toList();
      }
      if (state.doctorSpeciality != null) {
        if (state.doctorSpeciality!.isEmpty ||
            state.doctorSpeciality == 'all') {
          doctors = doctors;
        } else {
          doctors = doctors
              .where((element) => element.speciality
                  .toLowerCase()
                  .contains(state.doctorSpeciality!.toLowerCase()))
              .toList();
        }
      }
      if (state.doctorName != null) {
        doctors = doctors
            .where((element) => element.lastName
                .toLowerCase()
                .contains(state.doctorName!.toLowerCase()))
            .toList();
        if (doctors.isEmpty) {
          doctors = doctors
              .where((element) => element.firstName
                  .toLowerCase()
                  .contains(state.doctorName!.toLowerCase()))
              .toList();
        }
      }
      return Doctors(
        doctors: doctors,
        fontSize: fontSize,
      );
    } else if (state is DoctorSearchName) {
      List<DoctorEntity>? doctors;
      if (state.name.isEmpty) {
        doctors = data;
      } else {
        doctors = data
            .where((element) => element.lastName
                .toLowerCase()
                .contains(state.name.toLowerCase()))
            .toList();
      }
      if (doctors.isEmpty) {
        doctors = data
            .where((element) => element.firstName
                .toLowerCase()
                .contains(state.name.toLowerCase()))
            .toList();
      }
      if (state.doctorSpeciality != null) {
        if (state.doctorSpeciality!.isEmpty ||
            state.doctorSpeciality == 'all') {
          doctors = doctors;
        } else {
          doctors = doctors
              .where((element) => element.speciality
                  .toLowerCase()
                  .contains(state.doctorSpeciality!.toLowerCase()))
              .toList();
        }
      }
      if (state.doctorWilaya != null) {
        if (state.doctorWilaya!.isEmpty || state.doctorWilaya == 'province') {
          doctors = doctors;
        } else {
          doctors = doctors
              .where((element) => element.wilaya
                  .toLowerCase()
                  .contains(state.doctorWilaya!.toLowerCase()))
              .toList();
        }
      }

      return Doctors(doctors: doctors, fontSize: fontSize);
    } else if (state is DoctorFilterSpeciality) {
      List<DoctorEntity>? doctors;
      if (state.speciality.toLowerCase() == 'all') {
        doctors = data;
      } else {
        doctors = data
            .where((element) => element.speciality
                .toLowerCase()
                .contains(state.speciality.toLowerCase()))
            .toList();
      }

      if (state.doctorName != null) {
        doctors = doctors
            .where((element) => element.lastName
                .toLowerCase()
                .contains(state.doctorName!.toLowerCase()))
            .toList();
        if (doctors.isEmpty) {
          doctors = doctors
              .where((element) => element.firstName
                  .toLowerCase()
                  .contains(state.doctorName!.toLowerCase()))
              .toList();
        }
      }
      if (state.doctorWilaya != null) {
        if (state.doctorWilaya!.isEmpty || state.doctorWilaya == 'province') {
          doctors = doctors;
        } else {
          doctors = doctors
              .where((element) => element.wilaya
                  .toLowerCase()
                  .contains(state.doctorWilaya!.toLowerCase()))
              .toList();
        }
      }
      return Doctors(doctors: doctors, fontSize: fontSize);
    } else if (state is DoctorLoadingFailure) {
      return ErrorWidget(state.message);
    } else {
      return Container();
    }
  }
}
