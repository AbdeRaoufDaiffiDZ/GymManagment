// ignore_for_file: camel_case_types

import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_data_bloc/doctor_data_bloc.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctor_cabinSide.dart/swlhdoctor.dart/firstcontainer.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctor_cabinSide.dart/swlhdoctor.dart/secondcontainer.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctor_cabinSide.dart/swlhdoctor.dart/today_patinet.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/Patient_Info.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Home/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            body: Column(
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
                        thumbIcon: MaterialStateProperty.resolveWith((states) {
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
                          : EdgeInsets.only(left: 5.w, top: 4.h),
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
                            fontSize: 19),
                      ),
                    ),
                  ],
                ),
                firstConatiner(
                  fontSize: widget.fontSize,
                  doctor: doctor,
                ),
                secondConatiner(
                    fontSize: widget.fontSize,
                    uid: doctor.uid,
                    turn: doctor.turn),
                TodayPatinet(
                  uid: doctor.uid,
                  turn: doctor.turn,
                  fontSize: widget.fontSize,
                ),
                Spacer(),
                Container(
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
                          width: 88.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff202020).withOpacity(0.2),
                                    blurRadius: 0.1,
                                    spreadRadius: 1.6)
                              ],
                              color: const Color(0xff00C8D5),
                              borderRadius: BorderRadius.circular(25.r)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: isArabic
                                    ? EdgeInsets.only(right: 13.w)
                                    : EdgeInsets.only(left: 15.w),
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
                                    fontSize: 17,
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
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff202020).withOpacity(0.2),
                                    blurRadius: 0.1,
                                    spreadRadius: 1.6)
                              ],
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
                          width: 88.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff202020).withOpacity(0.2),
                                    blurRadius: 0.1,
                                    spreadRadius: 1.6)
                              ],
                              color: const Color(0xff00C8D5),
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: isArabic
                                    ? EdgeInsets.only(right: 17.w)
                                    : EdgeInsets.only(left: 18.w),
                                child: Text(
                                  locale.next,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Nunito",
                                      fontSize: 17,
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
          );
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
