import 'dart:async';

import 'package:dawini_full/patient_features/domain/entities/clinic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ClinicWidget extends StatefulWidget {
  List<ClinicEntity> clinics;

  ClinicWidget({
    Key? key,
    required this.clinics,
  }) : super(key: key);

  @override
  State<ClinicWidget> createState() => _ClinicWidgetState();
}

class _ClinicWidgetState extends State<ClinicWidget> {
  PageController mycon = PageController(viewportFraction: 0.8);

  late Timer timer;

  int selectedindex = 0;
  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    timer = Timer.periodic(const Duration(seconds: 4), (timez) {
      if (mycon.hasClients) {
        mycon.animateToPage(
          (mycon.page!.toInt() + 1) % widget.clinics.length,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0XFFFAFAFA),
      height: 150.h,
      width: double.infinity,
      child: PageView.builder(
        onPageChanged: (int index) {
          setState(() {
            selectedindex = index;
          });
        },
        controller: mycon,
        itemCount: 4, //widget.clinics.length,
        itemBuilder: (context, index) {
          double scale = selectedindex == index ? 1 : 0.9;

          return GestureDetector(
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             ClinicsDetails(uid: widget.clinics[index].uid)),
            //   );
            // },
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: scale, end: scale),
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeIn,
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    //height: 30.h,
                    //width: double.infinity,
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromARGB(72, 146, 146, 146),
                        width: 2.w,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 150.w, // 90.h
                        height: 100.h, // 20.h
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: const Text("Coomming Soon...",
                              // widget.clinics[index].ClinicName,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 50, // 25
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.only(left: 1.w),
                    //       child: Container(
                    //         margin: const EdgeInsets.all(8),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(16),
                    //           color: Color.fromARGB(31, 204, 204, 204)
                    //               .withOpacity(0.3),
                    //           border: Border.all(
                    //             color: const Color.fromARGB(0, 158, 158, 158),
                    //             width: 2.w,
                    //           ),
                    //         ),
                    //         height: 120.h,
                    //         width: 115.w,
                    //         child: Image.asset(
                    //           "assets/images/clinic.png",
                    //           fit: BoxFit.scaleDown,
                    //           scale: 1.w,
                    //         ),
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(top: 15.h),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Container(
                    //             width: 90.w,
                    //             height: 20.h,
                    //             child: FittedBox(
                    //               fit: BoxFit.scaleDown,
                    //               child: Text(widget.clinics[index].ClinicName,
                    //                   style: TextStyle(
                    //                       fontFamily: 'Nunito',
                    //                       fontSize: 25,
                    //                       fontWeight: FontWeight.w600)),
                    //             ),
                    //           ),
                    //           SizedBox(height: 40.h),
                    //           Container(
                    //             width: 90.w,
                    //             height: 15.h,
                    //             child: FittedBox(
                    //               alignment: Alignment.topLeft,
                    //               fit: BoxFit.scaleDown,
                    //               child: Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Icon(Icons.phone, size: 17.sp),
                    //                   SizedBox(width: 2.w),
                    //                   Text(widget.clinics[index].phoneNumber,
                    //                       style: TextStyle(
                    //                           fontFamily: 'Nunito',
                    //                           color: Color(0XFF202020),
                    //                           fontSize: 22,
                    //                           fontWeight: FontWeight.w600)),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           Container(
                    //             width: 90.w,
                    //             height: 18.h,
                    //             child: FittedBox(
                    //               alignment: Alignment.topLeft,
                    //               fit: BoxFit.scaleDown,
                    //               child: Row(
                    //                 children: [
                    //                   Icon(
                    //                     Icons.location_on,
                    //                     size: 16.sp,
                    //                   ),
                    //                   SizedBox(width: 5.w),
                    //                   Text(widget.clinics[index].city + "",
                    //                       style: TextStyle(
                    //                           fontFamily: 'Nunito',
                    //                           fontSize: 16,
                    //                           fontWeight: FontWeight.w600)),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           Container(
                    //             width: 90.w,
                    //             height: 18.h,
                    //             child: FittedBox(
                    //               fit: BoxFit.scaleDown,
                    //               alignment: Alignment.topLeft,
                    //               child: Row(
                    //                 children: [
                    //                   Icon(
                    //                     Icons.circle,
                    //                     color: widget.clinics[index].atSerivce
                    //                         ? Color(0xFF2CDBC6)
                    //                         : Color.fromARGB(255, 219, 44, 44),
                    //                     size: 15.sp,
                    //                   ),
                    //                   SizedBox(width: 2.w),
                    //                   Text(
                    //                     widget.clinics[index].atSerivce
                    //                         ? " At Service"
                    //                         : "Not at Service",
                    //                     style: TextStyle(
                    //                         fontFamily: "Nunito",
                    //                         color: Color(0XFF202020),
                    //                         fontSize: 17,
                    //                         fontWeight: FontWeight.w700),
                    //                   )
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
