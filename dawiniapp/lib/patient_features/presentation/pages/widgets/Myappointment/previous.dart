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
  const previousappointm({super.key});

  @override
  State<previousappointm> createState() => _previousappointmState();
}

class _previousappointmState extends State<previousappointm> {
  @override
  Widget build(BuildContext context) {
    final GetDoctorsInfoUseCase getDoctorsInfoUseCase = GetDoctorsInfoUseCase();
    final AppLocalizations text = AppLocalizations.of(context)!;

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
                            .where((element) => element.uid == data[index].uid)
                            .toList();
                        if (doctors.isNotEmpty) {
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
                                      borderRadius: BorderRadius.circular(10)),
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
                                                      "${text.dr}. ${isArabic ? doctors[index].lastNameArabic : doctors[index].lastName}",
                                                      style: const TextStyle(
                                                          fontSize: 19,
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
                                                          : doctors
                                                              .first.speciality,
                                                      style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: 18,
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
                                                    color:
                                                        const Color(0XFF202020)
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
                                                            fontSize: 15.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
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
            } else {
              return const Loading();
            }
          })),
    );
  }
}
