// ignore_for_file: file_names

import 'package:dawini_full/patient_features/domain/entities/clinic.dart';
import 'package:dawini_full/patient_features/domain/usecases/clinic_usecase.dart';
import 'package:dawini_full/patient_features/presentation/bloc/clinics_bloc/bloc/clinics_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/Condtions/clinic_state_conditions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinicsList extends StatefulWidget {
  const ClinicsList({super.key});

  @override
  State<ClinicsList> createState() => _ClinicsListState();
}

class _ClinicsListState extends State<ClinicsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ClinicEntity>>(
        stream: GetClinicsStreamInfoUseCase.excute(),
        builder: (context, snapshot) {
          late final List<ClinicEntity> data;
          if (snapshot.data == null) {
            data = [];
          } else {
            if (snapshot.data!.isEmpty) {
              data = [];
            } else {
              data = snapshot.data!;
            }
          }
          return BlocBuilder<ClinicsBloc, ClinicsState>(
              builder: (context, state) {
            return ClinicsStateConditions(state, data);
          });
        });
  }
}
