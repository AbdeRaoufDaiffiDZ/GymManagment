// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class myfavclincs extends StatefulWidget {
  const myfavclincs({
    super.key,
  });

  @override
  State<myfavclincs> createState() => _favoriteState();
}

class _favoriteState extends State<myfavclincs> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;

    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SizedBox(
          width: 200.w, // 90.h
          height: 100.h, // 20.h
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(text.commingsoon,
                // widget.clinics[index].ClinicName,
                style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 50, // 25
                    fontWeight: FontWeight.w600)),
          ),
        ),
      ),
      //    ListView(
      //     children: [
      //       Container(
      //         height: 140.h,
      //         margin: const EdgeInsets.all(6),
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(16),
      //           border: Border.all(
      //             color: Color.fromARGB(72, 146, 146, 146),
      //             width: 2.w,
      //           ),
      //         ),
      //         child: Column(
      //           children: [
      //             Row(
      //               children: [
      //                 Padding(
      //                   padding: EdgeInsets.only(left: 1.w),
      //                   child: Container(
      //                     margin: const EdgeInsets.all(8),
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(16),
      //                       color: Color.fromARGB(31, 204, 204, 204)
      //                           .withOpacity(0.3),
      //                       border: Border.all(
      //                         color: const Color.fromARGB(0, 158, 158, 158),
      //                         width: 2.w,
      //                       ),
      //                     ),
      //                     height: 120.h,
      //                     width: 150.w,
      //                     child: Image.asset(
      //                       "assets/images/clinic.png",
      //                       fit: BoxFit.scaleDown,
      //                       scale: 1.w,
      //                     ),
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: EdgeInsets.only(top: 15.h),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       SizedBox(
      //                         width: 130.w,
      //                         height: 23.h,
      //                         child: FittedBox(
      //                           alignment: Alignment.topLeft,
      //                           fit: BoxFit.scaleDown,
      //                           child: Text("Asname",
      //                               style: TextStyle(
      //                                   fontFamily: 'Nunito',
      //                                   fontSize: 33,
      //                                   fontWeight: FontWeight.w800)),
      //                         ),
      //                       ),
      //                       SizedBox(height: 40.h),
      //                       SizedBox(
      //                         width: 120.w,
      //                         height: 15.h,
      //                         child: FittedBox(
      //                           alignment: Alignment.topLeft,
      //                           fit: BoxFit.scaleDown,
      //                           child: Row(
      //                             mainAxisAlignment:
      //                                 MainAxisAlignment.spaceBetween,
      //                             children: [
      //                               Icon(
      //                                 Icons.phone,
      //                                 size: 17.sp,
      //                                 color:
      //                                     Color(0XFF202020).withOpacity(0.75),
      //                               ),
      //                               SizedBox(width: 2.w),
      //                               Text("0557902660",
      //                                   style: TextStyle(
      //                                       fontFamily: 'Nunito',
      //                                       color: Color(0XFF202020)
      //                                           .withOpacity(0.75),
      //                                       fontSize: 22,
      //                                       fontWeight: FontWeight.w600)),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         width: 120.w,
      //                         height: 18.h,
      //                         child: FittedBox(
      //                           alignment: Alignment.topLeft,
      //                           fit: BoxFit.scaleDown,
      //                           child: Row(
      //                             children: [
      //                               Icon(
      //                                 Icons.location_on,
      //                                 size: 16.sp,
      //                                 color:
      //                                     Color(0XFF202020).withOpacity(0.75),
      //                               ),
      //                               SizedBox(width: 3.w),
      //                               Text("chlef",
      //                                   style: TextStyle(
      //                                       color: Color(0XFF202020)
      //                                           .withOpacity(0.75),
      //                                       fontFamily: 'Nunito',
      //                                       fontSize: 16,
      //                                       fontWeight: FontWeight.w600)),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         width: 120.w,
      //                         height: 15.h,
      //                         child: FittedBox(
      //                           fit: BoxFit.scaleDown,
      //                           alignment: Alignment.topLeft,
      //                           child: Row(
      //                             children: [
      //                               Icon(
      //                                 Icons.circle,
      //                                 color: Color.fromARGB(255, 219, 44, 44),
      //                                 size: 15.sp,
      //                               ),
      //                               SizedBox(width: 3.w),
      //                               Text(
      //                                 "Not at Service",
      //                                 style: TextStyle(
      //                                     fontFamily: "Nunito",
      //                                     color: Color(0XFF202020),
      //                                     fontSize: 17,
      //                                     fontWeight: FontWeight.w700),
      //                               )
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         height: 140.h,
      //         margin: const EdgeInsets.all(6),
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(16),
      //           border: Border.all(
      //             color: Color.fromARGB(72, 146, 146, 146),
      //             width: 2.w,
      //           ),
      //         ),
      //         child: Column(
      //           children: [
      //             Row(
      //               children: [
      //                 Padding(
      //                   padding: EdgeInsets.only(left: 1.w),
      //                   child: Container(
      //                     margin: const EdgeInsets.all(8),
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(16),
      //                       color: Color.fromARGB(31, 204, 204, 204)
      //                           .withOpacity(0.3),
      //                       border: Border.all(
      //                         color: const Color.fromARGB(0, 158, 158, 158),
      //                         width: 2.w,
      //                       ),
      //                     ),
      //                     height: 120.h,
      //                     width: 150.w,
      //                     child: Image.asset(
      //                       "assets/images/clinic.png",
      //                       fit: BoxFit.scaleDown,
      //                       scale: 1.w,
      //                     ),
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: EdgeInsets.only(top: 15.h),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       SizedBox(
      //                         width: 130.w,
      //                         height: 23.h,
      //                         child: FittedBox(
      //                           alignment: Alignment.topLeft,
      //                           fit: BoxFit.scaleDown,
      //                           child: Text("Asname",
      //                               style: TextStyle(
      //                                   fontFamily: 'Nunito',
      //                                   fontSize: 33,
      //                                   fontWeight: FontWeight.w800)),
      //                         ),
      //                       ),
      //                       SizedBox(height: 40.h),
      //                       SizedBox(
      //                         width: 120.w,
      //                         height: 15.h,
      //                         child: FittedBox(
      //                           alignment: Alignment.topLeft,
      //                           fit: BoxFit.scaleDown,
      //                           child: Row(
      //                             mainAxisAlignment:
      //                                 MainAxisAlignment.spaceBetween,
      //                             children: [
      //                               Icon(
      //                                 Icons.phone,
      //                                 size: 17.sp,
      //                                 color:
      //                                     Color(0XFF202020).withOpacity(0.75),
      //                               ),
      //                               SizedBox(width: 2.w),
      //                               Text("0557902660",
      //                                   style: TextStyle(
      //                                       fontFamily: 'Nunito',
      //                                       color: Color(0XFF202020)
      //                                           .withOpacity(0.75),
      //                                       fontSize: 22,
      //                                       fontWeight: FontWeight.w600)),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         width: 120.w,
      //                         height: 18.h,
      //                         child: FittedBox(
      //                           alignment: Alignment.topLeft,
      //                           fit: BoxFit.scaleDown,
      //                           child: Row(
      //                             children: [
      //                               Icon(
      //                                 Icons.location_on,
      //                                 size: 16.sp,
      //                                 color:
      //                                     Color(0XFF202020).withOpacity(0.75),
      //                               ),
      //                               SizedBox(width: 3.w),
      //                               Text("chlef",
      //                                   style: TextStyle(
      //                                       color: Color(0XFF202020)
      //                                           .withOpacity(0.75),
      //                                       fontFamily: 'Nunito',
      //                                       fontSize: 16,
      //                                       fontWeight: FontWeight.w600)),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         width: 120.w,
      //                         height: 15.h,
      //                         child: FittedBox(
      //                           fit: BoxFit.scaleDown,
      //                           alignment: Alignment.topLeft,
      //                           child: Row(
      //                             children: [
      //                               Icon(
      //                                 Icons.circle,
      //                                 color: Color.fromARGB(255, 219, 44, 44),
      //                                 size: 15.sp,
      //                               ),
      //                               SizedBox(width: 3.w),
      //                               Text(
      //                                 "Not at Service",
      //                                 style: TextStyle(
      //                                     fontFamily: "Nunito",
      //                                     color: Color(0XFF202020),
      //                                     fontSize: 17,
      //                                     fontWeight: FontWeight.w700),
      //                               )
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
    ));
  }
}
