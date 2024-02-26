// ignore_for_file: non_constant_identifier_names

import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/patient_features/domain/entities/clinic.dart';
import 'package:dawini_full/patient_features/presentation/bloc/clinics_bloc/bloc/clinics_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/clinics/ClinicWidgetList.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/clinics/clinic.dart';
import 'package:flutter/material.dart';

Widget ClinicsStateConditions(ClinicsState state, List<ClinicEntity> data) {
  if (state is ClinicLoading) {
    return const Loading();
  } else if (state is SeeAllClinics) {
    return ClinicWidgetList(
      clinics: data,
    );
  } else if (state is ClinicLoaded) {
    return ClinicWidget(
      clinics: data,
    );
  } else if (state is FilterByWilayaClinic) {
    List<ClinicEntity> clinics;

    if (state.wilaya.isEmpty || state.wilaya == 'province') {
      clinics = data;
    } else {
      clinics = data
          .where((element) =>
              element.wilaya.toLowerCase().contains(state.wilaya.toLowerCase()))
          .toList();
    }
    return ClinicWidgetList(
      clinics: clinics,
    );
  } else if (state is ClinicsSearchName) {
    List<ClinicEntity>? clinics;
    clinics = data
        .where((element) =>
            element.ClinicName.toLowerCase().contains(state.name.toLowerCase()))
        .toList();

    return ClinicWidgetList(
      clinics: clinics,
    );
  } else if (state is ClinicsFilterSpeciality) {
    final clinics = data
        .where((element) => element.speciality // add speciality to clinics
            .toLowerCase()
            .contains(state.speciality.toLowerCase()))
        .toList();

    return ClinicWidgetList(
      clinics: clinics,
    );
  } else if (state is ClinicLoadingFailure) {
    return ErrorWidget(state.message);
  } else {
    return Container();
  }
}
