import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_bloc/doctor_bloc.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/doctorsList.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget DoctorStateConditions(DoctorState state, List<DoctorEntity> data,
    {required device}) {
  if (state is DoctorLoading) {
    return const Loading();
  } else if (state is SeeAllDoctors) {
    return Doctors(doctors: data, device: device);
  } else if (state is DoctorLoaded) {
    return Doctors(doctors: data, device: device);
  } else if (state is FilterByWilaya) {
    List<DoctorEntity> doctors;

    if (state.wilaya.isEmpty || state.wilaya == 'province') {
      doctors = data;
    } else {
      doctors = data
          .where((element) =>
              element.wilaya.toLowerCase().contains(state.wilaya.toLowerCase()))
          .toList();
    }
    return Doctors(doctors: doctors, device: device);
  } else if (state is DoctorSearchName) {
    List<DoctorEntity>? doctors;
    doctors = data
        .where((element) =>
            element.lastName.toLowerCase().contains(state.name.toLowerCase()))
        .toList();
    if (doctors.isEmpty) {
      doctors = data
          .where((element) => element.firstName
              .toLowerCase()
              .contains(state.name.toLowerCase()))
          .toList();
    }

    return Doctors(doctors: doctors, device: device);
  } else if (state is DoctorFilterSpeciality) {
    final doctors = data
        .where((element) => element.speciality
            .toLowerCase()
            .contains(state.speciality.toLowerCase()))
        .toList();

    return Doctors(doctors: doctors, device: device);
  } else if (state is DoctorLoadingFailure) {
    return ErrorWidget(state.message);
  } else {
    return Container();
  }
}
