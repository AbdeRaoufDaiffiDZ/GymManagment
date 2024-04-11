// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_data_bloc/doctor_data_bloc.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/customRaadio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum AppState { free, picked, cropped }

class Lll extends StatefulWidget {
  final DoctorEntity doctorInfo;
  const Lll({super.key, required this.doctorInfo});

  @override
  State<Lll> createState() => _doctorDetailsState();
}

class _doctorDetailsState extends State<Lll> {
  File? imageFile;
  String ImageUrl = "";
  late AppState state;
  TextEditingController first_phone_number = TextEditingController();
  TextEditingController second_phone_number = TextEditingController();
  TextEditingController location_link = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController max_number_of_patient = TextEditingController();
  TextEditingController experience = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int val = 1;

  @override
  void initState() {
    super.initState();
    state = AppState.free;
    first_phone_number.text = widget.doctorInfo.phoneNumber;
    location_link.text = widget.doctorInfo.location;
    location.text = widget.doctorInfo.wilaya;
    max_number_of_patient.text = widget.doctorInfo.numberOfPatient.toString();
    experience.text = widget.doctorInfo.experience;
    switch (widget.doctorInfo.date) {
      case "today":
        val = 1;
        break;
      case "all":
        val = 2;
        break;
      case "tomorrow":
        val = 3;

        break;
      default:
        break;
    }
  }

  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    final DoctorPatientsBloc doctorPatientsBloc =
        BlocProvider.of<DoctorPatientsBloc>(context);
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";

