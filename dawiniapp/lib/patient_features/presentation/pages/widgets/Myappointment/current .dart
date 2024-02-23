// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:ui';

//The new design for appointement
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:dawini_full/core/error/ErrorWidget.dart';

class currentappointm extends StatefulWidget {
  const currentappointm({super.key});

  @override
  State<currentappointm> createState() => _currentappointmState();
}

class _currentappointmState extends State<currentappointm>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final PatientsBloc patientsBloc = BlocProvider.of<PatientsBloc>(context);

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
      child:
          BlocBuilder<PatientsBloc, PatientsState>(builder: (context, state) {
        if (state is PatientsLoaded) {
          String datetime =
              DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
          String datetimeTomorrow = DateFormat("yyyy-MM-dd")
              .format(DateTime.now().add(Duration(days: 1)))
              .toString();
          final data = state.patients
              .where((element) =>
                  element.AppointmentDate == datetime ||
                  element.AppointmentDate == datetimeTomorrow)
              .toList();

          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return StreamBuilder<List<DoctorEntity>>(
                    stream: GetDoctorsStreamInfoUseCase.excute(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Loading();
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
                        if (data[index].today) {
                          notificationConditions(data, index, doctors);
                        }
                        return Column(
                          children: [
                            Container(
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 150.w,
                                          height: 25.h,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                "Dr. ${doctors.first.lastName}",
                                                style: const TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0XFF202020))),
                                          ),
                                        ),
                                        Container(
                                          width: 80.w,
                                          height: 20.h,
                                          child: FittedBox(
                                            alignment: Alignment.topLeft,
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                                doctors.first.speciality,
                                                style: const TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0XFF202020))),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 13.h,
                                                color: const Color(0XFF202020)
                                                    .withOpacity(0.6),
                                              ),
                                              FittedBox(
                                                alignment: Alignment.topLeft,
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                    '${doctors.first.city}, ${doctors.first.wilaya}',
                                                    style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0XFF202020))),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        GestureDetector(
                                          onTap: () {
                                            showGeneralDialog(
                                              context: context,
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return Container();
                                              },
                                              transitionBuilder:
                                                  (context, a1, a2, widget) {
                                                return BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaX: 5, sigmaY: 5),
                                                  child: ScaleTransition(
                                                    scale: Tween(
                                                            begin: 0.5,
                                                            end: 1.0)
                                                        .animate(a1),
                                                    child: FadeTransition(
                                                      opacity: Tween<double>(
                                                              begin: 0.4,
                                                              end: 1)
                                                          .animate(a1),
                                                      child: AlertDialog(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10.h,
                                                                    horizontal:
                                                                        10.w),
                                                        content: Container(
                                                          height: 150.h,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Are you sure you want to cancel your appointment ?",
                                                                maxLines: 2,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        19.sp,
                                                                    fontFamily:
                                                                        "Nunito",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  if (Navigator
                                                                      .canPop(
                                                                          context)) {
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 40.h,
                                                                  width: 200.w,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      border: Border.all(
                                                                          color: const Color(0XFF202020).withOpacity(
                                                                              0.6),
                                                                          width:
                                                                              1)),
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    "Keep appointment",
                                                                    style: TextStyle(
                                                                        color: const Color(0XFF202020).withOpacity(
                                                                            0.85),
                                                                        fontFamily:
                                                                            "Nunito",
                                                                        fontSize: 20
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  patientsBloc.add(onPatientsAppointmentDelete(
                                                                      context,
                                                                      patients:
                                                                          state.patients[
                                                                              index]));
                                                                  if (Navigator
                                                                      .canPop(
                                                                          context)) {
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 40.h,
                                                                  width: 200.w,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                        0XFF04CBCB),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                  ),
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    "Cancel appointment",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily:
                                                                            "Nunito",
                                                                        fontSize: 20
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        shape:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              BorderSide.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            height: 22.h,
                                            width: 150.w,
                                            decoration: BoxDecoration(
                                                color: const Color(0XFFECF2F2),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Container(
                                              width: 80.w,
                                              height: 20.h,
                                              child: Center(
                                                child: AutoSizeText(
                                                    "Cancel appointment",
                                                    style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0XFF202020))),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 16.w, top: 8.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 49.h,
                                          width: 86.w,
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  0, 0, 0, 0.06),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 7.h),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 80.w,
                                                  height: 15.h,
                                                  child: const FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text("my turn",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: 19,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0XFF202020))),
                                                  ),
                                                ),
                                                Container(
                                                  width: 80.w,
                                                  height: 20.h,
                                                  child: FittedBox(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        data[index]
                                                            .turn
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: 19.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: const Color(
                                                                0xff0AA9A9))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 3.h),
                                        Text(
                                          data[index].today
                                              ? "current turn "
                                              : "tomorrow date",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.w800,
                                              fontSize: 14.sp,
                                              color: const Color.fromRGBO(
                                                  32, 32, 32, 0.8)),
                                        ),
                                        data[index].today
                                            ? Text.rich(
                                                TextSpan(
                                                    text: "is at :",
                                                    style: TextStyle(
                                                        fontFamily: "Nunito",
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 14.sp,
                                                        color: const Color
                                                            .fromRGBO(
                                                            32, 32, 32, 0.8)),
                                                    children: [
                                                      TextSpan(
                                                          text: !doctors.isEmpty
                                                              ? " ${doctors.first.turn}"
                                                              : "",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Nunito",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 16.sp,
                                                              color: const Color(
                                                                  0XFF0AA9A9)))
                                                    ]),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Loading();
                      }
                    });
              });
        } else {
          return const Loading();
        }
      }),
    ));
  }

  NotificationShower(String patientName, int index, String doctorName, body) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: index,
            channelKey: 'basic_channel',
            title: "your turn ${body}",
            body: "${patientName} turn at ${doctorName} ${body}"));
  }

  notificationConditions(state, index, doctors) {
    if (state[index].turn - 2 == (doctors.first.turn)) {
      NotificationShower(state[index].firstName + " " + state[index].lastName,
          index, "Dr. " + doctors.first.lastName, "is near");
    } else if (state[index].turn - 1 == (doctors.first.turn)) {
      NotificationShower(state[index].firstName + " " + state[index].lastName,
          index, "Dr. " + doctors.first.lastName, "is after one Patient");
    } else if (state[index].turn == (doctors.first.turn)) {
      NotificationShower(state[index].firstName + " " + state[index].lastName,
          index, "Dr. " + doctors.first.lastName, "is NOW");
    }
  }
}
