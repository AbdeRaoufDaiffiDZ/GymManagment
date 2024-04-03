import 'dart:io';


import 'package:dawini_full/doctor_Features/presentation/pages/doctors/customRaadio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';


enum AppState { free, picked, cropped }

class Lll extends StatefulWidget {
  const Lll({super.key});

  @override
  State<Lll> createState() => _doctorDetailsState();
}

class _doctorDetailsState extends State<Lll> {
  File? imageFile;
  late AppState state;
  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  String selectedOption = '';
  int val = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        body: SafeArea(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
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
                          offset: Offset(0, 0),
                        ),
                      ],
                      color: Color(0xffF3F4F4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 150.h,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: imageFile == null
                          ? Image.asset(
                              "assets/images/maleDoctor.png",
                              fit: BoxFit.scaleDown,
                              scale: 1.2.w,
                            )
                          : Image.file(
                              imageFile!,
                              fit: BoxFit.fill,
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
                              offset: Offset(0, 0),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                          onPressed: imagee,
                          child: Row(
                            children: [
                              Icon(
                                Icons.camera_alt_rounded,
                                color: Color(0xff0AA9A9),
                                size: 14,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Text(
                                  "add a photo",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Color(0xff202020).withOpacity(0.65),
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
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
                          "Dr. Chergui walid",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Nunito",
                              color: Color(0xff202020)),
                        ),
                        Text(
                          "Generalist",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Nunito",
                              color: Color(0xff202020).withOpacity(0.65)),
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
                    alignment: Alignment.topLeft,
                    child: Text(
                      "General information :",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Nunito",
                          color: Color(0xff202020)),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        color: Colors.white,
                        width: 150.w,
                        height: 35.h,
                        child: TextFormField(
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              color: Color(0xff202020).withOpacity(0.7),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              suffixIcon: Text("*",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color(0xffEF1B1B))),
                              suffixIconConstraints: BoxConstraints(
                                  minHeight: 38.h, minWidth: 12.w),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 22.w,
                              ),
                              isDense: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: 'add a phone number',
                              hintStyle: TextStyle(
                                  color: Color(0xff202020).withOpacity(0.75),
                                  fontSize: 11.sp,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 2.h),
                                child: Icon(
                                  Icons.phone_rounded,
                                  size: 11.sp,
                                  color: Color(0xff0AA9A9),
                                ),
                              ),
                            ))),
                    Container(
                        color: Colors.white,
                        width: 150.w,
                        height: 35.h,
                        child: TextFormField(
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              color: Color(0xff202020).withOpacity(0.7),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 22.w,
                              ),
                              isDense: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: 'another phone number',
                              hintStyle: TextStyle(
                                  color: Color(0xff202020).withOpacity(0.75),
                                  fontSize: 10.5.sp,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 2.h),
                                child: Icon(
                                  Icons.phone_rounded,
                                  size: 11.sp,
                                  color: Color(0xff0AA9A9),
                                ),
                              ),
                            ))),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        color: Colors.white,
                        width: 150.w,
                        height: 35.h,
                        child: TextFormField(
                            style: TextStyle(
                              color: Color(0xff202020).withOpacity(0.7),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              suffixIcon: Text("*",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color(0xffEF1B1B))),
                              suffixIconConstraints: BoxConstraints(
                                  minHeight: 38.h, minWidth: 12.w),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 22.w,
                              ),
                              isDense: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: 'enter your location',
                              hintStyle: TextStyle(
                                  color: Color(0xff202020).withOpacity(0.75),
                                  fontSize: 11.sp,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700),
                              prefixIcon: Icon(
                                Icons.location_on,
                                size: 11.sp,
                                color: Color(0xff0AA9A9),
                              ),
                            ))),
                  ),
                  Container(
                      color: Colors.white,
                      width: 150.w,
                      height: 35.h,
                      child: TextFormField(
                          style: TextStyle(
                            color: Color(0xff202020).withOpacity(0.7),
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5, color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 22.w,
                            ),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5, color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintText: 'paste location link ',
                            hintStyle: TextStyle(
                                color: Color(0xff202020).withOpacity(0.75),
                                fontSize: 11.sp,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700),
                            prefixIcon: Icon(
                              Icons.link,
                              size: 11.sp,
                              color: Color(0xff0AA9A9),
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
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Booking settings :",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Nunito",
                          color: Color(0xff202020)),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 35.h,
                    child: TextFormField(
                        style: TextStyle(
                          color: Color(0xff202020).withOpacity(0.7),
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5, color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          suffixIcon: Text("*",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xffEF1B1B))),
                          suffixIconConstraints:
                              BoxConstraints(minHeight: 38.h, minWidth: 13.w),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 22.w,
                          ),
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5, color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          hintText: 'Set a maximum number of patients per day ',
                          hintStyle: TextStyle(
                              color: Color(0xff202020).withOpacity(0.75),
                              fontSize: 11.sp,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Icon(
                              Icons.group,
                              size: 12.sp,
                              color: Color(0xff0AA9A9),
                            ),
                          ),
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 90.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff202020).withOpacity(0.4),
                          blurRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.r),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 18.h,
                                  width: 160.w,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Icon(Icons.watch_later_rounded,
                                            size: 14, color: Color(0xff0AA9A9)),
                                        Text(
                                          " Set the booking time :",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Nunito",
                                              color: Color(0xff202020)
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
                                alignment: Alignment.topLeft,
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
                                      padding: EdgeInsets.only(left: 7.w),
                                      child: Text(
                                        "Today only",
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 17,
                                            color: Color(0xff202020)
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
                                alignment: Alignment.topLeft,
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
                                      padding: EdgeInsets.only(left: 7.w),
                                      child: Text(
                                        "Today and tomorrow ",
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 17,
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
                            padding: EdgeInsets.only(right: 1.w),
                            child: Text("*",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
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
                                alignment: Alignment.topLeft,
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
                                      padding: EdgeInsets.only(left: 7.w),
                                      child: Text(
                                        "Tomorrow only",
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 17,
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
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 7.w),
                      child: Text(
                        "Experience :",
                        style: TextStyle(
                            fontSize: 14,
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
                        style: TextStyle(
                          color: Color(0xff202020).withOpacity(0.7),
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.r),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5, color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          suffixIcon: Text("*",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: Color(0xffEF1B1B))),
                          suffixIconConstraints:
                              BoxConstraints(minHeight: 38, minWidth: 13),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 22.w,
                          ),
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5, color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          hintText: 'Share your insights and expertise',
                          hintStyle: TextStyle(
                              color: Color(0xff202020).withOpacity(0.75),
                              fontSize: 11.sp,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(top: 3.h),
                            child: Icon(
                              Icons.edit,
                              size: 12.sp,
                              color: Color(0xff0AA9A9),
                            ),
                          ),
                        ))),
              ),
              Center(
                child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
                    height: 50.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                        color: Color(0xff00C8D5),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: MaterialButton(
                        onPressed: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: 'Nunito',
                                fontSize: 22),
                          ),
                        ))),
              ),
            ]),
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
}
