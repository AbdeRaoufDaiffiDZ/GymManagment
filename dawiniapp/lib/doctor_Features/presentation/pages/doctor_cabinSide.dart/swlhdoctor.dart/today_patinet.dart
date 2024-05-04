// ignore_for_file: camel_case_types, sized_box_for_whitespace

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/patients_info_bloc/patients_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class TodayPatinet extends StatefulWidget {
  final int fontSize;

  final int turn;
  final String uid;
  const TodayPatinet(
      {super.key,
      required this.uid,
      required this.turn,
      required this.fontSize});

  @override
  State<TodayPatinet> createState() => _TodayPatinetState();
}

class _TodayPatinetState extends State<TodayPatinet> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";
    final PatientsInfoBloc patientsInfoBloc =
        BlocProvider.of<PatientsInfoBloc>(context);
    return BlocBuilder<PatientsInfoBloc, PatientsInfoState>(
        builder: (context, state) {
      if (state is PatientsInfoLoaded) {
        return CustomMaterialIndicator(
          onRefresh: () async {
            patientsInfoBloc.add(onGetPatinets(true, context, uid: widget.uid));
          },
          indicatorBuilder:
              (BuildContext context, IndicatorController controller) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0XFF04CBCB),
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                height: 24.h,
                width: 24.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2.w,
                  color: Colors.white,
                  value: controller.isDragging || controller.isArmed
                      ? controller.value.clamp(0.0, 1.0)
                      : null,
                ),
              ),
            );
          },
          durations: const RefreshIndicatorDurations(
            completeDuration: Duration(seconds: 2),
          ),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.patients.length,
              itemBuilder: (context, index) {
                final data = state.patients[index];
                if (state.patients.first.firstName == "No Patients ") {
                  return Container();
                }
                return Padding(
                  padding: EdgeInsets.only(
                      top: 0.h, bottom: 10.h, left: 8.w, right: 8.w),
                  child: Container(
                    height: 86.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 1.5,
                            color: const Color.fromARGB(255, 219, 219, 219)
                                .withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Row(
                      children: [
                        Container(
                          width: 55.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: isArabic
                                ? BorderRadius.only(
                                    topRight: Radius.circular(12.r),
                                    bottomRight: Radius.circular(12.r))
                                : BorderRadius.only(
                                    topLeft: Radius.circular(12.r),
                                    bottomLeft: Radius.circular(12.r)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 4.w),
                                child: Text(
                                  locale.turn,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: data.turn == widget.turn
                                          ? const Color(0xff00C8D5)
                                          : const Color(0xff202020)
                                              .withOpacity(0.6),
                                      fontFamily: "Nunito",
                                      fontSize: 14.sp - widget.fontSize.sp),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: Text(
                                  (data.turn).toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: data.turn == widget.turn
                                          ? const Color(0xff00C8D5)
                                          : const Color(0xff202020)
                                              .withOpacity(0.6),
                                      fontFamily: "Nunito",
                                      fontSize: 29.sp - widget.fontSize.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          color: Color(0xff00C8D5),
                          thickness: 2,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.h, horizontal: 2.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 170.w,
                                height: 22.h,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: isArabic
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  child: Text(
                                    "${data.firstName} ${data.lastName}",
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Container(
                                width: 140.w,
                                height: 15.h,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: isArabic
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  child: Text(
                                    "${data.age} years old ",
                                    style: TextStyle(
                                        color: Color(0xff2020202)
                                            .withOpacity(0.85),
                                        fontFamily: "Nunito",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100.w,
                                height: 14.h,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: isArabic
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  child: Text(
                                    "${data.gender}",
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: 120.w,
                                height: 17.h,
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: isArabic
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.phone, size: 16),
                                        Padding(
                                          padding: EdgeInsets.only(left: 4.w),
                                          child: Text(
                                            data.phoneNumber,
                                            style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff202020)
                                                    .withOpacity(0.85)),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: isArabic
                              ? EdgeInsets.only(top: 55.h, right: 5.w)
                              : EdgeInsets.only(top: 55.h, left: 15.w),
                          child: InkWell(
                            onTap: () async {
                              final Uri uri =
                                  Uri(scheme: "tel", path: data.phoneNumber);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri); //////////calling
                              }
                            },
                            child: Container(
                              height: 18.w,
                              width: 36.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.4,
                                      color: const Color(0xff0AA9A9)),
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Center(
                                  child: Text(
                                locale.call,
                                style: TextStyle(
                                    color: const Color(0xff0AA9A9),
                                    fontSize: 10.sp,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w700),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      } else if (state is PatientsInfoLoadingError) {
        return const Center();
      } else if (state is PatientsInfoinitial) {
        patientsInfoBloc.add(onGetPatinets(uid: widget.uid, true, context));

        return const Loading();
      } else {
        return const Loading();
      }
    });
  }
}
