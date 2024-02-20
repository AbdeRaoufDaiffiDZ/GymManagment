// ignore_for_file: camel_case_types

import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DoctorCabinInfo extends StatefulWidget {
  final String uid;
  const DoctorCabinInfo({super.key, required this.uid});

  @override
  State<DoctorCabinInfo> createState() => _DoctorCabinInfoState();
}

class _DoctorCabinInfoState extends State<DoctorCabinInfo>
    with TickerProviderStateMixin {
  String datetime = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    // final PatientsBloc patientsBloc = BlocProvider.of<PatientsBloc>(context);

    return Scaffold(
        body: SafeArea(
      child: StreamBuilder<List<DoctorEntity>>(
          stream: GetDoctorsStreamInfoUseCase.excute(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              DoctorEntity doctor = snapshot.requireData
                  .where((element) => element.uid == widget.uid)
                  .toList()
                  .first;

              return SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(doctor.uid.toString()),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(doctor.firstName.toString()),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(doctor.lastName.toString()),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(doctor.speciality.toString()),
                    MaterialButton(onPressed: () {})
                  ],
                ),
              );
            }
            return Loading();
          }),
    ));
  }
}
