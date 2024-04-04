// ignore_for_file: camel_case_types, sized_box_for_whitespace

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/patients_info_bloc/patients_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class today extends StatefulWidget {
  const today({super.key, required this.uid, required this.turn});
  final String uid;
  final int turn;

  @override
  State<today> createState() => _todayState();
}

class _todayState extends State<today> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    bool isEmpty = true;
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";

    AppLocalizations text = AppLocalizations.of(context)!;

    final PatientsInfoBloc patientsInfoBloc =
        BlocProvider.of<PatientsInfoBloc>(context);
    return BlocBuilder<PatientsInfoBloc, PatientsInfoState>(
      builder: (context, state) {
        if (state is PatientsInfoLoaded) {
          return Scaffold(
            backgroundColor: const Color(0xffFCFCFC),
            body: CustomMaterialIndicator(
              onRefresh: () async {
                patientsInfoBloc
                    .add(onGetPatinets(true, context, uid: widget.uid));
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
                      strokeWidth: 2,
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
                  if (data.firstName == 'No Patients ') {
                    isEmpty = false;
                  } else {
                    isEmpty = true;
                  }
                  return isEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 8.w),
                          child: Container(
                            height: 90.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 1.5.w,
                                  color: Colors.grey.withOpacity(0.23)),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: data.turn == widget.turn ? 66.w : 58.w,
                                  decoration: BoxDecoration(
                                    color: data.turn == widget.turn
                                        ? const Color(0xff00C8D5)
                                        : Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.r),
                                      bottomLeft: Radius.circular(12.r),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 4.w),
                                        child: Text(
                                          text.turn,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: data.turn == widget.turn
                                                ? Colors.white
                                                : const Color(0xff202020)
                                                    .withOpacity(0.6),
                                            fontFamily: "Nunito",
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5.h),
                                        child: Text(
                                          (data.turn).toString(), // TODO:
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: data.turn == widget.turn
                                                ? Colors.white
                                                : const Color(0xff202020)
                                                    .withOpacity(0.6),
                                            fontFamily: "Nunito",
                                            fontSize: 29.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: data.turn != widget.turn,
                                  child: const VerticalDivider(
                                    color: Color(0xff00C8D5),
                                    thickness: 2,
                                    indent: 8,
                                    endIndent: 8,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4.h,
                                        horizontal: data.turn == widget.turn
                                            ? 10.w
                                            : 5.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 170.w,
                                          height: 22.h,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${data.firstName} ${data.lastName}",
                                              style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 140.w,
                                          height: 15.h,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              text.age +
                                                  ": ${data.age} ", // TODO: age does not exist in patient entity, create it
                                              style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100.w,
                                          height: 14.h,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              text.gender + ": ${data.gender}",
                                              style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 19.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: 100.w,
                                          height: 17.h,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: [
                                                Icon(Icons.phone, size: 15.w),
                                                Text(
                                                  data.phoneNumber,
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        const Color(0xff202020)
                                                            .withOpacity(0.85),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: isArabic
                                      ? EdgeInsets.only(top: 58.h, right: 5.w)
                                      : EdgeInsets.only(top: 58.h, left: 5.w),
                                  child: InkWell(
                                    onTap: () async {
                                      final Uri uri = Uri(
                                          scheme: "tel",
                                          path: data.phoneNumber);
                                      if (await canLaunchUrl(uri)) {
                                        await launchUrl(uri); //////////calling
                                      }
                                    },
                                    child: Container(
                                      height: 20.w,
                                      width: 42.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xff0AA9A9),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: Center(
                                        child: Text(
                                          text.call,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Color(0xff0AA9A9),
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.w),
                            child: Text(
                              text.nopatinet, // TODO:   langugae here
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff202020).withOpacity(0.6),
                                fontFamily: "Nunito",
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
          );
        } else if (state is PatientsInfoLoadingError) {
          return const Center();
        }
        patientsInfoBloc.add(onGetPatinets(uid: widget.uid, true, context));

        return const Loading();
      },
    );
  }
}
