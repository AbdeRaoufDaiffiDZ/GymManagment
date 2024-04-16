// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, camel_case_types, file_names, sized_box_for_whitespace

import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:dawini_full/core/error/ErrorWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../doctor_Features/domain/entities/doctor.dart';
import '../../../../../doctor_Features/domain/usecases/doctor_usecase.dart';

class newcurrent extends StatefulWidget {
  final int fontSize;

  const newcurrent({super.key, required this.fontSize});

  @override
  State<newcurrent> createState() => _newcurrentState();
}

class _newcurrentState extends State<newcurrent> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final PatientsBloc patientsBloc = BlocProvider.of<PatientsBloc>(context);
    final GetDoctorsInfoUseCase getDoctorsInfoUseCase = GetDoctorsInfoUseCase();
    AppLocalizations text = AppLocalizations.of(context)!;

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
          final bool isArabic =
              Localizations.localeOf(context).languageCode == "ar";

          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return StreamBuilder<List<DoctorEntity>>(
                    stream: getDoctorsInfoUseCase.streamDoctorInfo(),
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
                          notificationConditions(data, index, doctors,
                              text: text, isArabic: isArabic);
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
                                    borderRadius: BorderRadius.circular(10.r)),
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
                                                          color: const Color(
                                                                  0xff202020)
                                                              .withOpacity(
                                                                  0.4))),
                                                  child: (doctors.first
                                                                  .ImageProfileurl ==
                                                              " " ||
                                                          doctors.first
                                                                  .ImageProfileurl ==
                                                              "")
                                                      ? ClipOval(
                                                          child:
                                                              SizedBox.fromSize(
                                                          size: const Size
                                                              .fromRadius(
                                                              48.0), // Adjust radius
                                                          child: Image.asset(
                                                            "assets/images/maleDoctor.png",
                                                            alignment: Alignment
                                                                .center,
                                                            scale: 4.3,
                                                          ),
                                                        ))
                                                      : ClipOval(
                                                          child:
                                                              SizedBox.fromSize(
                                                            size: const Size
                                                                .fromRadius(
                                                                48.0), // Adjust radius
                                                            child:
                                                                Image.network(
                                                              doctors.first
                                                                  .ImageProfileurl,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ))
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
                                                alignment: isArabic
                                                    ? Alignment.topRight
                                                    : Alignment.topLeft,
                                                child: Text(
                                                    "${text.dr}. ${isArabic ? doctors.first.lastNameArabic : doctors.first.lastName}",
                                                    style: TextStyle(
                                                        fontSize: 19.sp -
                                                            widget.fontSize.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: const Color(
                                                            0XFF202020))),
                                              ),
                                            ),
                                            Container(
                                              width: 160.w,
                                              height: 17.h,
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
                                                    style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 18.sp -
                                                            widget.fontSize.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0XFF202020))),
                                              ),
                                            ),
                                            Container(
                                              width: 160.w,
                                              height: 20.h,
                                              child: FittedBox(
                                                alignment: isArabic
                                                    ? Alignment.topRight
                                                    : Alignment.topLeft,
                                                fit: BoxFit.scaleDown,
                                                child: Row(children: [
                                                  Text(
                                                    data[index].today
                                                        ? text.currentturn
                                                        : text.tomorrowdate,
                                                    style: TextStyle(
                                                        fontFamily: "Nunito",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15.sp -
                                                            widget.fontSize.sp,
                                                        color: const Color
                                                            .fromRGBO(
                                                            32, 32, 32, 0.6)),
                                                  ),
                                                  data[index].today
                                                      ? Text.rich(
                                                          TextSpan(
                                                              text: text.isat,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Nunito",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14
                                                                          .sp -
                                                                      widget
                                                                          .fontSize
                                                                          .sp,
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      32,
                                                                      32,
                                                                      32,
                                                                      0.6)),
                                                              children: [
                                                                TextSpan(
                                                                    text: doctors
                                                                            .isNotEmpty
                                                                        ? " ${doctors.first.turn}"
                                                                        : "",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito",
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize: 17
                                                                                .sp -
                                                                            widget
                                                                                .fontSize.sp,
                                                                        color: const Color(
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
                                        // IconButton(
                                        //     onPressed: () {},
                                        //     icon: Icon(
                                        //       Icons.arrow_forward_ios,
                                        //       size: 20.w,
                                        //       color: Colors.black,
                                        //     ))
                                      ],
                                    ),
                                    Container(
                                      height: 24.h,
                                      width: 270.w,
                                      decoration: BoxDecoration(
                                          color: (data[index].turn ==
                                                      doctors.first.turn) &&
                                                  data[index].today
                                              ? const Color.fromARGB(
                                                  73, 20, 255, 20)
                                              : Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: isArabic
                                                ? EdgeInsets.only(right: 14.w)
                                                : EdgeInsets.only(left: 14.w),
                                            child: FittedBox(
                                              alignment: isArabic
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              fit: BoxFit.scaleDown,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.calendar_month,
                                                      size: 14.w),
                                                  Text(
                                                    " " +
                                                        text.today +
                                                        ": ${data[index].AppointmentDate}",
                                                    style: TextStyle(
                                                        fontSize: 10.sp -
                                                            widget.fontSize.sp,
                                                        color: const Color(
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
                                          const Spacer(),
                                          Padding(
                                            padding: isArabic
                                                ? EdgeInsets.only(left: 5.w)
                                                : EdgeInsets.only(right: 5.w),
                                            child: FittedBox(
                                              alignment: isArabic
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              fit: BoxFit.scaleDown,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.schedule,
                                                      size: 14.w),
                                                  Padding(
                                                    padding: isArabic
                                                        ? EdgeInsets.only(
                                                            right: 5.w)
                                                        : EdgeInsets.only(
                                                            left: 5.w),
                                                    child: Text(
                                                        text.myturn + " : ",
                                                        style: TextStyle(
                                                          color: const Color(
                                                                  0xff202020)
                                                              .withOpacity(0.8),
                                                          fontFamily: 'Nunito',
                                                          fontSize: 10.sp -
                                                              widget
                                                                  .fontSize.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
                                                  ),
                                                  Text(
                                                      data[index]
                                                          .turn
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: 14.sp -
                                                              widget
                                                                  .fontSize.sp,
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
                                        final fontSize = widget.fontSize;
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
                                                            text.cancelappointment,
                                                            maxLines: 2,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15
                                                                        .sp -
                                                                    fontSize.sp,
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
                                                                          .circular(20
                                                                              .r),
                                                                  border: Border.all(
                                                                      color: const Color(
                                                                              0XFF202020)
                                                                          .withOpacity(
                                                                              0.6),
                                                                      width:
                                                                          1)),
                                                              child: Center(
                                                                  child: Text(
                                                                text.keepappointment,
                                                                style: TextStyle(
                                                                    color: const Color(
                                                                            0XFF202020)
                                                                        .withOpacity(
                                                                            0.85),
                                                                    fontFamily:
                                                                        "Nunito",
                                                                    fontSize: 16
                                                                            .sp -
                                                                        fontSize
                                                                            .sp,
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
                                                                            20.r),
                                                              ),
                                                              child: Center(
                                                                  child: Text(
                                                                text.cancelappointmentbottun,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        "Nunito",
                                                                    fontSize: 16
                                                                            .sp -
                                                                        fontSize
                                                                            .sp,
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
                                                              10.r),
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
                                        height: 28.h,
                                        width: 270.w,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffE0F3F2),
                                            borderRadius:
                                                BorderRadius.circular(12.r)),
                                        child: Center(
                                          child: Text(
                                              text.cancelappointmentbottun,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 14.sp -
                                                      widget.fontSize.sp,
                                                  color:
                                                      const Color(0xff202020))),
                                        ),
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
        } else if (state is PatientsLoadingError) {
          if (kDebugMode) {
            print(state.error);
          }
          return const Loading();
        } else {
          return const Loading();
        }
      }),
    ));
  }

  NotificationShower(String patientName, int index, String doctorName, body,
      {required AppLocalizations text}) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: index,
            channelKey: 'basic_channel',
            title: "${text.turn} $body",
            body: "$patientName ${text.myturn} $doctorName $body"));
  }

  notificationConditions(state, index, doctors,
      {required AppLocalizations text, required bool isArabic}) {
    if (state[index].turn - 2 == (doctors.first.turn)) {
      NotificationShower(
          state[index].firstName + " " + state[index].lastName,
          index,
          text.dr +
              ". " +
              (isArabic
                  ? doctors.first.lastNameArabic
                  : doctors.first.lastName),
          text.is_near,
          text: text);
    } else if (state[index].turn - 1 == (doctors.first.turn)) {
      NotificationShower(
          state[index].firstName + " " + state[index].lastName,
          index,
          text.dr + ". " + doctors.first.lastName,
          text.is_after_one_patient,
          text: text);
    } else if (state[index].turn == (doctors.first.turn)) {
      NotificationShower(state[index].firstName + " " + state[index].lastName,
          index, text.dr + ". " + doctors.first.lastName, text.is_now,
          text: text);
    }
  }
}
