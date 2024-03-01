// ignore_for_file: camel_case_types, sized_box_for_whitespace

import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_data_bloc/doctor_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class firstConatiner extends StatefulWidget {
  final DoctorEntity doctor;
  firstConatiner({super.key, required this.doctor});

  @override
  State<firstConatiner> createState() => _firstConatinerState();
}

class _firstConatinerState extends State<firstConatiner> {
  @override
  Widget build(BuildContext context) {
    final DoctorPatientsBloc doctorPatientsBloc =
        BlocProvider.of<DoctorPatientsBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border.all(width: 1.5, color: Colors.grey.withOpacity(0.23)),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 3.h, horizontal: 8.w),
                height: 57.w,
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
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Dr. ${widget.doctor.firstName}",
                      style: const TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  width: 180.w,
                  height: 20.h,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topLeft,
                    child: Text.rich(TextSpan(
                        text: "max number of patients : ", // TODO:
                        style: TextStyle(
                            fontFamily: "Nunito",
                            color: const Color(0xff202020).withOpacity(0.7),
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: "25",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                color: const Color(0xff0AA9A9).withOpacity(0.7),
                                fontSize: 12,
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
                    alignment: Alignment.topLeft,
                    child: Text.rich(TextSpan(
                        text: "Booking period : ", // TODO:
                        style: TextStyle(
                            fontFamily: "Nunito",
                            color: const Color(0xff202020).withOpacity(0.7),
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: "today", // TODO:
                            style: TextStyle(
                                fontFamily: "Nunito",
                                color: const Color(0xff0AA9A9).withOpacity(0.7),
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          )
                        ])),
                  ),
                ),
              ],
            ),
            /*  Column(
              // TODO: there is a column add in order to add next and previous buttons
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.h,
                      left: 0
                          .w), // TODO: top value is 44.h but I changed it in order to test, when you finish rewrite it
                  child: Container(
                    height: 20.w,
                    width: 42.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff0AA9A9)),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                        child: Text(
                      "Edit",
                      style: TextStyle(
                          color: Color(0xff0AA9A9),
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w700),
                    )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 5.h,
                      left: 0
                          .w), // TODO: top value is 44.h but I changed it in order to test, when you finish rewrite it
                  child: GestureDetector(
                    onTap: () {
                      doctorPatientsBloc.add(onTurnUpdate(
                          doctor: widget.doctor, turn: widget.doctor.turn + 1));
                    },
                    child: Container(
                      height: 20.w,
                      width: 42.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff0AA9A9)),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                          child: Text(
                        "next",
                        style: TextStyle(
                            color: Color(0xff0AA9A9),
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700),
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 5.h,
                      left: 0
                          .w), // TODO: top value is 44.h but I changed it in order to test, when you finish rewrite it
                  child: GestureDetector(
                    onTap: () {
                      print("pressed next");
                      doctorPatientsBloc.add(onTurnUpdate(
                          doctor: widget.doctor, turn: widget.doctor.turn - 1));
                    },
                    child: Container(
                      height: 20.w,
                      width: 42.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff0AA9A9)),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                          child: Text(
                        "past",
                        style: TextStyle(
                            color: Color(0xff0AA9A9),
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700),
                      )),
                    ),
                  ),
                ),
              ],
            ),*/
            Padding(
              padding: EdgeInsets.only(top: 44.h),
              child: InkWell(
                onTap: () {}, ////////////////////////
                child: Container(
                  height: 20.w,
                  width: 42.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff0AA9A9)),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                      child: Text(
                    "Edit",
                    style: TextStyle(
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
