// ignore_for_file: camel_case_types

import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_data_bloc/doctor_data_bloc.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctor_cabinSide.dart/swlhdoctor.dart/firstcontainer.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctor_cabinSide.dart/swlhdoctor.dart/secondcontainer.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctor_cabinSide.dart/swlhdoctor.dart/today_patinet.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/Patient_Info.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Home/appBar.dart';
import 'package:dawini_full/patients/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class doctorview extends StatefulWidget {
  final int fontSize;

  final String uid;

  const doctorview({
    super.key,
    required this.uid,
    required this.fontSize,
    // this.uid,
    //required this.popOrNot,
  });

  @override
  State<doctorview> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<doctorview> {
  @override
  Widget build(BuildContext context) {
    final DoctorPatientsBloc doctorPatientsBloc =
        BlocProvider.of<DoctorPatientsBloc>(context);
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";
    if (widget.uid != "4OCo8desYHfXftOWtkY7DRHRFLm2") {
      return BlocBuilder<DoctorPatientsBloc, DoctorPatientsState>(
          builder: (context, state) {
        if (state is doctorInfoLoaded) {
          DoctorEntity doctor = state.doctors
              .where((element) => element.uid == widget.uid)
              .toList()
              .first;

          return Scaffold(
              backgroundColor: const Color(0xffFAFAFA),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // shrinkWrap: true,
                  children: [
                    myAppbar(
                      fontSize: widget.fontSize,
                      fromWhere: true, // navigate to patinet side
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: isArabic
                              ? EdgeInsets.only(right: 8.w, top: 0.h)
                              : EdgeInsets.only(left: 8.w, top: 0.h),
                          child: Switch(
                            splashRadius: 0,
                            trackOutlineWidth: MaterialStateProperty.all(0.0),
                            inactiveTrackColor:
                                const Color(0xff202020).withOpacity(0.15),
                            inactiveThumbColor: Colors.white,
                            activeColor: const Color.fromRGBO(255, 255, 255, 1),
                            activeTrackColor: const Color(0xff00C8D5),
                            value: doctor.atSerivce,
                            thumbIcon:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return Icon(
                                  Icons.check_rounded,
                                  size: 18.sp,
                                  color: const Color(0xff00C8D5),
                                );
                              }
                              return Icon(
                                Icons.close,
                                size: 20.sp,
                                color: const Color(0xff202020).withOpacity(0.7),
                              );
                            }),
                            onChanged: (value) {
                              // patientsInfoBloc.add(onGetPatinets(uid: widget.uid));

                              doctorPatientsBloc.add(onStateUpdate(
                                  doctor: doctor, state: !doctor.atSerivce));
                            },
                          ),
                        ),
                        Padding(
                          padding: isArabic
                              ? EdgeInsets.only(right: 5.w, top: 7.h)
                              : EdgeInsets.only(left: 5.w, top: 7.h),
                          child: Text(
                            doctor.atSerivce
                                ? locale.booking_allowed
                                : locale.booking_disallowed,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: doctor.atSerivce
                                    ? Colors.black
                                    : const Color(0xff202020).withOpacity(0.7),
                                fontFamily: 'Nunito',
                                fontSize: 17.sp - widget.fontSize.sp),
                          ),
                        ),
                      ],
                    ),
                    firstConatiner(
                      fontSize: widget.fontSize,
                      doctor: doctor,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 9.w),
                      child: Text(
                        "${locale.patient_in_examination} : ",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            color: const Color(0xff202020),
                            fontSize: 16.sp - widget.fontSize.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    secondConatiner(
                        fontSize: widget.fontSize,
                        uid: doctor.uid,
                        turn: doctor.turn),
                    Row(
                      children: [
                        Container(
                            margin: isArabic
                                ? EdgeInsets.only(right: 8.w)
                                : EdgeInsets.only(left: 8.w),
                            width: 130.w,
                            height: 23.h,
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: isArabic
                                    ? Alignment.bottomRight
                                    : Alignment.bottomLeft,
                                child: Text("${locale.today_s_patients} :",
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        color: Color(0xff202020),
                                        fontSize: 17.sp - widget.fontSize.sp,
                                        fontWeight: FontWeight.w800)))),
                        const Spacer(),
                        Container(
                          margin: isArabic
                              ? EdgeInsets.only(left: 8.w)
                              : EdgeInsets.only(right: 8.w),
                          width: 100.w,
                          height: 23.h,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: isArabic
                                ? Alignment.bottomLeft
                                : Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Patientslist(
                                              fontSize: widget.fontSize,
                                              uid: doctor.uid,
                                            ))));
                              },
                              child: Text("${locale.see_all} ",
                                  style: TextStyle(
                                      fontFamily: "Nunito",
                                      color: Color(0xff0AA9A9),
                                      fontSize: 14.sp - widget.fontSize.sp,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                        height: 170.h,
                        child: TodayPatinet(
                          uid: doctor.uid,
                          turn: doctor.turn,
                          fontSize: widget.fontSize,
                        )),
                    Container(
                      color: const Color(0xffFAFAFA),
                      height: 75.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              doctorPatientsBloc.add(onTurnUpdate(
                                  doctor: doctor, turn: doctor.turn - 1));
                            },

                            ///-1
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 0.w),
                              width: 100.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xff00C8D5),
                                  borderRadius: BorderRadius.circular(25.r)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: isArabic
                                        ? EdgeInsets.only(right: 13.w)
                                        : EdgeInsets.only(left: 13.w),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    locale.back,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Nunito",
                                        fontSize: 17.sp - widget.fontSize.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Patient_info(
                                            doctorEntity: doctor,
                                            today: true,
                                            ifADoctor: true,
                                            fontSize: widget.fontSize,
                                          )));
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 0.w),
                                width: 60.w,
                                height: 60.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff00C8D5),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 35.sp,
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              doctorPatientsBloc.add(onTurnUpdate(
                                  doctor: doctor, turn: doctor.turn + 1));
                            },
                            child: Container(
                              width: 100.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xff00C8D5),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: isArabic
                                        ? EdgeInsets.only(right: 17.w)
                                        : EdgeInsets.only(left: 17.w),
                                    child: Text(
                                      locale.next,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Nunito",
                                          fontSize: 17.sp - widget.fontSize.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: isArabic
                                        ? EdgeInsets.only(right: 4.w)
                                        : EdgeInsets.only(left: 4.w),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        } else if (state is doctorInfoInitial) {
          doctorPatientsBloc.add(LoadedDataDoctorPatinetsEvent());
        }

        return const Loading();
      });
    } else {
      return const Loading();
    }
  }
}
