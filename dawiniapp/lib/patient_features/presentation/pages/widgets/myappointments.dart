// ignore_for_file: sort_child_properties_last, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:ui';

//The new design for appointement
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/myApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dawini_full/core/error/ErrorWidget.dart';

class Myappointemtns extends StatefulWidget {
  const Myappointemtns({super.key});

  @override
  State<Myappointemtns> createState() => _MyappointemtnsState();
}

class _MyappointemtnsState extends State<Myappointemtns>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(length: 2, vsync: this);
    final PatientsBloc patientsBloc = BlocProvider.of<PatientsBloc>(context);

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            body: SafeArea(
                child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: const Color(0XFFECF2F2),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Mypage(
                                  popOrNot: false,
                                )),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 22.h,
                      color: const Color(0xFF0AA9A9),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 35.w),
              SizedBox(
                width: 190.w,
                child: const FittedBox(
                  fit: BoxFit.fill,
                  child: Text("My appointments",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0XFF202020))),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          TabBar(
            labelStyle: TextStyle(
                fontSize: 25.sp,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600),
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: Color(0XFF04CBCB)),
                insets: EdgeInsets.symmetric(horizontal: 25.0)),
            controller: tabcontroller,
            labelColor: const Color(0xFF202020),
            unselectedLabelColor: const Color(0XFF202020).withOpacity(0.4),
            tabs: const [
              Tab(
                text: 'Current',
              ),
              Tab(text: 'Previous'),
            ],
            indicatorColor: const Color(0XFF04CBCB),
          ),
          Expanded(
            child: TabBarView(controller: tabcontroller, children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 25.h),
                child: BlocBuilder<PatientsBloc, PatientsState>(
                    builder: (context, state) {
                  if (state is PatientsLoading) {
                    return const Loading();
                  } else if (state is PatientsLoaded) {
                    return ListView.builder(
                        itemCount: state.patients.length,
                        itemBuilder: (context, index) {
                          return Container(
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
                                      SizedBox(
                                        width: 150.w,
                                        height: 25.h,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              "Dr. ${state.patients[index].DoctorName}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800,
                                                  color: Color(0XFF202020))),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        height: 20.h,
                                        child: const FittedBox(
                                          alignment: Alignment.topLeft,
                                          fit: BoxFit.scaleDown,
                                          child: Text("Speciality",
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0XFF202020))),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 160.w,
                                        height: 20.h,
                                        child: const FittedBox(
                                          alignment: Alignment.topLeft,
                                          fit: BoxFit.scaleDown,
                                          child: Text("xx/xxx/xxxx at morning",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0XFF202020))),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 15.h,
                                            color: const Color(0XFF202020)
                                                .withOpacity(0.6),
                                          ),
                                          FittedBox(
                                            alignment: Alignment.topLeft,
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                                state.patients[index].address,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0XFF202020))),
                                          ),
                                        ],
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
                                                          begin: 0.5, end: 1.0)
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
                                                      content: SizedBox(
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
                                                              child: Container(
                                                                height: 40.h,
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
                                                                          20.sp,
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
                                                                            state.patients[index]));
                                                                if (Navigator
                                                                    .canPop(
                                                                        context)) {
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              },
                                                              child: Container(
                                                                height: 40.h,
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
                                                                          20.sp,
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
                                          height: 25.h,
                                          width: 180.w,
                                          decoration: BoxDecoration(
                                              color: const Color(0XFFECF2F2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: SizedBox(
                                            width: 80.w,
                                            height: 20.h,
                                            child: Center(
                                              child: AutoSizeText(
                                                  "Cancel appointment",
                                                  style: TextStyle(
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
                                  padding: EdgeInsets.only(left: 2.w, top: 8.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 55.h,
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
                                              SizedBox(
                                                width: 80.w,
                                                height: 15.h,
                                                child: const FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text("my turn",
                                                      style: TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color(
                                                              0XFF202020))),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 80.w,
                                                height: 20.h,
                                                child: FittedBox(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      state.patients[index].turn
                                                          .toString(),
                                                      style: TextStyle(
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
                                        "current turn ",
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14.sp,
                                            color: const Color.fromRGBO(
                                                32, 32, 32, 0.8)),
                                      ),
                                      turnSHower(state, index),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  } else {
                    return const Loading();
                  }
                }),
              ),

              // Content for the 'Previous' tab
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150.w,
                      height: 25.h,
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.topLeft,
                        child: Text("Soufyane hariri",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color(0XFF202020))),
                      ),
                    ),
                    SizedBox(
                      width: 80.w,
                      height: 20.h,
                      child: const FittedBox(
                        alignment: Alignment.topLeft,
                        fit: BoxFit.scaleDown,
                        child: Text("Speciality",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFF202020))),
                      ),
                    ),
                    SizedBox(
                      width: 160.w,
                      height: 20.h,
                      child: const FittedBox(
                        alignment: Alignment.topLeft,
                        fit: BoxFit.scaleDown,
                        child: Text("xx/xxx/xxxx at morning",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFF202020))),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 15.h,
                          color: const Color(0XFF202020).withOpacity(0.6),
                        ),
                        const FittedBox(
                          alignment: Alignment.topLeft,
                          fit: BoxFit.scaleDown,
                          child: Text("Algeria , bab zouar",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF202020))),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    GestureDetector(
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return Container();
                          },
                          transitionBuilder: (context, a1, a2, widget) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: ScaleTransition(
                                scale: Tween(begin: 0.5, end: 1.0).animate(a1),
                                child: FadeTransition(
                                  opacity: Tween<double>(begin: 0.4, end: 1)
                                      .animate(a1),
                                  child: AlertDialog(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    content: SizedBox(
                                      height: 150.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Are you sure you want to cancel your appointment ?",
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 19.sp,
                                                fontFamily: "Nunito",
                                                fontWeight: FontWeight.bold),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (Navigator.canPop(context)) {
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Container(
                                              height: 40.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: const Color(
                                                              0XFF202020)
                                                          .withOpacity(0.6),
                                                      width: 1)),
                                              child: Center(
                                                  child: Text(
                                                "Keep appointment",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0XFF202020)
                                                            .withOpacity(0.85),
                                                    fontFamily: "Nunito",
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (Navigator.canPop(context)) {
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Container(
                                              height: 40.h,
                                              decoration: BoxDecoration(
                                                color: const Color(0XFF04CBCB),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Cancel appointment",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Nunito",
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 25.h,
                        width: 180.w,
                        decoration: BoxDecoration(
                            color: const Color(0XFFECF2F2),
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          width: 80.w,
                          height: 20.h,
                          child: Center(
                            child: AutoSizeText("Cancel appointment",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0XFF202020))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ]))));
  }

  Widget turnSHower(state, index) {
    return Column(
      children: [
        StreamBuilder<List<DoctorEntity>>(
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
              late final List<DoctorEntity> data;
              if (snapshot.data == null) {
                data = [];
              } else {
                if (snapshot.data!.isEmpty) {
                  data = [];
                } else {
                  data = snapshot.data!;
                }
              }
              List<DoctorEntity> doctors = data
                  .where((element) => element.uid == state.patients[index].uid)
                  .toList();
              if (doctors.isNotEmpty) {
                if (state.patients[index].today) {
                  notificationConditions(state, index, doctors);
                }
              }
              return Text.rich(
                TextSpan(
                    text: "is at :",
                    style: TextStyle(
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w800,
                        fontSize: 14.sp,
                        color: const Color.fromRGBO(32, 32, 32, 0.8)),
                    children: [
                      TextSpan(
                          text: doctors.isNotEmpty
                              ? " ${doctors.first.turn}"
                              : "",
                          style: TextStyle(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800,
                              fontSize: 16.sp,
                              color: const Color(0XFF0AA9A9)))
                    ]),
              );
            }),
      ],
    );
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
    if (state.patients[index].turn - 2 == (doctors.first.turn)) {
      NotificationShower(
          state.patients[index].firstName +
              " " +
              state.patients[index].lastName,
          index,
          "Dr. " + doctors.first.lastName,
          "is near");
    } else if (state.patients[index].turn - 1 == (doctors.first.turn)) {
      NotificationShower(
          state.patients[index].firstName +
              " " +
              state.patients[index].lastName,
          index,
          "Dr. " + doctors.first.lastName,
          "is after one Patient");
    } else if (state.patients[index].turn == (doctors.first.turn)) {
      NotificationShower(
          state.patients[index].firstName +
              " " +
              state.patients[index].lastName,
          index,
          "Dr. " + doctors.first.lastName,
          "is NOW");
    }
  }
}