    return Scaffold(
        backgroundColor: const Color(0xffFAFAFA),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 10.w),
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffECF2F2),
                      ),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 23.sp,
                            color: const Color(0xff0AA9A9),
                          )),
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            color: const Color(0xffF3F4F4),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          height: 150.h,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: (widget.doctorInfo.ImageProfileurl == " " ||
                                    widget.doctorInfo.ImageProfileurl == "")
                                ? imageFile == null
                                    ? Image.asset(
                                        "assets/images/maleDoctor.png",
                                        fit: BoxFit.scaleDown,
                                        scale: 1.2.w,
                                      )
                                    : Image.file(
                                        imageFile!,
                                        fit: BoxFit.fill,
                                      )
                                : Image.network(
                                    widget.doctorInfo.ImageProfileurl,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 14.w),
                            height: 25.h,
                            width: 110.w,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.r)),
                            child: MaterialButton(
                                onPressed: imagee,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.camera_alt_rounded,
                                      color: Color(0xff0AA9A9),
                                      size: 9.w,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Text(
                                        locale.add_a_photo,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff202020)
                                                .withOpacity(0.65),
                                            fontFamily: 'Nunito',
                                            fontSize: 11.sp),
                                      ),
                                    )
                                  ],
                                )))
                      ],
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        height: 50.h,
                        width: 300.w,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Column(
                            children: [
                              Text(
                                "${widget.doctorInfo.firstName} ${widget.doctorInfo.lastName}  ${widget.doctorInfo.lastNameArabic} ${widget.doctorInfo.firstNameArabic}",
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Nunito",
                                    color: Color(0xff202020)),
                              ),
                              Text(
                                "${widget.doctorInfo.speciality}  ${widget.doctorInfo.specialityArabic}",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Nunito",
                                    color: const Color(0xff202020)
                                        .withOpacity(0.65)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        height: 18.h,
                        width: 160.w,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment:
                              isArabic ? Alignment.topRight : Alignment.topLeft,
                          child: Text(
                            locale.general_information,
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Nunito",
                                color: Color(0xff202020)),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              color: Colors.white,
                              width: 150.w,
                              height: 35.h,
                              child: TextFormField(
                                  onEditingComplete: () {
                                    // Move focus to the next field when "Next" is pressed
                                    FocusScope.of(context).nextFocus();
                                  },
                                  validator: /////////////////////////////////////////////////////////////////////
                                      (value) {
                                    if (value == null || value.isEmpty) {
                                      return locale.please_enter_your +
                                          locale.phone_number;
                                    }
                                    return null;
                                  }, // Set the validator function
                                  controller: first_phone_number,
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                    color: const Color(0xff202020)
                                        .withOpacity(0.7),
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.w),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Colors.grey.shade300),
                                      borderRadius:
                                          BorderRadius.circular(5.0.r),
                                    ),
                                    suffixIcon: Text("*",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            color: Color(0xffEF1B1B))),
                                    suffixIconConstraints: BoxConstraints(
                                        minHeight: 38.h, minWidth: 12.w),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 22.w,
                                    ),
                                    isDense: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Colors.grey.shade300),
                                      borderRadius:
                                          BorderRadius.circular(5.0.r),
                                    ),
                                    hintText: locale.add_a_phone_number,
                                    hintStyle: TextStyle(
                                        color: const Color(0xff202020)
                                            .withOpacity(0.75),
                                        fontSize: 11.sp,
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w700),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(top: 2.h),
                                      child: Icon(
                                        Icons.phone_rounded,
                                        size: 11.sp,
                                        color: const Color(0xff0AA9A9),
                                      ),
                                    ),
                                  ))),
                          Container(
                              color: Colors.white,
                              width: 150.w,
                              height: 35.h,
                              child: TextFormField(
                                  onEditingComplete: () {
                                    // Move focus to the next field when "Next" is pressed
                                    FocusScope.of(context).nextFocus();
                                  },
                                  controller: second_phone_number,
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                    color: const Color(0xff202020)
                                        .withOpacity(0.7),
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.r),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 22.w,
                                    ),
                                    isDense: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    hintText: locale.another_phone_number,
                                    hintStyle: TextStyle(
                                        color: const Color(0xff202020)
                                            .withOpacity(0.75),
                                        fontSize: 10.5.sp,
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w700),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(top: 2.h),
                                      child: Icon(
                                        Icons.phone_rounded,
                                        size: 11.sp,
                                        color: const Color(0xff0AA9A9),
                                      ),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: Container(
                              color: Colors.white,
                              width: 150.w,
                              height: 35.h,
                              child: TextFormField(
                                  onEditingComplete: () {
                                    // Move focus to the next field when "Next" is pressed
                                    FocusScope.of(context).nextFocus();
                                  },
                                  validator: /////////////////////////////////////////////////////////////////////
                                      (value) {
                                    if (value == null || value.isEmpty) {
                                      return locale.please_enter_your +
                                          locale.link_location;
                                    }
                                    return null;
                                  }, // Set the validator function
                                  controller: location,
                                  style: TextStyle(
                                    color: const Color(0xff202020)
                                        .withOpacity(0.7),
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.w),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    suffixIcon: Text("*",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            color: Color(0xffEF1B1B))),
                                    suffixIconConstraints: BoxConstraints(
                                        minHeight: 38.h, minWidth: 12.w),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 22.w,
                                    ),
                                    isDense: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Colors.grey.shade300),
                                      borderRadius:
                                          BorderRadius.circular(5.0.r),
                                    ),
                                    hintText: locale.please_enter_your +
                                        locale.cabin_adress,
                                    hintStyle: TextStyle(
                                        color: const Color(0xff202020)
                                            .withOpacity(0.75),
                                        fontSize: 11.sp,
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w700),
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      size: 11.sp,
                                      color: const Color(0xff0AA9A9),
                                    ),
                                  ))),
                        ),
                        Container(
                            color: Colors.white,
                            width: 150.w,
                            height: 35.h,
                            child: TextFormField(
                                onEditingComplete: () {
                                  // Move focus to the next field when "Next" is pressed
                                  FocusScope.of(context).nextFocus();
                                },
                                controller: location_link,
                                style: TextStyle(
                                  color:
                                      const Color(0xff202020).withOpacity(0.7),
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8.r),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(5.0.r),
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 22.w,
                                  ),
                                  isDense: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(5.0.r),
                                  ),
                                  hintText: locale.please_enter_your +
                                      locale.link_location,
                                  hintStyle: TextStyle(
                                      color: const Color(0xff202020)
                                          .withOpacity(0.75),
                                      fontSize: 11.sp,
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w700),
                                  prefixIcon: Icon(
                                    Icons.link,
                                    size: 11.sp,
                                    color: const Color(0xff0AA9A9),
                                  ),
                                ))),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        height: 18.h,
                        width: 160.w,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment:
                              isArabic ? Alignment.topRight : Alignment.topLeft,
                          child: Text(
                            locale.booking_settings,
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Nunito",
                                color: Color(0xff202020)),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Container(
                          height: 35.h,
                          child: TextFormField(
                              onEditingComplete: () {
                                // Move focus to the next field when "Next" is pressed
                                FocusScope.of(context).nextFocus();
                              },
                              validator: /////////////////////////////////////////////////////////////////////
                                  (value) {
                                if (value == null || value.isEmpty) {
                                  return locale.please_enter_your +
                                      locale.maximum_number_of_patients_per_day;
                                }
                                return null;
                              }, // Set the validator function
                              controller: max_number_of_patient,
                              style: TextStyle(
                                color: const Color(0xff202020).withOpacity(0.7),
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8.r),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                suffixIcon: Text("*",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        color: Color(0xffEF1B1B))),
                                suffixIconConstraints: BoxConstraints(
                                    minHeight: 38.h, minWidth: 13.w),
                                prefixIconConstraints: BoxConstraints(
                                  minWidth: 22.w,
                                ),
                                isDense: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5.0.r),
                                ),
                                hintText:
                                    locale.maximum_number_of_patients_per_day,
                                hintStyle: TextStyle(
                                    color: const Color(0xff202020)
                                        .withOpacity(0.75),
                                    fontSize: 11.sp,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w700),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Icon(
                                    Icons.group,
                                    size: 12.sp,
                                    color: const Color(0xff0AA9A9),
                                  ),
                                ),
                              ))),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Container(
                        height: 90.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(0xffFFFFFF),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff202020).withOpacity(0.4),
                                blurRadius: 2,
                              )
                            ],
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5.r),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 18.h,
                                        width: 160.w,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: isArabic
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                  Icons.watch_later_rounded,
                                                  size: 14,
                                                  color: Color(0xff0AA9A9)),
                                              Text(
                                                locale.set_the_booking_time +
                                                    " :",
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Nunito",
                                                    color:
                                                        const Color(0xff202020)
                                                            .withOpacity(0.75)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      val = 1;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 4.h),
                                    height: 18.h,
                                    width: 130.w,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: isArabic
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Radiolist(
                                            groupvalue: val,
                                            value: 1,
                                            onchange: (int? value) {
                                              setState(() {
                                                val = value!;
                                              });
                                            },
                                          ),
                                          Padding(
                                            padding: isArabic
                                                ? EdgeInsets.only(right: 7.w)
                                                : EdgeInsets.only(left: 7.w),
                                            child: Text(
                                              "${locale.today} " + locale.only,
                                              style: TextStyle(
                                                  fontFamily: 'Nunito',
                                                  fontSize: 17.sp,
                                                  color: const Color(0xff202020)
                                                      .withOpacity(0.75),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      val = 2;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 8.h),
                                    height: 18.h,
                                    width: 140.w,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: isArabic
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Radiolist(
                                            groupvalue: val,
                                            value: 2,
                                            onchange: (int? value) {
                                              setState(() {
                                                val = value!;
                                              });
                                            },
                                          ),
                                          Padding(
                                            padding: isArabic
                                                ? EdgeInsets.only(right: 7.w)
                                                : EdgeInsets.only(left: 7.w),
                                            child: Text(
                                              locale.today +
                                                  locale.and +
                                                  locale.tomorrow,
                                              style: TextStyle(
                                                  color: const Color(0xff202020)
                                                      .withOpacity(0.75),
                                                  fontFamily: 'Nunito',
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: !isArabic
                                      ? EdgeInsets.only(right: 1.w)
                                      : EdgeInsets.only(left: 1.w),
                                  child: Text("*",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                          color: Color(0xffEF1B1B))),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      val = 3;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20.h),
                                    height: 18.h,
                                    width: 130.w,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: isArabic
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Radiolist(
                                            groupvalue: val,
                                            value: 3,
                                            onchange: (int? value) {
                                              setState(() {
                                                val = value!;
                                              });
                                            },
                                          ),
                                          Padding(
                                            padding: isArabic
                                                ? EdgeInsets.only(right: 7.w)
                                                : EdgeInsets.only(left: 7.w),
                                            child: Text(
                                              "${locale.tomorrow} " +
                                                  locale.only,
                                              style: TextStyle(
                                                  color: const Color(0xff202020)
                                                      .withOpacity(0.75),
                                                  fontFamily: 'Nunito',
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.r),
                      child: Container(
                        height: 25.h,
                        width: 190.w,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment:
                              isArabic ? Alignment.topRight : Alignment.topLeft,
                          child: Padding(
                            padding: isArabic
                                ? EdgeInsets.only(right: 7.w)
                                : EdgeInsets.only(left: 7.w),
                            child: Text(
                              "${locale.experience} :",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Nunito",
                                  color: Color(0xff202020)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 0.h, bottom: 10.h, left: 7.w, right: 7.w),
                      child: Container(
                          color: Colors.white,
                          height: 35.h,
                          child: TextFormField(
                              onEditingComplete: () {
                                // Move focus to the next field when "Next" is pressed
                                FocusScope.of(context).nextFocus();
                              },
                              validator: /////////////////////////////////////////////////////////////////////
                                  (value) {
                                if (value == null || value.isEmpty) {
                                  return locale.please_enter_your +
                                      " " +
                                      locale.experience;
                                }
                                return null;
                              }, // Set the validator function
                              controller: experience,
                              style: TextStyle(
                                color: const Color(0xff202020).withOpacity(0.7),
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8.r),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5.0.r),
                                ),
                                suffixIcon: Text("*",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        color: Color(0xffEF1B1B))),
                                suffixIconConstraints: BoxConstraints(
                                    minHeight: 38.h, minWidth: 13.w),
                                prefixIconConstraints: BoxConstraints(
                                  minWidth: 22.w,
                                ),
                                isDense: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5.0.r),
                                ),
                                hintText:
                                    locale.share_your_insights_and_expertise,
                                hintStyle: TextStyle(
                                    color: const Color(0xff202020)
                                        .withOpacity(0.75),
                                    fontSize: 11.sp,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w700),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(top: 3.h),
                                  child: Icon(
                                    Icons.edit,
                                    size: 12.sp,
                                    color: const Color(0xff0AA9A9),
                                  ),
                                ),
                              ))),
                    ),
                    Center(
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 14.w),
                          height: 50.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                              color: const Color(0xff00C8D5),
                              borderRadius: BorderRadius.circular(20.r)),
                          child: MaterialButton(
                              onPressed: () async {
                                String date = "all";
                                switch (val) {
                                  case 1:
                                    date = "today";
                                    break;
                                  case 2:
                                    date = "all";
                                    break;
                                  case 3:
                                    date = "tomorrow";

                                    break;
                                  default:
                                    break;
                                }
                                int number =
                                    int.parse(max_number_of_patient.text);
                                DoctorEntity doctor = DoctorEntity(
                                    recommanded: widget.doctorInfo.recommanded,
                                    numberOfPatient: number,
                                    numberInList:
                                        widget.doctorInfo.numberInList,
                                    location: location_link.text,
                                    date: date,
                                    experience: experience.text,
                                    description: "description",
                                    uid: widget.doctorInfo.uid,
                                    city: widget.doctorInfo.city,
                                    turn: widget.doctorInfo.turn,
                                    speciality: widget.doctorInfo.speciality,
                                    atSerivce: widget.doctorInfo.atSerivce,
                                    wilaya: location.text,
                                    firstName: widget.doctorInfo.firstName,
                                    lastName: widget.doctorInfo.lastName,
                                    phoneNumber: first_phone_number.text,
                                    firstNameArabic: 'firstNameArabic', // TODO:
                                    lastNameArabic: 'lastNameArabic',
                                    specialityArabic: 'specialityArabic',
                                    ImageProfileurl:
                                        widget.doctorInfo.ImageProfileurl);

                                if (_formKey.currentState!.validate()) {
                                  await toUpload(widget.doctorInfo.uid, doctor,
                                      doctorPatientsBloc);

                                  Navigator.pop(context, 'Cancel');
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Text(
                                  locale.save,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontFamily: 'Nunito',
                                      fontSize: 22.sp),
                                ),
                              ))),
                    ),
                  ]),
            ),
          ),
        ));
  }

  /* Future<void> _croppeed() async {
    CroppedFile? croppedFile = await ImageCropper()
        .cropImage(sourcePath: imageFile!.path, aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ], uiSettings: [
      AndroidUiSettings(
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        toolbarTitle: 'Crop Image',
        statusBarColor: Colors.deepOrangeAccent,
        initAspectRatio: CropAspectRatioPreset.original,
        backgroundColor: Colors.white,
        lockAspectRatio: false,
      ),
    ]);

    if (croppedFile != null) {
      imageFile = File(croppedFile.path);

      setState(() {
        state = AppState.cropped;
      });
    }
  }*/

  imagee() async {
    ImagePicker imagePicker = ImagePicker();

    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  Reference referenceRoot = FirebaseStorage.instance.ref().child('images');
  Future toUpload(String uid, DoctorEntity doctor, doctorPatientsBloc) async {
    Reference referenceIpageToUpload = referenceRoot.child(uid);
    try {
      if (doctor.ImageProfileurl == " " || doctor.ImageProfileurl == "") {
        if (imageFile != null) {
          await referenceIpageToUpload.putFile(File(imageFile!.path));
          ImageUrl = await referenceIpageToUpload.getDownloadURL();

          if (kDebugMode) {
            print(ImageUrl);
          }
          doctor.ImageProfileurl = ImageUrl;
        }
      }
      doctorPatientsBloc.add(onDataUpdate(doctor: doctor));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
