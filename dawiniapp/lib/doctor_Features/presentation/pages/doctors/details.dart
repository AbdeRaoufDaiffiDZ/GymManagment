//_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'package:dawini_full/core/error/ErrorWidget.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/Patient_Info.dart';
import 'package:dawini_full/patient_features/domain/usecases/patients_usecase.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class doctorDetails extends StatefulWidget {
  final String uid;
  final int fontSize;
  final DoctorEntity doctor;

  const doctorDetails(
      {super.key,
      required this.uid,
      required this.fontSize,
      required this.doctor});

  @override
  State<doctorDetails> createState() => _doctorDetailsState();
}

bool isTodaySelected = true;
bool? favorite;
bool isTomorrowSelected = false;
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

class _doctorDetailsState extends State<doctorDetails> {
  @override
  Widget build(BuildContext context) {
    final PatientsBloc patientsBloc = BlocProvider.of<PatientsBloc>(context);
    final GetDoctorsInfoUseCase getDoctorsInfoUseCase = GetDoctorsInfoUseCase();
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";
    final bool isFrench = Localizations.localeOf(context).languageCode == "fr";
    bool isMale = true;
    final AppLocalizations locale = AppLocalizations.of(context)!;

    final uid = widget.uid;
    isFavortie(uid);
    return Scaffold(
        body: SafeArea(
            child: StreamBuilder<List<DoctorEntity>>(
                stream: getDoctorsInfoUseCase.streamDoctorInfo(),
                builder: (context, snapshot) {
                  late final bool today, tomorrow;

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

                    void _showCustomDialog(BuildContext context,
                        AppLocalizations locale, DoctorEntity doctor) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              surfaceTintColor: Color(0xffFAFAFA),
                              content: SizedBox(
                                width: double.infinity,
                                height: 182.h,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      locale.choose_from_available_booking_time,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff202020),
                                          fontFamily: 'Nunito',
                                          fontSize: 15.sp),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 0.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Ink(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      spreadRadius:
                                                          isTodaySelected
                                                              ? 1
                                                              : 0,
                                                      offset:
                                                          const Offset(0, 0),
                                                      blurRadius: 2,
                                                      color: !today
                                                          ? Color.fromARGB(
                                                              71, 244, 67, 54)
                                                          : isTodaySelected
                                                              ? const Color(
                                                                  0xff0AA9A9)
                                                              : const Color(
                                                                      0xff202020)
                                                                  .withOpacity(
                                                                      0.5))
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                border: Border.all(
                                                    color: Colors.transparent,
                                                    width: 0)),
                                            height: 40.h,
                                            width: 90.w,
                                            child: InkWell(
                                              customBorder:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r)),
                                              onTap: () {
                                                setState(() {
                                                  if (today && tomorrow ||
                                                      today && !tomorrow) {
                                                    isTodaySelected = true;
                                                    isTomorrowSelected = false;
                                                  } 
                                                  
                                                });
                                              },
                                              child: Center(
                                                child: Text(
                                                  locale.today,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                              0xff202020)
                                                          .withOpacity(0.75),
                                                      fontFamily: 'Nunito',
                                                      fontSize: 15.sp),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          Ink(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      spreadRadius:
                                                          isTomorrowSelected
                                                              ? 1
                                                              : 0,
                                                      offset:
                                                          const Offset(0, 0),
                                                      blurRadius: 2,
                                                      color: !tomorrow
                                                          ? Colors.amber
                                                          : isTomorrowSelected
                                                              ? const Color(
                                                                  0xff0AA9A9)
                                                              : const Color(
                                                                      0xff202020)
                                                                  .withOpacity(
                                                                      0.5))
                                                ],
                                                border: Border.all(
                                                  color: Colors.transparent,
                                                  width: 0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.r)),
                                            height: 40.h,
                                            width: 90.w,
                                            child: InkWell(
                                              customBorder:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r)),
                                              onTap: () {
                                                setState(() {
                                                  if (today && tomorrow ||
                                                      !today && tomorrow) {
                                                    isTodaySelected =
                                                        false; // Deselect the other option
                                                    isTomorrowSelected = true;
                                                  }
                                                });
                                              },
                                              child: Center(
                                                child: Text(
                                                  locale.tomorrow,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                              0xff202020)
                                                          .withOpacity(0.75),
                                                      fontFamily: 'Nunito',
                                                      fontSize: 15.sp),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Ink(
                                      decoration: BoxDecoration(
                                          color: const Color(0xff00C8D5),
                                          borderRadius:
                                              BorderRadius.circular(15.w)),
                                      height: 40.h,
                                      width: 230.w,
                                      child: InkWell(
                                        customBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        onTap: () {
                                          // TODO: limit by number of patients
                                          if (tomorrow || today) {
                                            if (!isTodaySelected &&
                                                    !isTomorrowSelected ||
                                                !doctor.atSerivce) {
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          Patient_info(
                                                            doctorEntity:
                                                                doctor,
                                                            today:
                                                                isTodaySelected,
                                                            fontSize:
                                                                widget.fontSize,
                                                          )));
                                            }
                                          }
                                        },
                                        child: Center(
                                          child: Text(
                                            locale.next,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                fontFamily: 'Nunito',
                                                fontSize:
                                                    19.sp - widget.fontSize.sp),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Ink(
                                      height: 40.h,
                                      width: 230.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff202020)
                                                  .withOpacity(0.5),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15.w)),
                                      child: InkWell(
                                        customBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Center(
                                          child: Text(
                                            locale.cancel,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xff202020)
                                                    .withOpacity(0.8),
                                                fontFamily: 'Nunito',
                                                fontSize:
                                                    19.sp - widget.fontSize.sp),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                        },
                      );
                    }

                    isMale = doctor.first.gender == "male" ? true : false;
                    return ListView(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Row(
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
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 20.w,
                                    color: const Color(0xff0AA9A9),
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
                                  icon: Icon(
                                    Icons.share,
                                    size: 20.w,
                                    color: const Color(0xff0AA9A9),
                                  )),
                            ),
                            SizedBox(width: 6.w),
                            Container(
                              width: 35.w,
                              height: 35.h,
                              margin: isArabic
                                  ? EdgeInsets.only(left: 8.w)
                                  : EdgeInsets.only(right: 8.w),
                              decoration: const BoxDecoration(
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
                                    size: 20.w,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Stack(children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                              color: const Color(0xffF3F4F4),
                              borderRadius: BorderRadius.circular(20.w),
                            ),
                            height: 150.h,
                            width: double.infinity,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.w),
                                child: (doctor.first.ImageProfileurl == "" ||
                                        doctor.first.ImageProfileurl == " ")
                                    ? Image.asset(
                                        isMale
                                            ? "assets/images/maleDoctor.png"
                                            : "assets/images/maleDoctor.png", // TODO: add picture female
                                        alignment: Alignment.center,
                                        fit: BoxFit.scaleDown,
                                      )
                                    : Image.network(
                                        doctor.first.ImageProfileurl,
                                        fit: BoxFit.cover,
                                      )),
                          ),
                          Padding(
                            padding: isArabic
                                ? EdgeInsets.only(right: 195.w)
                                : EdgeInsets.only(left: 195.w),
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 14.w),
                                height: 20.h,
                                width: 95.w,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.w)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 6.w),
                                      child: Icon(Icons.circle,
                                          size: 10.sp,
                                          color: !doctor.first.atSerivce
                                              ? Colors.red
                                              : Colors.green),
                                    ),
                                    Text(
                                        doctor.first.atSerivce
                                            ? locale.at_service
                                            : locale.not_at_service,
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: isFrench
                                                ? 10.sp - widget.fontSize.sp
                                                : 12.sp - widget.fontSize.sp,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0XFF202020))),
                                  ],
                                )),
                          )
                        ]),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          height: 50.h,
                          width: 300.w,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Column(
                              children: [
                                Text(
                                  "${locale.dr}. ${isArabic ? doctor.first.firstNameArabic : doctor.first.firstName} ${isArabic ? doctor.first.lastNameArabic : doctor.first.lastName}",
                                  style: TextStyle(
                                      fontSize: 20.sp - widget.fontSize.sp,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Nunito",
                                      color: const Color(0xff202020)),
                                ),
                                Text(
                                  isArabic
                                      ? doctor.first.specialityArabic
                                      : doctor.first.speciality,
                                  style: TextStyle(
                                      fontSize: 17.sp - widget.fontSize.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Nunito",
                                      color: const Color(0xff202020)
                                          .withOpacity(0.65)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          height: 18.h,
                          width: 160.w,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: isArabic
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: Text(
                              locale.general_information,
                              style: TextStyle(
                                  fontSize: 20.sp - widget.fontSize.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Nunito",
                                  color: const Color(0xff202020)),
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          height: 100.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      height: 18.h,
                                      width: 190.w,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: isArabic
                                            ? Alignment.topRight
                                            : Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    "${locale.phone_number}: ",
                                                style: TextStyle(
                                                    fontSize: 14.sp -
                                                        widget.fontSize.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Nunito",
                                                    color: const Color(
                                                            0xff202020)
                                                        .withOpacity(0.65))),
                                            TextSpan(
                                                text: doctor.first.phoneNumber,
                                                style: TextStyle(
                                                    fontSize: 14.sp -
                                                        widget.fontSize.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Nunito",
                                                    color: const Color(
                                                        0xff202020)))
                                          ]),
                                        ),
                                      )),
                                  Padding(
                                    padding: isArabic
                                        ? EdgeInsets.only(top: 0.h, right: 65.w)
                                        : EdgeInsets.only(top: 0.h, left: 65.w),
                                    child: Container(
                                      height: 20.w,
                                      width: 42.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.4,
                                              color: const Color(0xff0AA9A9)),
                                          borderRadius:
                                              BorderRadius.circular(12.w)),
                                      child: InkWell(
                                        customBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.r)),
                                        onTap: () async {
                                          final Uri uri = Uri(
                                              scheme: "tel",
                                              path: doctor.first.phoneNumber);
                                          if (await canLaunchUrl(uri)) {
                                            await launchUrl(
                                                uri); //////////calling
                                          }
                                        },
                                        child: Center(
                                            child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 5.h),
                                              child: Icon(
                                                Icons.phone,
                                                size: 9.sp,
                                                color: const Color(0xff0AA9A9),
                                              ),
                                            ),
                                            Text(
                                              locale.call,
                                              style: TextStyle(
                                                  fontSize: isFrench
                                                      ? 10.sp -
                                                          widget.fontSize.sp
                                                      : 12.sp -
                                                          widget.fontSize.sp,
                                                  color:
                                                      const Color(0xff0AA9A9),
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      height: 18.h,
                                      width: 190.w,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: isArabic
                                            ? Alignment.topRight
                                            : Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    "${locale.phone_number}: ",
                                                style: TextStyle(
                                                    fontSize: 14.sp -
                                                        widget.fontSize.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Nunito",
                                                    color: const Color(
                                                            0xff202020)
                                                        .withOpacity(0.65))),
                                            TextSpan(
                                                text: doctor.first.phoneNumber,
                                                style: TextStyle(
                                                    fontSize: 14.sp -
                                                        widget.fontSize.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Nunito",
                                                    color: Color(0xff202020)))
                                          ]),
                                        ),
                                      )),
                                  Padding(
                                    padding: isArabic
                                        ? EdgeInsets.only(top: 0.h, right: 65.w)
                                        : EdgeInsets.only(top: 0.h, left: 65.w),
                                    child: InkWell(
                                      customBorder: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      onTap: () async {
                                        final Uri uri = Uri(
                                            scheme: "tel",
                                            path: doctor.first.phoneNumber);
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(
                                              uri); //////////calling
                                        }
                                      },
                                      child: Container(
                                        height: 20.w,
                                        width: 42.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.4,
                                                color: const Color(0xff0AA9A9)),
                                            borderRadius:
                                                BorderRadius.circular(12.r)),
                                        child: Center(
                                            child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 4.h),
                                              child: Icon(
                                                Icons.phone,
                                                size: 10.sp,
                                                color: const Color(0xff0AA9A9),
                                              ),
                                            ),
                                            Text(
                                              locale.call,
                                              style: TextStyle(
                                                  fontSize: isFrench
                                                      ? 10.sp -
                                                          widget.fontSize.sp
                                                      : 12.sp -
                                                          widget.fontSize.sp,
                                                  color: Color(0xff0AA9A9),
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      height: 18.h,
                                      width: 220.w,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: isArabic
                                            ? Alignment.topRight
                                            : Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    '${locale.link_location} : ',
                                                style: TextStyle(
                                                    fontSize: 14.sp -
                                                        widget.fontSize.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Nunito",
                                                    color: const Color(
                                                            0xff202020)
                                                        .withOpacity(0.65))),
                                            TextSpan(
                                                text:
                                                    "${doctor.first.city}, ${doctor.first.wilaya}",
                                                style: TextStyle(
                                                    fontSize: 14.sp -
                                                        widget.fontSize.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Nunito",
                                                    color: const Color(
                                                        0xff202020)))
                                          ]),
                                        ),
                                      )),
                                  Padding(
                                    padding: isArabic
                                        ? EdgeInsets.only(top: 0.h, right: 8.w)
                                        : EdgeInsets.only(top: 0.h, left: 8.w),
                                    child: Container(
                                      height: 20.w,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.4,
                                              color: const Color(0xff0AA9A9)),
                                          borderRadius:
                                              BorderRadius.circular(12.w)),
                                      child: Center(
                                        child: InkWell(
                                          customBorder: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r)),
                                          onTap: () async {
                                            final url = doctor.first.location;
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            }
                                          },
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 2.w,
                                                      vertical: 4.h),
                                                  child: Icon(
                                                    Icons.location_on,
                                                    size: 10.sp,
                                                    color:
                                                        const Color(0xff0AA9A9),
                                                  ),
                                                ),
                                                Text(
                                                  locale.on_maps,
                                                  style: TextStyle(
                                                      fontSize: isFrench
                                                          ? 10.sp -
                                                              widget.fontSize.sp
                                                          : 12.sp -
                                                              widget
                                                                  .fontSize.sp,
                                                      color: const Color(
                                                          0xff0AA9A9),
                                                      fontFamily: "Nunito",
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          height: 18.h,
                          width: 160.w,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: isArabic
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: Text(
                              "${locale.experience}:",
                              style: TextStyle(
                                  fontSize: 20.sp - widget.fontSize.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Nunito",
                                  color: const Color(0xff202020)),
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.all(8.w),
                        child: ReadMoreText(
                          doctor.first.experience,
                          trimLines: 3,
                          trimMode: TrimMode.Line,
                          textAlign: TextAlign.justify,
                          trimCollapsedText: "${locale.read_more}.",
                          moreStyle: const TextStyle(color: Color(0xff0AA9A9)),
                          trimExpandedText: " ${locale.show_less}.",
                          lessStyle: const TextStyle(color: Color(0xff0AA9A9)),
                        ),
                      ),
                      Center(
                        child: Container(
                            margin: EdgeInsets.only(
                                top: 70.h, left: 14.w, right: 14.w),
                            height: 45.h,
                            width: 245.w,
                            decoration: BoxDecoration(
                                color: const Color(0xff00C8D5),
                                borderRadius: BorderRadius.circular(20.r)),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r)),
                              onPressed: () {
                                _showCustomDialog(
                                    context, locale, doctor.first);
                              },
                              child: Text(
                                locale.book_appointment,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontFamily: 'Nunito',
                                    fontSize: 20.sp),
                              ),
                            )),
                      ),
                    ]);
                  } else {
                    return const Loading();
                  }
                })));
  }
}
