import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/doctors/doctorsList.dart';
import 'package:flutter/material.dart';

Widget DoctorStateConditions(DoctorState state, List<DoctorEntity> data) {
  if (state is DoctorLoading) {
    return Loading();
  } else if (state is SeeAllDoctors) {
    return Doctors(
      doctors: data,
    );
  } else if (state is DoctorLoaded) {
    return Doctors(
      doctors: data,
    );
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
    return Doctors(
      doctors: doctors,
    );
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

    return Doctors(
      doctors: doctors,
    );
  } else if (state is DoctorFilterSpeciality) {
    final doctors = data
        .where((element) => element.speciality
            .toLowerCase()
            .contains(state.speciality.toLowerCase()))
        .toList();

    return Doctors(
      doctors: doctors,
    );
  } else if (state is DoctorLoadingFailure) {
    return ErrorWidget(state.message);
  } else {
    return Container();
  }
}
