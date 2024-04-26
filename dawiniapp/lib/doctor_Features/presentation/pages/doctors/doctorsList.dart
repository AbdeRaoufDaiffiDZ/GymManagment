// ignore_for_file: file_names, prefer_typing_uninitialized_variables, duplicate_ignore

import 'package:dawini_full/core/error/ErrorWidget.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/details.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/Condtions/doctor_state_conditions.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/doctor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsList extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final int fontSize;

  const DoctorsList({
    super.key,
    required this.fontSize,
  });

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final GetDoctorsInfoUseCase getDoctorsInfoUseCase = GetDoctorsInfoUseCase();
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
          {
            late final List<DoctorEntity> data;
            if (snapshot.data == null) {
              data = [];
            } else {
              if (snapshot.data!.isEmpty) {
                data = [];
              } else {
                data = snapshot.data!;
              }
            }
            return BlocBuilder<DoctorBloc, DoctorState>(
                builder: (context, state) {
              return DoctorStateConditions(state, data,
                  fontSize: widget.fontSize);
            });
          }
        });
  }
}

class Doctors extends StatefulWidget {
  final int fontSize;
  final List<DoctorEntity> doctors;

  const Doctors({super.key, required this.fontSize, required this.doctors});

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";

    List<DoctorEntity> data = widget.doctors;
    bool isMale = true;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: 8.h, horizontal: 10.w), // Adjust the top margin as needed
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 10.w, // Spacing between columns
              mainAxisExtent: 178.h,
              mainAxisSpacing: 12.h),

          itemCount: data.length, // Number of items in the grid
          itemBuilder: (context, index) {
            isMale = data[index].gender == "male" ? true : false;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => doctorDetails(
                        doctor: data[index],
                            fontSize: widget.fontSize,
                            uid: data[index].uid,
                          )),
                );
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: Color(0XFF202020).withOpacity(0.09),
                      width: 1.2.w, // Set the border width
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.all(8),
                          height: 90.h,
                          width: double.infinity,
                          child: data[index].ImageProfileurl == " "
                              ? Image.asset(
                                  "assets/images/maleDoctor.png",
                                  alignment: Alignment.center,
                                )
                              : Image.network(
                                  data[index].ImageProfileurl,
                                  fit: BoxFit.cover,
                                )),
                      Container(
                        margin: isArabic
                            ? EdgeInsets.only(right: 4.w)
                            : EdgeInsets.only(left: 4.w),
                        width: double.infinity,
                        height: 20.h,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment:
                              isArabic ? Alignment.topRight : Alignment.topLeft,
                          child: Text(
                              "${text.dr}. ${isArabic ? data[index].lastNameArabic : data[index].lastName}",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 17.sp - widget.fontSize.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0XFF202020))),
                        ),
                      ),
                      Container(
                        margin: isArabic
                            ? EdgeInsets.only(left: 4.w)
                            : EdgeInsets.only(left: 4.w),
                        width: double.infinity,
                        height: 15.h,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment:
                              isArabic ? Alignment.topRight : Alignment.topLeft,
                          child: Text(
                              isArabic
                                  ? data[index].specialityArabic
                                  : data[index].speciality,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 15.sp - widget.fontSize.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0XFF000000))),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 2.w),
                        width: double.infinity,
                        height: 15.h,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment:
                              isArabic ? Alignment.topRight : Alignment.topLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16.sp,
                                color: Colors.black45,
                              ),
                              Text("${data[index].city},${data[index].wilaya}",
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 15.sp - widget.fontSize.sp,
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
                            : EdgeInsets.only(left: 4.w),
                        width: double.infinity,
                        height: 15.h,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: isArabic
                              ? Alignment.bottomRight
                              : Alignment.bottomLeft,
                          child: Row(
                            children: [
                              Icon(Icons.circle,
                                  size: 12.sp,
                                  color: data[index].atSerivce
                                      ? Color(0xff2CDBC6)
                                      : Colors.red),
                              SizedBox(width: 4.w),
                              Text(
                                  data[index].atSerivce
                                      ? text.at_service
                                      : text.not_at_service,
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 16.sp - widget.fontSize.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0XFF202020))),
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
  }
}