// ignore_for_file: camel_case_types, sized_box_for_whitespace

import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/patients_info_bloc/patients_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class secondConatiner extends StatefulWidget {
  final String uid;
  final int turn;
  const secondConatiner({super.key, required this.uid, required this.turn});

  @override
  State<secondConatiner> createState() => _secondConatinerState();
}

class _secondConatinerState extends State<secondConatiner> {
  @override
  Widget build(BuildContext context) {
    final PatientsInfoBloc patientsInfoBloc =
        BlocProvider.of<PatientsInfoBloc>(context);
    return BlocBuilder<PatientsInfoBloc, PatientsInfoState>(
        builder: (context, state) {
      if (state is PatientsInfoLoaded) {
        if (widget.turn != 0) {
          final data =
              state.patients.where((element) => element.turn == widget.turn);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Container(
                  height: 90.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 1.5, color: Colors.grey.withOpacity(0.23)),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
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
                                data.isNotEmpty
                                    ? (data.first.turn).toString()
                                    : widget.turn.toString(), // TODO:
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
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data.isNotEmpty
                                        ? "${data.first.firstName} ${data.first.lastName}"
                                        : "   ",
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
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data.isNotEmpty
                                        ? "Age: ${data.first.age} "
                                        : " ",
                                    style: const TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100.w,
                                height: 14.h,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data.isNotEmpty
                                        ? "Gender: ${data.first.gender} "
                                        : " ",
                                    style: const TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 19,
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
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.phone, size: 15),
                                        Text(
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
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: "Patients are waiting  ",
                              style: TextStyle(
                                  fontFamily: "Nunito",
                                  color:
                                      const Color(0xff000000).withOpacity(0.5),
                                  fontSize: 18,
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
          return const Center();
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
      } else {
        patientsInfoBloc.add(onGetPatinets(uid: widget.uid, true, context));

        return const Loading();
      }
    });
  }
}
