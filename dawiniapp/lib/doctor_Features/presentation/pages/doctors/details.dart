// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:dawini_full/core/error/ErrorWidget.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Myappointment/Patient_Info.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/patient_features/domain/usecases/patients_usecase.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class doctorDetails extends StatefulWidget {
  final String uid;
  final device;

  const doctorDetails({super.key, required this.uid, this.device});

  @override
  State<doctorDetails> createState() => _doctorDetailsState();
}

bool isTodaySelected = true;
bool? favorite;
Future<void> isFavortie(String uid) async {
  final uids = await GetFavoriteDoctorsUseCase.excute();
  if (uids.isNotEmpty) {
    for (var element in uids) {
      if (element == uid) {
        favorite = true;
        break;
      } else {
        favorite = false;
      }
    }
  } else {
    favorite = false;
  }
}

class _doctorDetailsState extends State<doctorDetails>
    with TickerProviderStateMixin {
  String datetime = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    final PatientsBloc patientsBloc = BlocProvider.of<PatientsBloc>(context);

    final uid = widget.uid;
    isFavortie(uid);
    return Scaffold(
        body: SafeArea(
      child: StreamBuilder<List<DoctorEntity>>(
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
            late final List<DoctorEntity> data;
            late final bool today, tomorrow;
            if (snapshot.data == null) {
              data = [];
            } else {
              if (snapshot.data!.isEmpty) {
                data = [];
              } else {
                data = snapshot.data!;
              }
            }
            List<DoctorEntity> doctor =
                data.where((element) => element.uid == uid).toList();
            if (doctor.isNotEmpty) {
              if (doctor.first.date == "all") {
                today = true;
                tomorrow = true;
              } else if (doctor.first.date == "today") {
                today = true;
                tomorrow = false;
              } else if (doctor.first.date == "tomorrow") {
                today = false;
                tomorrow = true;
              } else {
                today = false;
                tomorrow = false;
              }
            }

            if (doctor.isNotEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Stack(children: [
                      Container(
                        color: const Color(0xffFAFAFA),
                        height: 150.h,
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/maleDoctor.png",
                          fit: BoxFit.scaleDown,
                          scale: 1.3.w,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffECF2F2),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 20,
                                  color: Color(0xff0AA9A9),
                                )),
                          ),
                          SizedBox(width: 190.w),
                          Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffECF2F2),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Share.share(doctor.first.location);
                                },
                                icon: const Icon(
                                  Icons.share,
                                  size: 20,
                                  color: Color(0xff0AA9A9),
                                )),
                          ),
                          SizedBox(width: 6.w),
                          Container(
                            width: 35,
                            height: 35,
                            margin: EdgeInsets.only(right: 8.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffECF2F2),
                            ),
                            child: IconButton(
                                color: favorite! ? Colors.red : null,
                                onPressed: () {
                                  setState(() {
                                    favorite = !favorite!;
                                    if (favorite!) {
                                      patientsBloc.add(onSetFavoriteDoctor(
                                          context,
                                          doctorUid: doctor.first.uid));
                                    } else {
                                      patientsBloc.add(onDeleteFavoriteDoctor(
                                          context,
                                          doctorUid: doctor.first.uid));
                                    }
                                  });
                                },
                                icon: Icon(
                                  color: favorite! ? Colors.red : null,
                                  Icons.favorite_border,
                                  size: 20,
                                )),
                          ),
                        ],
                      )
                    ]),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(top: 10.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0XFF000000).withOpacity(0.23),
                            spreadRadius: 3,
                            blurRadius: 8,
                            offset: const Offset(0, 0),
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15.w, top: 10.h),
                              height: 30.h,
                              width: 180.w,
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Dr.${doctor.first.lastName}",
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 22,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 8.w, top: 10.h),
                              height: 20.h,
                              width: 100.w,
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: doctor.isNotEmpty
                                            ? doctor.first.atSerivce
                                                ? Colors.green
                                                : Colors.red
                                            : Colors.red,
                                        size: 15.sp,
                                      ),
                                      Text(
                                        doctor.first.atSerivce
                                            ? " At service"
                                            : " Not At service",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 23,
                                            fontFamily: 'Nunito'),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 15.w),
                            height: 20.h,
                            width: 250.w,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.topLeft,
                              child: Text(
                                doctor.first.speciality,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    fontFamily: 'Nunito'),
                              ),
                            )),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15.w),
                              height: 40.h,
                              width: 130.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: const Color(0XFF0AA9A9),
                                          size: 15.sp,
                                        ),
                                        Text(
                                          " ${doctor.first.phoneNumber}",
                                          style: TextStyle(
                                            color: const Color(0XFF202020)
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            fontFamily: 'Nunito',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                    width: 200.w,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: const Color(0XFF0AA9A9),
                                            size: 15.sp,
                                          ),
                                          Text(
                                            " ${doctor.first.phoneNumber}",
                                            style: TextStyle(
                                              color: const Color(0XFF202020)
                                                  .withOpacity(0.7),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              fontFamily: 'Nunito',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final url = doctor.first.location;
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 8.w),
                                height: 40.h,
                                width: 70.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Color(0XFF0AA9A9),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'location link',
                                        style: TextStyle(
                                          color: const Color(0xff414141)
                                              .withOpacity(0.85),
                                          fontSize: 12,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 15.w),
                            width: 250.w,
                            height: 50.h,
                            child: SingleChildScrollView(
                              child: Text(
                                "Description : ${doctor.first.description}",
                                style: TextStyle(
                                    color: Color(0XFF202020),
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 15.w, top: 8.h),
                            width: 130.w,
                            height: 20.h,
                            child: FittedBox(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Experience : ${doctor.first.experience}",
                                  style: TextStyle(
                                      color: Color(0XFF202020),
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w600),
                                ))),
                        Container(
                            margin: EdgeInsets.only(left: 15.w, top: 8.h),
                            width: 250.w,
                            height: 24.h,
                            child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Choose from available booking time :",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0XFF202020),
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w700),
                                ))),
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 15.w, top: 10.h),
                                width: 50.w,
                                height: 20.h,
                                child: const FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Date : ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0XFF202020),
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.w700),
                                    ))),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (today && tomorrow || today && !tomorrow) {
                                    isTodaySelected = true;
                                  }
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 15.w, top: 8.h),
                                width: 80.w,
                                height: 28.h,
                                decoration: BoxDecoration(
                                    color: !today
                                        ? Color.fromRGBO(244, 67, 54, 0.322)
                                        : null,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      width: 2,
                                      color: today
                                          ? (isTodaySelected
                                              ? Color(0xff04CBCB)
                                              : Color(0xff000000)
                                                  .withOpacity(0.25))
                                          : Color.fromRGBO(244, 67, 54, 0.322),
                                    )),
                                child: const Center(
                                    child: Text(
                                  "today",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0XFF202020),
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w600),
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (today && tomorrow || !today && tomorrow) {
                                    isTodaySelected =
                                        false; // Deselect the other option
                                  }
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 15.w, top: 8.h),
                                width: 80.w,
                                height: 28.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: tomorrow
                                      ? null
                                      : Color.fromRGBO(244, 67, 54, 0.322),
                                  border: Border.all(
                                    width: 2,
                                    color: tomorrow
                                        ? !isTodaySelected
                                            ? Color(0xff04CBCB)
                                            : Color(0xff000000)
                                                .withOpacity(0.25)
                                        : Color.fromRGBO(244, 67, 54, 0.322),
                                  ),
                                ),
                                child: const Center(
                                    child: Text(
                                  "tomorrow",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0XFF202020),
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w600),
                                )),
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            if (!today && !tomorrow ||
                                !doctor.first.atSerivce) {
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Patient_info(
                                            doctorEntity: doctor.first,
                                            today: isTodaySelected,
                                          )));
                            }
                          },
                          child: Container(
                            width: 340.w,
                            height: 33.h,
                            decoration: BoxDecoration(
                                color: doctor.first.atSerivce
                                    ? (today || tomorrow)
                                        ? Color(0xff04CBCB)
                                        : Color.fromRGBO(255, 0, 0, 0.11)
                                    : Color.fromRGBO(255, 0, 0, 0.11),
                                borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.symmetric(
                                vertical: 22.h, horizontal: 60.w),
                            child: const FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: Text(
                                "Book appointment",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              );
            } else {
              return Loading();
            }
          }),
    ));
  }
}
