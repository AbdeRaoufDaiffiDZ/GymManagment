import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class secondConatiner extends StatefulWidget {
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
              width: 66.w,
              decoration: BoxDecoration(
                color: Color(0xff00C8D5),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
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
                    child: FittedBox(
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
                    child: FittedBox(
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
                    child: FittedBox(
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
                  Spacer(),
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
                                Icon(Icons.phone, size: 15),
                                Text(
                                  "0557902660",
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Color(0xff202020).withOpacity(0.85)),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(width: 23.w),
                      Container(
                        width: 100.w,
                        height: 15.h,
                        child: FittedBox(
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
