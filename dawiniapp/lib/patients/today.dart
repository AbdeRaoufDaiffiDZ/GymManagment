import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/patients_info_bloc/patients_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final PatientsInfoBloc patientsInfoBloc =
        BlocProvider.of<PatientsInfoBloc>(context);
    return BlocBuilder<PatientsInfoBloc, PatientsInfoState>(
      builder: (context, state) {
        if (state is PatientsInfoLoaded) {
          return Scaffold(
            backgroundColor: const Color(0xffFCFCFC),
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: state.patients.length,
              itemBuilder: (context, index) {
                final data = state.patients[index];

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                  child: Container(
                    height: 90.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 1.5, color: Colors.grey.withOpacity(0.23)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: data.turn == widget.turn ? 66.w : 58.w,
                          decoration: BoxDecoration(
                            color: data.turn == widget.turn
                                ? const Color(0xff00C8D5)
                                : Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 4.w),
                                child: Text(
                                  "Turn",
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
                                horizontal:
                                    data.turn == widget.turn ? 10.w : 5.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 170.w,
                                  height: 22.h,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${data.firstName} ${data.lastName}",
                                      style: const TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 140.w,
                                  height: 15.h,
                                  child: const FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Age: widget.patinet ", // TODO: age does not exist in patient entity, create it
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100.w,
                                  height: 14.h,
                                  child: const FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "  widget.patinet .toString(), ", // TODO: gender does not exist in patinte entity, create it
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 19,
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
                                        const Icon(Icons.phone, size: 15),
                                        Text(
                                          data.phoneNumber,
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff202020)
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
                          padding: EdgeInsets.only(top: 58.h, right: 6.w),
                          child: InkWell(
                            onTap: () async {
                              final Uri uri =
                                  Uri(scheme: "tel", path: data.phoneNumber);
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
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  "call",
                                  style: TextStyle(
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
                );
              },
            ),
          );
        } else if (state is PatientsInfoLoadingError) {
          return const Center();
        } else if (state is PatientsInfoinitial) {
          patientsInfoBloc.add(onGetPatinets(uid: widget.uid, true));

          return const Loading();
        } else {
          return const Loading();
        }
      },
    );
  }
}
