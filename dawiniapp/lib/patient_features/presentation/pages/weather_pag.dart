// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_typing_uninitialized_variables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_bloc/doctor_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Myappointment/appointments.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Home/appBar.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/doctorsList.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/favorite/favourites.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Home/serachMenu.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Home/specialityList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Weather extends StatefulWidget {
  final device;
  final String? uid;
  final bool popOrNot;

  const Weather({
    super.key,
    this.device,
    this.uid,
    required this.popOrNot,
  });

  @override
  State<Weather> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<Weather> {
  int selectedindex2 = 0;

  List<String> where = ["Home", "appointments", "favorite"];
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    final DoctorBloc dataBloc = BlocProvider.of<DoctorBloc>(context);
    final PatientsBloc patientsdataBloc =
        BlocProvider.of<PatientsBloc>(context);

    AppLocalizations text = AppLocalizations.of(context)!;

    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 6.r,
                blurRadius: 2.r,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              topRight: Radius.circular(40.r),
            ),
            border: Border.all(
              color: Colors.white,
              width: 1.w,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r)),
            child: BottomNavigationBar(
                backgroundColor: Colors.white,
                iconSize: 23.h,
                unselectedFontSize: 14.sp,
                selectedFontSize: 14.sp,
                currentIndex: selectedindex2,
                onTap: (value) {
                  setState(() {
                    selectedindex2 = value;
                  });
                },
                selectedItemColor: Color(0xFF2CDBC6),
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: text.home),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.medical_information),
                      label: text.my_Appointement),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: text.favorite)
                ]),
          ),
        ),
        drawerEnableOpenDragGesture: false,
        body: whereIam(text, dataBloc, patientsdataBloc));
  }

  Widget whereIam(
      AppLocalizations text, DoctorBloc dataBloc, PatientsBloc patientsBloc) {
    switch (selectedindex2) {
      case 0:
        return ListView(
          children: [
            myAppbar(
              uid: widget.uid,
              popOrNot: widget.popOrNot,
            ),
            Container(
              child: Column(children: [
                SearchMenu(),
                SizedBox(height: 10.h),

                // Container(
                //   margin: EdgeInsets.only(top: 4.h),
                //   padding: EdgeInsets.only(left: 9.w),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       SizedBox(
                //         width: 200.w,
                //         height: 20.h,
                //         child: AutoSizeText(text.recommended_clinics,
                //             style: TextStyle(
                //                 fontFamily: 'Nunito',
                //                 fontSize: 19.sp,
                //                 fontWeight: FontWeight.w600)),
                //       ),
                //       //   GestureDetector(
                //       //     onTap: () {
                //       //       Navigator.push(
                //       //           context,
                //       //           MaterialPageRoute(
                //       //             builder: (context) => Scaffold(
                //       //               appBar: AppBar(),
                //       //               body: Column(
                //       //                 children: [
                //       //                   SearchMenuClinics(),
                //       //                   SizedBox(
                //       //                     height: 20.h,
                //       //                   ),
                //       //                   // ClinicsList(),
                //       //                   ClinicWidget(
                //       //                     clinics: [],
                //       //                   )
                //       //                 ],
                //       //               ),
                //       //             ),
                //       //           ));
                //       //     },
                //       //     child: SizedBox(
                //       //       width: 80.w,
                //       //       height: 20.h,
                //       //       child: Center(
                //       //         child: AutoSizeText(text.see_all,
                //       //             style: TextStyle(
                //       //                 fontFamily: 'Nunito',
                //       //                 fontSize: 20.sp,
                //       //                 fontWeight: FontWeight.w600,
                //       //                 color: const Color(0xFF2CDBC6))),
                //       //       ),
                //       //     ),
                //       //   )
                //     ],
                //   ),
                // ),

                // SizedBox(height: 10.h),
                // Container(
                //     //  CLinics card
                //     child: ClinicsList()),
                // SizedBox(height: 16.h),

                // Specaility search scroll
                //crossAxisAlignment: CrossAxisAlignment.start,

                Container(
                  margin: EdgeInsets.only(top: 4.h),
                  padding: EdgeInsets.only(left: 9.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80.w,
                        height: 20.h,
                        child: Center(
                          child: AutoSizeText(text.specialty,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF2CDBC6))),
                        ),
                      ),
                      //   GestureDetector(     ///  this is search speciality button
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => doctorsideHome(
                      //                     popOrNot: true,
                      //                   )));
                      //     },
                      //     child: SizedBox(
                      //       width: 80.w,
                      //       height: 20.h,
                      //       child: Center(
                      //         child: AutoSizeText(text.search,
                      //             style: TextStyle(
                      //                 fontFamily: 'Nunito',
                      //                 fontSize: 20.sp,
                      //                 fontWeight: FontWeight.w600,
                      //                 color: const Color(0xFF2CDBC6))),
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),

                SpecialityList(),
                Padding(
                  padding: EdgeInsets.only(left: 7.w),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(text.recommended_doctors,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w600)),
                        /*SizedBox(
                            width: MediaQuery.of(context).size.width * 0.18,
                          ),*/
                        GestureDetector(
                          onTap: () {
                            dataBloc.add(onSeeAllDoctors());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => doctors()));
                          },
                          child: SizedBox(
                            width: 80.w,
                            height: 20.h,
                            child: Center(
                              child: AutoSizeText(text.see_all,
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF2CDBC6))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(child: DoctorsList()),
              ]),
            ),
          ],
        );
      case 1:
        patientsBloc.add(onPatientsReload());
        return Myappointemtns(uid: widget.uid);
      case 2:
        return favorite();
      default:
        return Container();
    }
  }
}

class doctors extends StatefulWidget {
  const doctors({super.key});

  @override
  State<doctors> createState() => _doctorsState();
}

class _doctorsState extends State<doctors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SearchMenu(),
          DoctorsList(device: "widget.device"),
        ],
      ),
    );
  }
}
