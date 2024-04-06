// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_typing_uninitialized_variables, deprecated_member_use, sized_box_for_whitespace

import 'package:dawini_full/core/error/ErrorWidget.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/Patient_Info.dart';
import 'package:dawini_full/patient_features/domain/usecases/patients_usecase.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final AppLocalizations text = AppLocalizations.of(context)!;

    final PatientsBloc patientsBloc = BlocProvider.of<PatientsBloc>(context);
    final GetDoctorsInfoUseCase getDoctorsInfoUseCase = GetDoctorsInfoUseCase();
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";

    final uid = widget.uid;
    isFavortie(uid);
    return Scaffold(
        body: SafeArea(
      child: StreamBuilder<List<DoctorEntity>>(
          stream: getDoctorsInfoUseCase.streamDoctorInfo(),
          builder: (context, snapshot) {
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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Stack(children: [
                        Container(
                            color: const Color(0xffFAFAFA),
                            height: 150.h,
                            width: double.infinity,
                            child: doctor.first.ImageProfileurl == ''
                                ? Image.asset(
                                    "assets/images/maleDoctor.png",
                                    alignment: Alignment.center,
                                    scale: 4.3,
                                  )
                                : Image.network(
                                    doctor.first.ImageProfileurl,
                                    fit: BoxFit.cover,
                                  )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 35.w,
                              height: 35.h,
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
                              width: 35.w,
                              height: 35.h,
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
                              width: 35.w,
                              height: 35.h,
                              margin: isArabic
                                  ? EdgeInsets.only(left: 8.w)
                                  : EdgeInsets.only(right: 8.w),
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
                    Container(
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
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                            bottomLeft: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: isArabic
                                    ? EdgeInsets.only(right: 15.w, top: 10.h)
                                    : EdgeInsets.only(left: 15.w, top: 10.h),
                                height: 30.h,
                                width: 180.w,
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: isArabic
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    child: Text(
                                      "Dr.${doctor.first.lastName}",
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 22.sp,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w700),
                                    )),
                              ),
                              Container(
                                margin: isArabic
                                    ? EdgeInsets.only(left: 8.w, top: 10.h)
                                    : EdgeInsets.only(right: 8.w, top: 10.h),
                                height: 20.h,
                                width: 100.w,
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: isArabic
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: doctor.isNotEmpty
                                              ? doctor.first.atSerivce
                                                  ? Colors.green
                                                  : Colors.red
                                              : Colors.red,
                                          size: 15,
                                        ),
                                        Padding(
                                          padding: isArabic
                                              ? EdgeInsets.only(right: 5.w)
                                              : EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            doctor.first.atSerivce
                                                ? text.at_service
                                                : text.not_at_service,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 23.sp,
                                                fontFamily: 'Nunito'),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          Container(
                              margin: isArabic
                                  ? EdgeInsets.only(right: 15.w)
                                  : EdgeInsets.only(left: 15.w),
                              height: 20.h,
                              width: 250.w,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: isArabic
                                    ? Alignment.topRight
                                    : Alignment.topLeft,
                                child: Text(
                                  doctor.first.speciality,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22.sp,
                                      fontFamily: 'Nunito'),
                                ),
                              )),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: isArabic
                                    ? EdgeInsets.only(right: 15.w)
                                    : EdgeInsets.only(left: 15.w),
                                height: 40.h,
                                width: 130.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: isArabic
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: const Color(0XFF0AA9A9),
                                            size: 15,
                                          ),
                                          Text(
                                            " ${doctor.first.phoneNumber}",
                                            style: TextStyle(
                                              color: const Color(0XFF202020)
                                                  .withOpacity(0.7),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15.sp,
                                              fontFamily: 'Nunito',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 20.h,
                                      width: 200.w,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: isArabic
                                            ? Alignment.topRight
                                            : Alignment.topLeft,
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
                                                fontSize: 15.sp,
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
                                  margin: isArabic
                                      ? EdgeInsets.only(left: 8.w)
                                      : EdgeInsets.only(right: 8.w),
                                  height: 40.h,
                                  width: 70.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Color(0XFF0AA9A9),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: text.link_location,
                                          style: TextStyle(
                                            color: const Color(0xff414141)
                                                .withOpacity(0.85),
                                            fontSize: 11.sp,
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
                              margin: isArabic
                                  ? EdgeInsets.only(right: 15.w)
                                  : EdgeInsets.only(left: 15.w),
                              width: 90.w,
                              height: 20.h,
                              child: FittedBox(
                                  child: Text(
                                "${text.description} : ${doctor.first.description}",
                                style: TextStyle(
                                    color: Color(0XFF202020),
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w600),
                              ))),
                          Container(
                              margin: isArabic
                                  ? EdgeInsets.only(right: 15.w, top: 8.h)
                                  : EdgeInsets.only(left: 15.w, top: 8.h),
                              width: 130.w,
                              height: 20.h,
                              child: FittedBox(
                                  alignment: isArabic
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  child: Text(
                                    "${text.experience} : ${doctor.first.experience}",
                                    style: TextStyle(
                                        color: Color(0XFF202020),
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w600),
                                  ))),
                          Container(
                              margin: isArabic
                                  ? EdgeInsets.only(right: 15.w, top: 8.h)
                                  : EdgeInsets.only(left: 15.w, top: 8.h),
                              width: 250.w,
                              height: 24.h,
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: isArabic
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  child: Text(
                                    text.choose_from_available_booking_time,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0XFF202020),
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w700),
                                  ))),
                          Row(
                            children: [
                              Container(
                                  margin: isArabic
                                      ? EdgeInsets.only(right: 15.w, top: 10.h)
                                      : EdgeInsets.only(left: 15.w, top: 10.h),
                                  width: 50.w,
                                  height: 20.h,
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: isArabic
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      child: Text(
                                        "${text.date}: ",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Color(0XFF202020),
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.w700),
                                      ))),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (today && tomorrow ||
                                        today && !tomorrow) {
                                      isTodaySelected = true;
                                    }
                                  });
                                },
                                child: Container(
                                  margin: isArabic
                                      ? EdgeInsets.only(right: 15.w, top: 8.h)
                                      : EdgeInsets.only(left: 15.w, top: 8.h),
                                  width: 80.w,
                                  height: 28.h,
                                  decoration: BoxDecoration(
                                      color: !today
                                          ? Color.fromRGBO(244, 67, 54, 0.322)
                                          : null,
                                      borderRadius: BorderRadius.circular(6.r),
                                      border: Border.all(
                                        width: 2,
                                        color: today
                                            ? (isTodaySelected
                                                ? Color(0xff04CBCB)
                                                : Color(0xff000000)
                                                    .withOpacity(0.25))
                                            : Color.fromRGBO(
                                                244, 67, 54, 0.322),
                                      )),
                                  child: Center(
                                      child: Text(
                                    text.today,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0XFF202020),
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (today && tomorrow ||
                                        !today && tomorrow) {
                                      isTodaySelected =
                                          false; // Deselect the other option
                                    }
                                  });
                                },
                                child: Container(
                                  margin: isArabic
                                      ? EdgeInsets.only(right: 15.w, top: 8.h)
                                      : EdgeInsets.only(left: 15.w, top: 8.h),
                                  width: 80.w,
                                  height: 28.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
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
                                  child: Center(
                                      child: Text(
                                    text.tomorrow,
                                    style: TextStyle(
                                        fontSize: 14.sp,
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
                                  borderRadius: BorderRadius.circular(20.r)),
                              margin: EdgeInsets.symmetric(
                                  vertical: 22.h, horizontal: 60.w),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                                child: Text(
                                  text.book_appointment,
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      color: Colors.white,
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Loading();
            }
          }),
    ));
  }
}
