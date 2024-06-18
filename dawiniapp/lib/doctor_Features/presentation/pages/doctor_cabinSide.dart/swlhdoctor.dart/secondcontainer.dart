// ignore_for_file: camel_case_types, sized_box_for_whitespace

import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/patients_info_bloc/patients_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class secondConatiner extends StatefulWidget {
  final int fontSize;

  final String uid;
  final int turn;
  const secondConatiner(
      {super.key,
      required this.uid,
      required this.turn,
      required this.fontSize});

  @override
  State<secondConatiner> createState() => _secondConatinerState();
}

class _secondConatinerState extends State<secondConatiner> {
  @override
  Widget build(BuildContext context) {
    final PatientsInfoBloc patientsInfoBloc =
        BlocProvider.of<PatientsInfoBloc>(context);
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";
    return BlocBuilder<PatientsInfoBloc, PatientsInfoState>(
        builder: (context, state) {
      if (state is PatientsInfoLoaded) {
        if (state.patients.first.firstName != "No Patients ") {
          if (widget.turn != 0) {
            final data =
                state.patients.where((element) => element.turn == widget.turn);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Container(
                    height: 90.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 1.5, color: Colors.grey.withOpacity(0.23)),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Row(
                      children: [
                        Container(
                          width: 66.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff00C8D5),
                            borderRadius: isArabic
                                ? BorderRadius.only(
                                    topRight: Radius.circular(12.r),
                                    bottomRight: Radius.circular(12.r))
                                : BorderRadius.only(
                                    topLeft: Radius.circular(12.r),
                                    bottomLeft: Radius.circular(12.r)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 4.w),
                                child: Text(
                                  locale.turn,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontFamily: "Nunito",
                                      fontSize: 14.sp),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: Text(
                                  data.isNotEmpty
                                      ? (data.first.turn).toString()
                                      : widget.turn.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontFamily: "Nunito",
                                      fontSize: 29.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.h, horizontal: 6.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 190.w,
                                  height: 22.h,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: isArabic
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    child: Text(
                                      data.isNotEmpty
                                          ? "${data.first.firstName} ${data.first.lastName}"
                                          : "   ",
                                      style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 16.sp - widget.fontSize.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 140.w,
                                  height: 15.h,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: isArabic
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    child: Text(
                                      data.isNotEmpty
                                          ? "${data.first.age} years old "
                                          : " ",
                                      style: TextStyle(
                                          color: Color(0xff202020)
                                              .withOpacity(0.85),
                                          fontFamily: "Nunito",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100.w,
                                  height: 14.h,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: isArabic
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    child: Text(
                                      data.isNotEmpty
                                          ? "${data.first.gender} "
                                          : " ",
                                      style: TextStyle(
                                          color: Color(0xff202020)
                                              .withOpacity(0.85),
                                          fontFamily: "Nunito",
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 120.w,
                                  height: 17.h,
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: isArabic
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.phone, size: 16),
                                          Padding(
                                            padding: EdgeInsets.only(left: 4.w),
                                            child: Text(
                                              data.isNotEmpty
                                                  ? data.first.phoneNumber
                                                  : "   ",
                                              style: TextStyle(
                                                  fontFamily: 'Nunito',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: const Color(0xff202020)
                                                      .withOpacity(0.85)),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 250.w,
                    height: 30.h,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                            text: "${state.patients.length - widget.turn} ",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                color: const Color(0xff0AA9A9).withOpacity(0.7),
                                fontSize: 19.sp - widget.fontSize.sp,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: locale.patients_are_waiting,
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    color: const Color(0xff000000)
                                        .withOpacity(0.5),
                                    fontSize: 18.sp - widget.fontSize.sp,
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.h),
              child: Container(
                  height: 71.h,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 25.h,
                        width: 240.w,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "No patient is currently being examined . ",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xff202020).withOpacity(0.75)),
                          ),
                        ),
                      ),
                      Container(
                          height: 25.h,
                          width: 270.w,
                          child: FittedBox(
                            alignment: Alignment.topLeft,
                            fit: BoxFit.scaleDown,
                            child: Text.rich(TextSpan(
                                text: "Use the",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    color: const Color(0xff202020)
                                        .withOpacity(0.7),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                                children: [
                                  TextSpan(
                                    text: " 'Next' ",
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        color: const Color(0xff0AA9A9),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: "button to start the turn sequence .",
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        color: const Color(0xff202020)
                                            .withOpacity(0.7),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                ])),
                          )),
                    ],
                  )),
            );
          }
        } else {
          return Center(
            child: Column(
              children: [
                Container(
                  height: 209.h,
                  width: 175.w,
                  child: Image.asset(
                    "assets/images/Group 43.png",
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 20.h),
                    width: 240,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 200.w,
                          height: 30.h,
                          child: FittedBox(
                            alignment: Alignment.center,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "text.noAppointmentsHere",
                              style: TextStyle(
                                  color: Color(0Xff202020),
                                  fontFamily: "Nunito",
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.w,
                          height: 40.h,
                          child: FittedBox(
                            alignment: Alignment.center,
                            fit: BoxFit.scaleDown,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Find a doctor of choice and take ",
                                    style: TextStyle(
                                      color: Color(0Xff202020).withOpacity(0.5),
                                      fontFamily: "Nunito",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "\nan appointment",
                                    style: TextStyle(
                                      color: Color(0Xff202020).withOpacity(0.5),
                                      fontFamily: "Nunito",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          );
        }
      } else if (state is PatientsInfoLoadingError) {
        // patientsInfoBloc.add(onGetPatinets(uid: widget.uid));

        return Container();
      } else if (state is PatientsInfoLoading) {
        return const Loading();
      } else {
        patientsInfoBloc.add(onGetPatinets(uid: widget.uid, true, context));
        return const Loading();
      }
    });
  }
}
