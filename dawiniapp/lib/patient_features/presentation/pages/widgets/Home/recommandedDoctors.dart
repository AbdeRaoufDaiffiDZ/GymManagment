// ignore_for_file: file_names

import 'package:dawini_full/core/error/ErrorWidget.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommandedDoctors extends StatefulWidget {
  const RecommandedDoctors({super.key});

  @override
  State<RecommandedDoctors> createState() => _RecommandedDoctorsState();
}

class _RecommandedDoctorsState extends State<RecommandedDoctors> {
  final GetDoctorsInfoUseCase getDoctorsInfoUseCase = GetDoctorsInfoUseCase();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    int compareNumbers(DoctorEntity a, DoctorEntity b) =>
        b.recommanded - a.recommanded;
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";

    return StreamBuilder<List<DoctorEntity>>(
        stream: getDoctorsInfoUseCase.streamDoctorInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          if (snapshot.hasError) {
            return ErrorPage(
              error: snapshot.error,
            );
            // Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const Loading();
          }
          List<DoctorEntity> doctors;
          if (snapshot.data == null) {
            doctors = [];
          } else {
            if (snapshot.data!.isEmpty) {
              doctors = [];
            } else {
              doctors = snapshot.data!;
            }
          }

          doctors.sort(compareNumbers);

          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(
                  top: 1), // Adjust the top margin as needed
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 2.w, // Spacing between columns
                    mainAxisExtent: 220.h),
                itemCount: doctors.length, // Number of items in the grid
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => doctorDetails(
                                uid: doctors[index].uid, device: 'device')),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 7.h, horizontal: 7.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: Colors.grey, // Set the border color
                            width: 1.w, // Set the border width
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.all(8),
                                color: const Color.fromARGB(31, 204, 204, 204)
                                    .withOpacity(0.3),
                                height: 100.h,
                                width: double.infinity,
                                child: doctors[index].ImageProfileurl == " "
                                    ? Image.asset(
                                        "assets/images/maleDoctor.png",
                                        alignment: Alignment.center,
                                        scale: 4.3,
                                      )
                                    : Image.network(
                                        doctors[index].ImageProfileurl,
                                        fit: BoxFit.cover,
                                      )),
                            Container(
                              margin: EdgeInsets.only(left: 4.w),
                              width: double.infinity,
                              height: 20.h,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.topLeft,
                                child: Text("Dr.${doctors[index].lastName}",
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFF202020))),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 4.w),
                              width: double.infinity,
                              height: 20.h,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.topLeft,
                                child: Text(doctors[index].speciality,
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFF000000))),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 2.w),
                              width: double.infinity,
                              height: 20.h,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 16.sp,
                                      color: Colors.black45,
                                    ),
                                    Text(
                                        "${doctors[index].city},${doctors[index].wilaya}",
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0XFF202020)
                                                .withOpacity(0.75))),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: isArabic
                                  ? EdgeInsets.only(right: 3.w)
                                  : EdgeInsets.only(left: 3.w),
                              width: double.infinity,
                              height: 20.h,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: isArabic
                                    ? Alignment.bottomRight
                                    : Alignment.bottomLeft,
                                child: Row(
                                  children: [
                                    Icon(Icons.circle,
                                        size: 12.sp,
                                        color: doctors[index].atSerivce
                                            ? Colors.teal
                                            : Colors.red),
                                    SizedBox(width: 4.w),
                                    Text(
                                        doctors[index].atSerivce
                                            ? text.at_service
                                            : text.not_at_service,
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF202020))),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),
            ),
          );
        });
  }
}
