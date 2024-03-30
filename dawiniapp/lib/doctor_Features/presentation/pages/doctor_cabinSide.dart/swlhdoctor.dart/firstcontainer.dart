// ignore_for_file: camel_case_types, sized_box_for_whitespace

import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class firstConatiner extends StatefulWidget {
  final DoctorEntity doctor;
  const firstConatiner({super.key, required this.doctor});

  @override
  State<firstConatiner> createState() => _firstConatinerState();
}

class _firstConatinerState extends State<firstConatiner> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border.all(width: 1.5.w, color: Colors.grey.withOpacity(0.23)),
            borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 3.h, horizontal: 8.w),
                height: 57.h,
                width: 57.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color(0xff202020).withOpacity(0.4))),
                child: GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    "assets/images/maleDoctor.png",
                    alignment: Alignment.center,
                    scale: 4.3,
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 180.w,
                  height: 25.h,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment:
                        isArabic ? Alignment.topRight : Alignment.topLeft,
                    child: Text(
                      "${locale.dr}. ${widget.doctor.firstName}",
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  width: 180.w,
                  height: 20.h,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment:
                        isArabic ? Alignment.topRight : Alignment.topLeft,
                    child: Text.rich(TextSpan(
                        text: locale.max_number_of_patients + " : ", // TODO:
                        style: TextStyle(
                            fontFamily: "Nunito",
                            color: const Color(0xff202020).withOpacity(0.7),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: "25", // TODO:
                            style: TextStyle(
                                fontFamily: "Nunito",
                                color: const Color(0xff0AA9A9).withOpacity(0.7),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ])),
                  ),
                ),
                Container(
                  width: 175.w,
                  height: 20.h,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment:
                        isArabic ? Alignment.topRight : Alignment.topLeft,
                    child: Text.rich(TextSpan(
                        text: locale.booking_period + " : ", // TODO:
                        style: TextStyle(
                            fontFamily: "Nunito",
                            color: const Color(0xff202020).withOpacity(0.7),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: locale.today, // TODO:
                            style: TextStyle(
                                fontFamily: "Nunito",
                                color: const Color(0xff0AA9A9).withOpacity(0.7),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ])),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 44.h),
              child: InkWell(
                onTap: () {}, ////////////////////////
                child: Container(
                  height: 20.h,
                  width: 42.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff0AA9A9)),
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Center(
                      child: Text(
                    locale.edit,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xff0AA9A9),
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w700),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
