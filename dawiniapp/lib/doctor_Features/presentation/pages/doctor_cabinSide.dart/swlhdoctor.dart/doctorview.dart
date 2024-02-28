// ignore_for_file: camel_case_types

import 'package:dawini_full/doctor_Features/presentation/bloc/bloc_for_patients_data_from_doctor/doctor_patients_bloc.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctor_cabinSide.dart/swlhdoctor.dart/firstcontainer.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctor_cabinSide.dart/swlhdoctor.dart/secondcontainer.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Home/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class doctorview extends StatefulWidget {
  final String uid;
  final bool popOrNot;

  const doctorview({
    super.key,
    required this.uid,
    required this.popOrNot,
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
    return Scaffold(body: BlocBuilder<DoctorPatientsBloc, DoctorPatientsState>(
        builder: (context, state) {
      if (state is patintsInfoLoaded) {
        DoctorEntity doctor = state.doctors
            .where((element) => element.uid == widget.uid)
            .toList()
            .first;

        return ListView(
          children: [
            myAppbar(
              popOrNot: false,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.w, top: 5.h),
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
                      doctorPatientsBloc.add(onStateUpdate(
                          doctor: doctor, state: !doctor.atSerivce));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, top: 7.h),
                  child: Text(
                    doctor.atSerivce ? "Booking allowed" : "Booking disallowed",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: doctor.atSerivce
                            ? Colors.black
                            : const Color(0xff202020).withOpacity(0.7),
                        fontFamily: 'Nunito',
                        fontSize: 17.sp),
                  ),
                ),
              ],
            ),
            firstConatiner(
              doctor: doctor,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                "Patient in examination : ",
                style: TextStyle(
                    fontFamily: "Nunito",
                    color: const Color(0xff202020),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
            secondConatiner(uid: doctor.uid, turn: doctor.turn),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 3.h),
                width: 250.w,
                height: 30.h,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                        text: "25 ",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            color: const Color(0xff0AA9A9).withOpacity(0.7),
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                        children: [
                          TextSpan(
                            text: "Patients are waiting  ",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                color: const Color(0xff000000).withOpacity(0.5),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          )
                        ]),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 8.w),
                    width: 130.w,
                    height: 23.h,
                    child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.bottomLeft,
                        child: Text("Today's patients :",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                color: Color(0xff202020),
                                fontSize: 17,
                                fontWeight: FontWeight.w800)))),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      width: 100.w,
                      height: 23.h,
                      child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.bottomRight,
                          child: Text("See all list ",
                              style: TextStyle(
                                  fontFamily: "Nunito",
                                  color: Color(0xff0AA9A9),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)))),
                )
              ],
            ),
          ],
        );
      }
      doctorPatientsBloc.add(LoadedDataDoctorPatinetsEvent());

      return Loading();
    }));
  }
}
