// ignore_for_file: camel_case_types, sized_box_for_whitespace

import 'package:dawini_full/core/error/ErrorWidget.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class previousappointm extends StatefulWidget {
  final int fontSize;

  const previousappointm({super.key, required this.fontSize});

  @override
  State<previousappointm> createState() => _previousappointmState();
}

class _previousappointmState extends State<previousappointm> {
  @override
  Widget build(BuildContext context) {
    final GetDoctorsInfoUseCase getDoctorsInfoUseCase = GetDoctorsInfoUseCase();
    final AppLocalizations text = AppLocalizations.of(context)!;
    bool isMale = true;
    return Scaffold(
      backgroundColor: const Color(0XFFFAFAFA),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
          child: BlocBuilder<PatientsBloc, PatientsState>(
              builder: (context, state) {
            if (state is PatientsLoaded) {
              String datetime =
                  DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
              String datetimeTomorrow = DateFormat("yyyy-MM-dd")
                  .format(DateTime.now().add(const Duration(days: 1)))
                  .toString();
              final dataa = state.patients
                  .where((element) => element.AppointmentDate != datetime)
                  .toList();
              final data = dataa
                  .where(
                      (element) => element.AppointmentDate != datetimeTomorrow)
                  .toList();
              final bool isArabic =
                  Localizations.localeOf(context).languageCode == "ar";
              if (data.isEmpty) {
                // No appointments for today or tomorrow
                return Center(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 60.w),
                        height: 209.h,
                        width: 175.w,
                        child: Image.asset(
                          "assets/images/Group 43.png",
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20.h),
                          width: 240,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: Text(
                              text.noPreviousAppointments,
                              style: TextStyle(
                                  color: Color(0Xff202020),
                                  fontFamily: "Nunito",
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800),
                            ),
                          ))
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return StreamBuilder<List<DoctorEntity>>(
                        stream: getDoctorsInfoUseCase.streamDoctorInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Loading();
                          }
                          if (snapshot.hasError) {
                            return ErrorPage(
                              error: snapshot.error,
                            );
                            // Text('Error: ${snapshot.error}');
                          }
                          late final List<DoctorEntity> doctor;
                          if (snapshot.data == null) {
                            doctor = [];
                          } else {
                            if (snapshot.data!.isEmpty) {
                              doctor = [];
                            } else {
                              doctor = snapshot.data!;
                            }
                          }
                          List<DoctorEntity> doctors = doctor
                              .where(
                                  (element) => element.uid == data[index].uid)
                              .toList();
                          if (doctors.isNotEmpty) {
                            isMale =
                                doctors.first.gender == "male" ? true : false;

                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 9.h),
                                  child: Container(
                                    height: 130.h,
                                    width: 320.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0XFF202020)
                                                .withOpacity(0.1)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.h, horizontal: 8.w),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  width: 150.w,
                                                  height: 25.h,
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment: isArabic
                                                        ? Alignment.topRight
                                                        : Alignment.topLeft,
                                                    child: Text(
                                                        "${text.dr}. ${isArabic ? doctors.first.lastNameArabic : doctors.first.lastName}",
                                                        style: TextStyle(
                                                            fontSize: 19.sp -
                                                                widget.fontSize
                                                                    .sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Color(
                                                                0XFF202020))),
                                                  ),
                                                ),
                                                Container(
                                                  width: 80.w,
                                                  height: 20.h,
                                                  child: FittedBox(
                                                    alignment: isArabic
                                                        ? Alignment.topRight
                                                        : Alignment.topLeft,
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        isArabic
                                                            ? doctors.first
                                                                .specialityArabic
                                                            : doctors.first
                                                                .speciality,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: 18.sp -
                                                                widget.fontSize
                                                                    .sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0XFF202020))),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      size: 13.h,
                                                      color: const Color(
                                                              0XFF202020)
                                                          .withOpacity(0.6),
                                                    ),
                                                    FittedBox(
                                                      alignment: isArabic
                                                          ? Alignment.topRight
                                                          : Alignment.topLeft,
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                          '${doctors.first.city}, ${doctors.first.wilaya}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              fontSize: 15.sp -
                                                                  widget
                                                                      .fontSize
                                                                      .sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: const Color(
                                                                  0XFF202020))),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        ),
                                        // Padding(
                                        //   padding:
                                        //       EdgeInsets.only(left: 5.w, top: 8.h),
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.start,
                                        //     children: [
                                        //       Container(
                                        //         height: 100.h,
                                        //         width: 120.w,
                                        //         decoration: BoxDecoration(
                                        //             color: const Color.fromRGBO(
                                        //                 0, 0, 0, 0.06),
                                        //             borderRadius:
                                        //                 BorderRadius.circular(5)),
                                        //         child: Padding(
                                        //           padding: EdgeInsets.symmetric(
                                        //               vertical: 7.h),
                                        //           child: Column(
                                        //             children: [
                                        //               // Container(
                                        //               //   width: 80.w,
                                        //               //   height: 15.h,
                                        //               //   child: FittedBox(
                                        //               //     fit: BoxFit.scaleDown,
                                        //               //     child: Text(
                                        //               //         data[index]
                                        //               //             .doctorRemark,
                                        //               //         style: TextStyle(
                                        //               //             fontFamily:
                                        //               //                 'Nunito',
                                        //               //             fontSize: 19,
                                        //               //             fontWeight:
                                        //               //                 FontWeight
                                        //               //                     .w600,
                                        //               //             color: Color(
                                        //               //                 0XFF202020))),
                                        //               //   ),
                                        //               // ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Loading();
                          }
                        });
                  },
                );
              }
            } else {
              return const Loading();
            }
          })),
    );
  }
}
