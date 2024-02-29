// ignore_for_file: camel_case_types, sized_box_for_whitespace

import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/patients_info_bloc/patients_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class secondConatiner extends StatefulWidget {
  final String uid;
  final int turn;
  secondConatiner({super.key, required this.uid, required this.turn});

  @override
  State<secondConatiner> createState() => _secondConatinerState();
}

class _secondConatinerState extends State<secondConatiner> {
  @override
  Widget build(BuildContext context) {
    final PatientsInfoBloc patientsInfoBloc =
        BlocProvider.of<PatientsInfoBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Container(
        height: 95.h,
        decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: Colors.grey.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(12)),
        child: BlocBuilder<PatientsInfoBloc, PatientsInfoState>(
            builder: (context, state) {
          if (state is PatientsInfoLoaded) {
            final data = state.patients[widget.turn];
            return Row(
              children: [
                Container(
                  width: 66.w,
                  decoration: const BoxDecoration(
                    color: Color(0xff00C8D5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 4.w),
                        child: Text(
                          "Turn",
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
                          widget.turn.toString(), // TODO:
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
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 190.w,
                        height: 22.h,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${data.firstName} ${data.lastName}",
                            style: const TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Container(
                        width: 140.w,
                        height: 15.h,
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Age: widget.patinet ", // TODO: age does not exist in patient entity, create it
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Container(
                        width: 100.w,
                        height: 14.h,
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.topLeft,
                          child: Text(
                            "  widget.patinet .toString(), ", // TODO: gender does not exist in patinte entity, create it
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 19,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            width: 100.w,
                            height: 17.h,
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    const Icon(Icons.phone, size: 15),
                                    Text(
                                      data.phoneNumber,
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff202020)
                                              .withOpacity(0.85)),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(width: 23.w),
                          Container(
                            width: 100.w,
                            height: 15.h,
                            child: const FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.topRight,
                              child: Text(
                                  "afternoon ", // TODO: this must be removed since no longer  exists
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff0AA9A9),
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          } else if (state is PatientsInfoLoadingError) {
            // patientsInfoBloc.add(onGetPatinets(uid: widget.uid));

            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  "No patient yet ",
                  style: TextStyle(
                      fontFamily: "Nunito",
                      color: const Color(0xff202020),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
            );
          } else {
            patientsInfoBloc.add(onGetPatinets(uid: widget.uid));

            return const Loading();
          }
        }),
      ),
    );
  }
}
