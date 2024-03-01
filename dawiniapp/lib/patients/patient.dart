// ignore_for_file: sized_box_for_whitespace

import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_data_bloc/doctor_data_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Myappointment/previous.dart';
import 'package:dawini_full/patients/today.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Patientslist extends StatefulWidget {
  final String uid;

  const Patientslist({Key? key, required this.uid}) : super(key: key);

  @override
  State<Patientslist> createState() => _PatientslistState();
}

class _PatientslistState extends State<Patientslist>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(length: 2, vsync: this);

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: const Color(0XFFFAFAFA),
              title: Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 200.w,
                height: 30.h,
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Patients list",
                    style: TextStyle(
                        color: Color(0XFF202020),
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito'),
                  ),
                ),
              ),
            ),
            body: BlocBuilder<DoctorPatientsBloc, DoctorPatientsState>(
                builder: (context, state) {
              if (state is doctorInfoLoaded) {
                DoctorEntity doctor = state.doctors
                    .where((element) => element.uid == widget.uid)
                    .toList()
                    .first;
                return SafeArea(
                    child: Container(
                        color: const Color(0XFFFAFAFA),
                        child: Column(children: [
                          TabBar(
                              controller: tabcontroller,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              indicator: UnderlineTabIndicator(
                                  borderSide: BorderSide(
                                      width: 2.w,
                                      color: const Color(0XFF04CBCB)),
                                  insets:
                                      EdgeInsets.symmetric(horizontal: 28.w)),
                              tabs: [
                                Tab(
                                  child: SizedBox(
                                    width: 130.w,
                                    height: 30.h,
                                    child: const FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "Today",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Nunito"),
                                      ),
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    width: 130.w,
                                    height: 30.h,
                                    child: const FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "Tomorrow",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Nunito"),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                          Expanded(
                              child: TabBarView(
                                  controller: tabcontroller,
                                  children: [
                                today(uid: doctor.uid, turn: doctor.turn),
                                previousappointm()
                              ])),
                        ])));
              } else {
                return Loading();
              }
            })));
  }
}
