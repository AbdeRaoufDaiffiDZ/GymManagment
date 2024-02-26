// ignore_for_file: camel_case_types, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class secondConatiner extends StatefulWidget {
  const secondConatiner({super.key});

  @override
  State<secondConatiner> createState() => _secondConatinerState();
}

class _secondConatinerState extends State<secondConatiner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Container(
        height: 95.h,
        decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: Colors.grey.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              width: 66.w,
              decoration: const BoxDecoration(
                color: Color(0xff00C8D5),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
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
                          color: Colors.white,
                          fontFamily: "Nunito",
                          fontSize: 14.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Text(
                      "22",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: "Nunito",
                          fontSize: 29.sp),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 190.w,
                    height: 22.h,
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Thabet mohamed ",
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
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "20 years old ",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
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
                        "Male ",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 19,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
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
                                  "0557902660",
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff202020)
                                          .withOpacity(0.85)),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(width: 23.w),
                      Container(
                        width: 100.w,
                        height: 15.h,
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.topRight,
                          child: Text("afternoon ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff0AA9A9),
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
