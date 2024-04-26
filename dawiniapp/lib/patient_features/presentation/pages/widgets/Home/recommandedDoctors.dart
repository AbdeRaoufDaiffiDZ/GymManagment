// ignore_for_file: file_names

import 'package:dawini_full/core/error/ErrorWidget.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/details.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/doctor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommandedDoctors extends StatefulWidget {
  final int fontSize;

  const RecommandedDoctors({super.key, required this.fontSize});

  @override
  State<RecommandedDoctors> createState() => _RecommandedDoctorsState();
}

class _RecommandedDoctorsState extends State<RecommandedDoctors> {
  final GetDoctorsInfoUseCase getDoctorsInfoUseCase = GetDoctorsInfoUseCase();
  bool isMale = true;
  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    int compareNumbers(DoctorEntity a, DoctorEntity b) =>
        b.recommanded - a.recommanded;
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";
    final bool isFrench = Localizations.localeOf(context).languageCode == "fr";

    return BlocBuilder<DoctorBloc, DoctorState>(builder: (context, state) {
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
                if (state is DoctorFilterSpeciality) {
                  if (state.speciality != text.all.toLowerCase()) {
                    if (isFrench) {
                      doctors = snapshot.data!
                          .where((element) =>
                              element.specialityFrench.toLowerCase() ==
                              state.speciality)
                          .toList();
                    } else {
                      doctors = snapshot.data!
                          .where((element) => isArabic
                              ? element.specialityArabic.toLowerCase() ==
                                  state.speciality
                              : element.speciality.toLowerCase() ==
                                  state.speciality)
                          .toList();
                    }
                  } else {
                    doctors = snapshot.data!;
                  }
                } else {
                  doctors = snapshot.data!;
                }
              }
            }

            doctors.sort(compareNumbers);

            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 10.w), // Adjust the top margin as needed
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      crossAxisSpacing: 10.w, // Spacing between columns
                      mainAxisExtent: 178.h,
                      mainAxisSpacing: 12.h),

                  itemCount: doctors.length, // Number of items in the grid
                  itemBuilder: (context, index) {
                    isMale = doctors[index].gender == "male" ? true : false;
                    return InkWell(
                      customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => doctorDetails(
  doctor: doctors[index],
                                    fontSize: widget.fontSize,
                                    uid: doctors[index].uid,                                  )),
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
                                  child: (doctors[index].ImageProfileurl ==
                                              " " ||
                                          doctors[index].ImageProfileurl == "")
                                      ? Image.asset(
                                          "assets/images/maleDoctor.png",
                                          alignment: Alignment.center,
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          child: Image.network(
                                            doctors[index].ImageProfileurl,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                              Container(
                                margin: isArabic
                                    ? EdgeInsets.only(right: 4.w)
                                    : EdgeInsets.only(left: 5.w),
                                width: double.infinity,
                                height: 20.h,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: isArabic
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  child: Text(
                                      "${text.dr}. ${isArabic ? doctors[index].lastNameArabic : doctors[index].lastName}",
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
                                    : EdgeInsets.only(left: 5.w),
                                width: double.infinity,
                                height: 15.h,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: isArabic
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  child: Text(
                                      isArabic
                                          ? doctors[index].specialityArabic
                                          : doctors[index].speciality,
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 15.sp - widget.fontSize.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0XFF000000))),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3.w),
                                width: double.infinity,
                                height: 15.h,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: isArabic
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
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
                                              fontSize:
                                                  15.sp - widget.fontSize.sp,
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
                                    : EdgeInsets.only(left: 5.w),
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
                                          color: doctors[index].atSerivce
                                              ? Color(0xff2CDBC6)
                                              : Colors.red),
                                      SizedBox(width: 4.w),
                                      Text(
                                          doctors[index].atSerivce
                                              ? text.at_service
                                              : text.not_at_service,
                                          style: TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize:
                                                  16.sp - widget.fontSize.sp,
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
          });
    });
  }
}
