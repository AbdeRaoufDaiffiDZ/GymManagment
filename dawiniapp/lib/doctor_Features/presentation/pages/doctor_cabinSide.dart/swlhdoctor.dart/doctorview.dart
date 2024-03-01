// ignore_for_file: camel_case_types

import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_data_bloc/doctor_data_bloc.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/patients_info_bloc/patients_info_bloc.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctor_cabinSide.dart/swlhdoctor.dart/firstcontainer.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctor_cabinSide.dart/swlhdoctor.dart/secondcontainer.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctor_cabinSide.dart/swlhdoctor.dart/today_patinet.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Home/appBar.dart';
import 'package:dawini_full/patients/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final PatientsInfoBloc patientsInfoBloc =
        BlocProvider.of<PatientsInfoBloc>(context);
    return Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        body: BlocBuilder<DoctorPatientsBloc, DoctorPatientsState>(
            builder: (context, state) {
          if (state is doctorInfoLoaded) {
            DoctorEntity doctor = state.doctors
                .where((element) => element.uid == widget.uid)
                .toList()
                .first;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // shrinkWrap: true,
              children: [
                myAppbar(
                  popOrNot: false,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, top: 0.h),
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
                      padding: EdgeInsets.only(left: 5.w, top: 7.h),
                      child: Text(
                        doctor.atSerivce
                            ? "Booking allowed"
                            : "Booking disallowed",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: doctor.atSerivce
                                ? Colors.black
                                : const Color(0xff202020).withOpacity(0.7),
                            fontFamily: 'Nunito',
                            fontSize: 17.sp),
                      ),
                    ),
                    /*InkWell(
                      // TODO: this button was add to test patinet  data reload
                      onTap: () {
                        patientsInfoBloc.add(onGetPatinets(uid: widget.uid));
                      },
                      child: Container(
                        width: 70.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                            color: Color(0xff04CBCB),
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.only(left: 30.w, top: 7.h),
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                          child: Text(
                            "Reload...",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )*/
                  ],
                ),
                firstConatiner(
                  doctor: doctor,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 9.w),
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Patientslist(
                                  
                                      
                                      uid: doctor.uid,
                                    ))));
                      }, ////////////////////
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
                TodayPatinet(uid: doctor.uid, turn: doctor.turn),
                Container(
                  color: Color(0xffFAFAFA),
                  height: 75.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},

                        ///-1
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 0.w),
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color(0xff00C8D5),
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 13.w),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 14.sp,
                                ),
                              ),
                              Text(
                                "Back",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Nunito",
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 0.w),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
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
                        onTap: () {},
                        child: Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color(0xff00C8D5),
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 17.w),
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Nunito",
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4.w),
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
            );
          } else if (state is doctorInfoInitial) {
            doctorPatientsBloc.add(LoadedDataDoctorPatinetsEvent());
          }

          return const Loading();
        }));
  }
}
