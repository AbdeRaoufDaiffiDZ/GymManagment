// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_typing_uninitialized_variables, camel_case_types

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dawini_full/auth/presentation/welcomePage.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/doctorsList.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/doctor_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Home/appBar.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Home/recommandedDoctors.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Home/serachMenu.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Home/specialityList.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Myappointment/appointments.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/favorite/favourites.dart';
import 'package:dawini_full/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Weather extends StatefulWidget {
  final int fontSize;

  const Weather({
    super.key,
    required this.fontSize,
  });

  @override
  State<Weather> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<Weather> {
  int selectedindex2 = 0;

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    final DoctorBloc dataBloc = BlocProvider.of<DoctorBloc>(context);
    final PatientsBloc patientsdataBloc =
        BlocProvider.of<PatientsBloc>(context);
    final AppLocalizations text = AppLocalizations.of(context)!;

    return Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        floatingActionButton: MaterialButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsPage(
                          fontSize: widget.fontSize,
                        )));
          },
          child: Icon(Icons.settings),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border:
                  Border.all(width: 1.4, color: Colors.grey.withOpacity(0.3))),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: BottomNavigationBar(
              iconSize: 21.sp,
              backgroundColor: Colors.white,
              unselectedFontSize: 13.sp,
              selectedFontSize: 13.sp,
              currentIndex: selectedindex2,
              onTap: (value) {
                setState(() {
                  selectedindex2 = value;
                });
              },
              selectedItemColor: Color(0xFF2CDBC6),
              unselectedItemColor: Color(0xff202020).withOpacity(0.6),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: text.home),
                BottomNavigationBarItem(
                    icon: Container(
                      height: 25.h,
                      width: 25.w,
                      child: Image.asset(
                        "assets/images/myapoin.png",
                        color: selectedindex2 == 1
                            ? Color(0xFF2CDBC6)
                            : Color(0xff202020).withOpacity(1),
                      ),
                    ),
                    label: text.my_Appointement),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_rounded), label: text.favorite)
              ],
            ),
          ),
        ),
        drawerEnableOpenDragGesture: false,
        body: whereIam(text, dataBloc, patientsdataBloc));
  }

  Widget whereIam(
      AppLocalizations text, DoctorBloc dataBloc, PatientsBloc patientsBloc) {
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";

    switch (selectedindex2) {
      case 0:
        return ListView(
          children: [
            myAppbar(
              fontSize: widget.fontSize,
              fromWhere: false, // navigate to doctor side
            ),
            Container(
              child: Column(children: [
                SearchMenu(fontSize: widget.fontSize, isHome: true),
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
                  padding: isArabic
                      ? EdgeInsets.only(right: 9.w)
                      : EdgeInsets.only(left: 4.w),
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
                                  fontSize: 16.sp - widget.fontSize.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF202020))),
                        ),
                      ),
                      InkWell(
                          customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r)),
                        ///  this is search speciality button
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => doctorsideHome(
                          //               fontSize: 2,
                          //             )));
                        },
                        child: SizedBox(
                          width: 80.w,
                          height: 20.h,
                          child: Center(
                            child: AutoSizeText(text.search,
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF0AA9A9))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SpecialityList(
                  fontSize: widget.fontSize,
                ),
                Padding(
                  padding: isArabic
                      ? EdgeInsets.only(right: 7.w)
                      : EdgeInsets.only(left: 12.w),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(text.recommended_doctors,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 16.sp - widget.fontSize.sp,
                                fontWeight: FontWeight.bold)),
                        InkWell(
                            customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r)),
                          onTap: () {
                            dataBloc.add(onSeeAllDoctors());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => doctors(
                                          fontSize: widget.fontSize,
                                        )));
                          },
                          child: SizedBox(
                            width: 80.w,
                            height: 20.h,
                            child: Center(
                              child: AutoSizeText(text.see_all,
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF0AA9A9))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    child: RecommandedDoctors(
                  fontSize: widget.fontSize,
                )),
              ]),
            ),
          ],
        );
      case 1:
        patientsBloc.add(onPatientsReload());
        return Myappointemtns(
          fontSize: widget.fontSize,
        );
      case 2:
        return favorite(
          fontSize: widget.fontSize,
        );
      default:
        return Container();
    }
  }
}

class doctors extends StatefulWidget {
  final int fontSize;

  const doctors({super.key, required this.fontSize});

  @override
  State<doctors> createState() => _doctorsState();
}

class _doctorsState extends State<doctors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: ListView(
        children: [
          SearchMenu(
            fontSize: widget.fontSize,
            isHome: false,
          ),
          DoctorsList(
            fontSize: widget.fontSize,
          ),
        ],
      ),
    );
  }
}
