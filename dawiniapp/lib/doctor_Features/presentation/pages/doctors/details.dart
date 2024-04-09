import 'package:dawini_full/core/error/ErrorWidget.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/patient_features/domain/usecases/patients_usecase.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class doctorDetails extends StatefulWidget {
  final String uid;
  final device;

  const doctorDetails({super.key, required this.uid, this.device});

  @override
  State<doctorDetails> createState() => _doctorDetailsState();
}

bool isTodaySelected = false;
bool? favorite;
bool isTomorrowSelected = false;
Future<void> isFavortie(String uid) async {
  final uids = await GetFavoriteDoctorsUseCase.excute();
  if (uids.isNotEmpty) {
    for (var element in uids) {
      if (element == uid) {
        favorite = true;
        break;
      } else {
        favorite = false;
      }
    }
  } else {
    favorite = false;
  }
}

class _doctorDetailsState extends State<doctorDetails> {
  @override
  Widget build(BuildContext context) {
    final PatientsBloc patientsBloc = BlocProvider.of<PatientsBloc>(context);
    final GetDoctorsInfoUseCase getDoctorsInfoUseCase = GetDoctorsInfoUseCase();
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";

    final uid = widget.uid;
    isFavortie(uid);
    return Scaffold(
        body: SafeArea(
            child: StreamBuilder<List<DoctorEntity>>(
                stream: getDoctorsInfoUseCase.streamDoctorInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return ErrorPage(
                      error: snapshot.error,
                    );
                    // Text('Error: ${snapshot.error}');
                  }
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
                  List<DoctorEntity> doctor =
                      data.where((element) => element.uid == uid).toList();
                  if (doctor.isNotEmpty) {
                    if (doctor.first.date == "all") {
                    } else if (doctor.first.date == "today") {
                    } else if (doctor.first.date == "tomorrow") {
                    } else {}
                  }

                  if (doctor.isNotEmpty) {
                    return ListView(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 35.w,
                              height: 35.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffECF2F2),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: Color(0xff0AA9A9),
                                  )),
                            ),
                            SizedBox(width: 190.w),
                            Container(
                              width: 35.w,
                              height: 35.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffECF2F2),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    Share.share(doctor.first.location);
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                    size: 20,
                                    color: Color(0xff0AA9A9),
                                  )),
                            ),
                            SizedBox(width: 6.w),
                            Container(
                              width: 35.w,
                              height: 35.h,
                              margin: isArabic
                                  ? EdgeInsets.only(left: 8.w)
                                  : EdgeInsets.only(right: 8.w),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffECF2F2),
                              ),
                              child: IconButton(
                                  color: favorite! ? Colors.red : null,
                                  onPressed: () {
                                    setState(() {
                                      favorite = !favorite!;
                                      if (favorite!) {
                                        patientsBloc.add(onSetFavoriteDoctor(
                                            context,
                                            doctorUid: doctor.first.uid));
                                      } else {
                                        patientsBloc.add(onDeleteFavoriteDoctor(
                                            context,
                                            doctorUid: doctor.first.uid));
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    color: favorite! ? Colors.red : null,
                                    Icons.favorite_border,
                                    size: 20,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Stack(children: [
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
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 150.h,
                            width: double.infinity,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: doctor.first.ImageProfileurl == ''
                                    ? Image.asset(
                                        "assets/images/maleDoctor.png",
                                        alignment: Alignment.center,
                                        scale: 4.3,
                                      )
                                    : Image.network(
                                        doctor.first.ImageProfileurl,
                                        fit: BoxFit.cover,
                                      )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 195.w),
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 14.w),
                                height: 20.h,
                                width: 95.w,
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
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 6.w),
                                      child: Icon(Icons.circle,
                                          size: 10.sp, color: Colors.red),
                                    ),
                                    const Text("at service",
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF202020))),
                                  ],
                                )),
                          )
                        ]),
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
                                const Text(
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
                                      color:
                                          const Color(0xff202020).withOpacity(0.65)),
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
                          child: const FittedBox(
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
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          height: 100.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      height: 18.h,
                                      width: 190.w,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: 'Phone number 1 : ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Nunito",
                                                    color: const Color(0xff202020)
                                                        .withOpacity(0.65))),
                                            const TextSpan(
                                                text: '0557902660',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Nunito",
                                                    color: Color(0xff202020)))
                                          ]),
                                        ),
                                      )),
                                  Padding(
                                    padding: isArabic
                                        ? EdgeInsets.only(top: 55.h, right: 8.w)
                                        : EdgeInsets.only(top: 0.h, left: 65.w),
                                    child: InkWell(
                                      onTap: () async {
                                        final Uri uri =
                                            Uri(scheme: "tel"); // path: data.);
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(
                                              uri); //////////calling
                                        }
                                      },
                                      child: Container(
                                        height: 20.w,
                                        width: 42.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xff0AA9A9)),
                                            borderRadius:
                                                BorderRadius.circular(12.r)),
                                        child: Center(
                                            child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 5.h),
                                              child: Icon(
                                                Icons.phone,
                                                size: 10.sp,
                                                color: const Color(0xff0AA9A9),
                                              ),
                                            ),
                                            const Text(
                                              "Call",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff0AA9A9),
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      height: 18.h,
                                      width: 190.w,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: 'Phone number 2 : ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Nunito",
                                                    color: const Color(0xff202020)
                                                        .withOpacity(0.65))),
                                            const TextSpan(
                                                text: '1111111111',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Nunito",
                                                    color: Color(0xff202020)))
                                          ]),
                                        ),
                                      )),
                                  Padding(
                                    padding: isArabic
                                        ? EdgeInsets.only(top: 55.h, right: 8.w)
                                        : EdgeInsets.only(top: 0.h, left: 65.w),
                                    child: InkWell(
                                      onTap: () async {
                                        final Uri uri =
                                            Uri(scheme: "tel"); // path: data.);
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(
                                              uri); //////////calling
                                        }
                                      },
                                      child: Container(
                                        height: 20.w,
                                        width: 42.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xff0AA9A9)),
                                            borderRadius:
                                                BorderRadius.circular(12.r)),
                                        child: Center(
                                            child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 4.h),
                                              child: Icon(
                                                Icons.phone,
                                                size: 10.sp,
                                                color: const Color(0xff0AA9A9),
                                              ),
                                            ),
                                            const Text(
                                              "Call",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff0AA9A9),
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      height: 18.h,
                                      width: 220.w,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: 'Location : ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Nunito",
                                                    color: const Color(0xff202020)
                                                        .withOpacity(0.65))),
                                            const TextSpan(
                                                text: 'Boumerdes , Corso',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Nunito",
                                                    color: Color(0xff202020)))
                                          ]),
                                        ),
                                      )),
                                  Padding(
                                    padding: isArabic
                                        ? EdgeInsets.only(top: 55.h, right: 8.w)
                                        : EdgeInsets.only(top: 0.h, left: 8.w),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 20.w,
                                        width: 70.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xff0AA9A9)),
                                            borderRadius:
                                                BorderRadius.circular(12.r)),
                                        child: Center(
                                            child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 4.h),
                                              child: Icon(
                                                Icons.location_on,
                                                size: 10.sp,
                                                color: const Color(0xff0AA9A9),
                                              ),
                                            ),
                                            const Text(
                                              "on Maps",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff0AA9A9),
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          height: 18.h,
                          width: 160.w,
                          child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Experience :",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Nunito",
                                  color: Color(0xff202020)),
                            ),
                          )),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const ReadMoreText(
                          "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaassssssssssssssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaassssssssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                          trimLines: 3,
                          trimMode: TrimMode.Line,
                          textAlign: TextAlign.justify,
                          trimCollapsedText: " Read more.",
                          moreStyle: TextStyle(color: Color(0xff0AA9A9)),
                          trimExpandedText: " show less.",
                          lessStyle: TextStyle(color: Color(0xff0AA9A9)),
                        ),
                      ),
                      Center(
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 14.w),
                            height: 50.h,
                            width: 250.w,
                            decoration: BoxDecoration(
                                color: const Color(0xff00C8D5),
                                borderRadius: BorderRadius.circular(20.r)),
                            child: MaterialButton(
                                onPressed: () {
                                  _showCustomDialog(context);
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: const Text(
                                    "Book appointment",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontFamily: 'Nunito',
                                        fontSize: 22),
                                  ),
                                ))),
                      ),
                    ]);
                  } else {
                    return const Loading();
                  }
                })));
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          content: Container(
            width: double.infinity,
            height: 182.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Choose from available booking time :",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xff202020),
                      fontFamily: 'Nunito',
                      fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Ink(
                        decoration: BoxDecoration(
                            boxShadow: [
                              const BoxShadow(
                                  spreadRadius: 1.2,
                                  offset: Offset(0, 0),
                                  blurRadius: 1.2,
                                  color: Color(0xff2CDBC6))
                            ],
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(color: Colors.transparent)),
                        height: 40,
                        width: 110,
                        child: InkWell(
                          onTap: () {},
                          child: const Center(
                            child: Text(
                              "today",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff202020),
                                  fontFamily: 'Nunito',
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Ink(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              const BoxShadow(
                                  spreadRadius: 1.2,
                                  offset: Offset(0, 0),
                                  blurRadius: 1.2,
                                  color: Color(0xff2CDBC6))
                            ],
                            border: Border.all(
                              color: Colors.transparent,
                              width: 0,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        height: 40,
                        width: 110,
                        child: InkWell(
                          onTap: () {},
                          child: const Center(
                            child: Text(
                              "tomorrow",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff202020),
                                  fontFamily: 'Nunito',
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Ink(
                  decoration: BoxDecoration(
                      color: const Color(0xff00C8D5),
                      borderRadius: BorderRadius.circular(15)),
                  height: 40,
                  width: 230,
                  child: InkWell(
                    onTap: () {},
                    child: const Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: 'Nunito',
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Ink(
                  height: 40,
                  width: 230,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xff202020).withOpacity(0.5), width: 2),
                      borderRadius: BorderRadius.circular(15)),
                  child: InkWell(
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff202020).withOpacity(0.8),
                              fontFamily: 'Nunito',
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
