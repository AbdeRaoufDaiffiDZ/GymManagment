// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, camel_case_types, file_names

import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:dawini_full/core/error/ErrorWidget.dart';

import '../../../../../doctor_Features/domain/entities/doctor.dart';
import '../../../../../doctor_Features/domain/usecases/doctor_usecase.dart';

class newcurrent extends StatefulWidget {
  const newcurrent({super.key});

  @override
  State<newcurrent> createState() => _newcurrentState();
}

class _newcurrentState extends State<newcurrent> with TickerProviderStateMixin {
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
              .format(DateTime.now().add(const Duration(days: 1)))
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
                        if (data[index].today) {
                          notificationConditions(data, index, doctors);
                        }
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Container(
                                height: 160.h,
                                width: 320.w,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: const Color(0XFF202020)
                                            .withOpacity(0.1)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 8.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  height: 62.w,
                                                  width: 62.w,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color:
                                                              Color(0xff202020)
                                                                  .withOpacity(
                                                                      0.4))),
                                                  child: Image.asset(
                                                    "assets/images/maleDoctor.png",
                                                    alignment: Alignment.center,
                                                    scale: 4,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.h, horizontal: 2.w),
                                          child: Column(children: [
                                            Container(
                                              width: 160.w,
                                              height: 25.h,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                    "Dr. ${doctor[index].lastName}",
                                                    style: const TextStyle(
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            Color(0XFF202020))),
                                              ),
                                            ),
                                            Container(
                                              width: 160.w,
                                              height: 17.h,
                                              child: FittedBox(
                                                alignment: Alignment.topLeft,
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                    doctors.first.speciality,
                                                    style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0XFF202020))),
                                              ),
                                            ),
                                            Container(
                                              width: 160.w,
                                              height: 20.h,
                                              child: FittedBox(
                                                alignment: Alignment.topLeft,
                                                fit: BoxFit.scaleDown,
                                                child: Row(children: [
                                                  Text(
                                                    data[index].today
                                                        ? "current turn "
                                                        : "tomorrow date",
                                                    style: const TextStyle(
                                                        fontFamily: "Nunito",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 17,
                                                        color: Color.fromRGBO(
                                                            32, 32, 32, 0.6)),
                                                  ),
                                                  data[index].today
                                                      ? Text.rich(
                                                          TextSpan(
                                                              text: "is at :",
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      "Nunito",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 17,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          32,
                                                                          32,
                                                                          32,
                                                                          0.6)),
                                                              children: [
                                                                TextSpan(
                                                                    text: !doctors.isEmpty
                                                                        ? " ${doctors.first.turn}"
                                                                        : "",
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            "Nunito",
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            17,
                                                                        color: Color(
                                                                            0XFF0AA9A9)))
                                                              ]),
                                                        )
                                                      : Container(),
                                                ]),
                                              ),
                                            )
                                          ]),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                              color: Colors.black,
                                            ))
                                      ],
                                    ),
                                    Container(
                                      height: 24.h,
                                      width: 270.w,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 14),
                                            child: Container(
                                              child: FittedBox(
                                                alignment: Alignment.centerLeft,
                                                fit: BoxFit.scaleDown,
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.calendar_month,
                                                        size: 17),
                                                    Text(
                                                      " today , morning",
                                                      style: TextStyle(
                                                          color: Color(
                                                                  0xff202020)
                                                              .withOpacity(0.8),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: 'Nunito'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 14),
                                            child: FittedBox(
                                              alignment: Alignment.centerLeft,
                                              fit: BoxFit.scaleDown,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.schedule,
                                                      size: 17),
                                                  Text(" my turn : ",
                                                      style: TextStyle(
                                                        color: Color(0xff202020)
                                                            .withOpacity(0.8),
                                                        fontFamily: 'Nunito',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  Text(
                                                      data[index]
                                                          .turn
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: const Color(
                                                              0xff0AA9A9))),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
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
                                                scale:
                                                    Tween(begin: 0.5, end: 1.0)
                                                        .animate(a1),
                                                child: FadeTransition(
                                                  opacity: Tween<double>(
                                                          begin: 0.4, end: 1)
                                                      .animate(a1),
                                                  child: AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.h,
                                                            horizontal: 10.w),
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
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15.sp,
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
                                                            child: Container(
                                                              height: 40.h,
                                                              width: 200.w,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border.all(
                                                                      color: const Color(
                                                                              0XFF202020)
                                                                          .withOpacity(
                                                                              0.6),
                                                                      width:
                                                                          1)),
                                                              child: Center(
                                                                  child: Text(
                                                                "Keep appointment",
                                                                style: TextStyle(
                                                                    color: const Color(
                                                                            0XFF202020)
                                                                        .withOpacity(
                                                                            0.85),
                                                                    fontFamily:
                                                                        "Nunito",
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              )),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              patientsBloc.add(
                                                                  onPatientsAppointmentDelete(
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
                                                            child: Container(
                                                              height: 40.h,
                                                              width: 200.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0XFF04CBCB),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child: Center(
                                                                  child: Text(
                                                                "Cancel appointment",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        "Nunito",
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    shape: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                        child: Center(
                                          child: Text("Cancel appointment",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 14.sp,
                                                  color: Color(0xff202020))),
                                        ),
                                        height: 28.h,
                                        width: 270.w,
                                        decoration: BoxDecoration(
                                            color: Color(0xffE0F3F2),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                    )
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
            title: "your turn $body",
            body: "$patientName turn at $doctorName $body"));
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
