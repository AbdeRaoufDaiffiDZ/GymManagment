// ignore_for_file: camel_case_types

import 'package:dawini_full/core/error/ErrorWidget.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/details.dart';
import 'package:dawini_full/patient_features/domain/usecases/patients_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class myfavdoctors extends StatefulWidget {
  final int fontSize;

  const myfavdoctors({
    super.key,
    required this.fontSize,
  });

  @override
  State<myfavdoctors> createState() => _favoriteState();
}

class _favoriteState extends State<myfavdoctors> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // final PatientsBloc patientsBloc = BlocProvider.of<PatientsBloc>(context);
    final AppLocalizations text = AppLocalizations.of(context)!;
    final GetDoctorsInfoUseCase getDoctorsInfoUseCase = GetDoctorsInfoUseCase();
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
            child: FutureBuilder(
                future: GetFavoriteDoctorsUseCase.excute(),
                builder: (context, uids) {
                  if (uids.data != null && uids.data!.isNotEmpty) {
                    return StreamBuilder<List<DoctorEntity>>(
                        stream: getDoctorsInfoUseCase.streamDoctorInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Loading();
                          }
                          if (snapshot.hasError) {
                            return ErrorPage(
                              error: snapshot.error,
                            );
                            // Text('Error: ${snapshot.error}');
                          }

                          // final uids =
                          List<DoctorEntity> doctor = [];
                          if (snapshot.data == null) {
                            doctor = [];
                            return const Loading();
                          } else {
                            if (snapshot.data!.isEmpty) {
                              doctor = [];
                              return const Loading();
                            } else {
                              for (var uid in uids.data!) {
                                for (var element in snapshot.data!) {
                                  if (element.uid == uid) {
                                    doctor.add(element);
                                  }
                                }
                              }

                              if (doctor.isEmpty) {
                                doctor = [];
                                return Container();
                              } else {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 8
                                            .h), // Adjust the top margin as needed
                                    child: ListView(
                                      children: [
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount:
                                                      2, // Number of columns in the grid
                                                  crossAxisSpacing: 2
                                                      .w, // Spacing between columns
                                                  mainAxisExtent: 220.h),
                                          itemCount: doctor
                                              .length, // Number of items in the grid
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          doctorDetails(
                                                            uid: doctor[index]
                                                                .uid,
                                                            fontSize:
                                                                widget.fontSize,
                                                          )),
                                                );
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 7.h,
                                                      horizontal: 7.w),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.r),
                                                    border: Border.all(
                                                      color: Colors
                                                          .grey, // Set the border color
                                                      width: 1
                                                          .w, // Set the border width
                                                    ),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(8),
                                                        color: const Color
                                                                .fromARGB(31,
                                                                204, 204, 204)
                                                            .withOpacity(0.3),
                                                        height: 100.h,
                                                        width: double.infinity,
                                                        child: (doctor[index]
                                                                        .ImageProfileurl ==
                                                                    " " ||
                                                                doctor[index]
                                                                        .ImageProfileurl ==
                                                                    "")
                                                            ? Image.asset(
                                                                "assets/images/maleDoctor.png",
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                scale: 4.3,
                                                              )
                                                            : Image.network(
                                                                doctor[index]
                                                                    .ImageProfileurl,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                      ),
                                                      Container(
                                                        margin: isArabic
                                                            ? EdgeInsets.only(
                                                                right: 4.w)
                                                            : EdgeInsets.only(
                                                                left: 4.w),
                                                        width: double.infinity,
                                                        height: 20.h,
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: isArabic
                                                              ? Alignment
                                                                  .topRight
                                                              : Alignment
                                                                  .topLeft,
                                                          child: Text(
                                                              "${text.dr}. ${isArabic ? doctor[index].lastNameArabic : doctor[index].lastName}",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: 17
                                                                          .sp -
                                                                      widget
                                                                          .fontSize
                                                                          .sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: const Color(
                                                                      0XFF202020))),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: isArabic
                                                            ? EdgeInsets.only(
                                                                right: 4.w)
                                                            : EdgeInsets.only(
                                                                left: 4.w),
                                                        width: double.infinity,
                                                        height: 20.h,
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: isArabic
                                                              ? Alignment
                                                                  .topRight
                                                              : Alignment
                                                                  .topLeft,
                                                          child: Text(
                                                              isArabic
                                                                  ? doctor[index]
                                                                      .specialityArabic
                                                                  : doctor[
                                                                          index]
                                                                      .speciality,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: 15
                                                                          .sp -
                                                                      widget
                                                                          .fontSize
                                                                          .sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: const Color(
                                                                      0XFF000000))),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: isArabic
                                                            ? EdgeInsets.only(
                                                                right: 2.w)
                                                            : EdgeInsets.only(
                                                                left: 2.w),
                                                        width: double.infinity,
                                                        height: 20.h,
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: isArabic
                                                              ? Alignment
                                                                  .topRight
                                                              : Alignment
                                                                  .topLeft,
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on,
                                                                size: 16.sp,
                                                                color: Colors
                                                                    .black45,
                                                              ),
                                                              Text(
                                                                  "${doctor[index].city},${doctor[index].wilaya}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize: 15
                                                                              .sp -
                                                                          widget
                                                                              .fontSize
                                                                              .sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: const Color(
                                                                              0XFF202020)
                                                                          .withOpacity(
                                                                              0.75))),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: isArabic
                                                            ? EdgeInsets.only(
                                                                right: 3.w)
                                                            : EdgeInsets.only(
                                                                left: 3.w),
                                                        width: double.infinity,
                                                        height: 20.h,
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: isArabic
                                                              ? Alignment
                                                                  .bottomRight
                                                              : Alignment
                                                                  .bottomLeft,
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons.circle,
                                                                  size: 12.sp,
                                                                  color: doctor[
                                                                              index]
                                                                          .atSerivce
                                                                      ? Colors
                                                                          .teal
                                                                      : Colors
                                                                          .red),
                                                              SizedBox(
                                                                  width: 4.w),
                                                              Text(
                                                                  doctor[index]
                                                                          .atSerivce
                                                                      ? text
                                                                          .at_service
                                                                      : text
                                                                          .not_at_service,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize: 16.sp -
                                                                          widget
                                                                              .fontSize
                                                                              .sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: const Color(
                                                                          0XFF202020))),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        });
                  } else {
                    return Container();
                  }
                })));
  }
}
