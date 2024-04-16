// ignore_for_file: camel_case_types, sized_box_for_whitespace

import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/patients_info_bloc/patients_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class secondConatiner extends StatefulWidget {
    final int fontSize;

  final String uid;
  final int turn;
  const secondConatiner({super.key, required this.uid, required this.turn, required this.fontSize});

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
                                      fontSize: 14.sp- widget.fontSize.sp),
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
                                      fontSize: 29.sp - widget.fontSize.sp),
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
                                          fontSize: 16.sp- widget.fontSize.sp,
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
                                          ? "${locale.age}: ${data.first.age} "
                                          : " ",
                                      style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 14.sp- widget.fontSize.sp,
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
                                          ? "${locale.gender}: ${data.first.gender} "
                                          : " ",
                                      style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 19.sp- widget.fontSize.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 100.w,
                                  height: 17.h,
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: isArabic
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.phone, size: 15),
                                          Text(
                                            data.isNotEmpty
                                                ? data.first.phoneNumber
                                                : "   ",
                                            style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 16.sp- widget.fontSize.sp,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff202020)
                                                    .withOpacity(0.85)),
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
                                fontSize: 19.sp- widget.fontSize.sp,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: locale.patients_are_waiting,
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    color: const Color(0xff000000)
                                        .withOpacity(0.5),
                                    fontSize: 18.sp- widget.fontSize.sp,
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          else {
            return   Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Container(
                    height: 90.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 1.5, color: Colors.grey.withOpacity(0.23)),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: const Center()  ),
                );
              
          }
        } else {
          return Center(
            child: Column(
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
                                  "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontFamily: "Nunito",
                                      fontSize: 14.sp- widget.fontSize.sp),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontFamily: "Nunito",
                                      fontSize: 29.sp- widget.fontSize.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.h, horizontal: 6.w),
                          child: Container(
                            width: 190.w,
                            height: 22.h,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: isArabic
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              child: Text(
                                state.patients.first
                                    .firstName, 
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 16.sp- widget.fontSize.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else if (state is PatientsInfoLoadingError) {
        // patientsInfoBloc.add(onGetPatinets(uid: widget.uid));

        return const Center(
            // child: Container(
            //   margin: EdgeInsets.symmetric(horizontal: 8.w),
            //   child: Text(
            //     "No patient yet ",
            //     style: TextStyle(
            //         fontFamily: "Nunito",
            //         color: const Color(0xff202020),
            //         fontSize: 16.sp,
            //         fontWeight: FontWeight.w700),
            //   ),
            // ),
            );
      } else if (state is PatientsInfoLoading) {

        return const Loading();
      }
      else {
                patientsInfoBloc.add(onGetPatinets(uid: widget.uid, true, context));
        return const Loading();

      }
    });
  }
}
