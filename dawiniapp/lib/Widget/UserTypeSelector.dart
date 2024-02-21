import 'package:dawini_full/patient_features/presentation/pages/myApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class UserTypeSelector extends StatefulWidget {
  const UserTypeSelector({Key? key}) : super(key: key);

  @override
  State<UserTypeSelector> createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector> {
  String selectedLanguage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child: Image.asset("images/pp.png"),
              ),
              Container(
                  child: Image.asset(
                "images/dawini.png",
                width: 140.w,
                height: 36.h,
              )),
              Text(
                "For effortless Appointment Booking",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.sp,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600),
              ),
              Text("Bridging Doctors and Patients",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      color: Colors.black45)),
              SizedBox(height: 20.h),
              usertypeContainer("Looking for a doctor"),
              usertypeContainer("Im doctor"),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        alignment: Alignment.bottomCenter,
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 400),
                        reverseDuration: const Duration(milliseconds: 400),
                        type: PageTransitionType.rightToLeft,
                        child: const Mypage(
                          popOrNot: false,
                        ),
                      ));
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 13.w, vertical: 16.h),
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2CDBC6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30.sp,
                        color: Colors.white,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget usertypeContainer(String language) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });
        print(language);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 250.w,
        height: 60.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedLanguage == language
                ? const Color(0xFF2CDBC6)
                : Colors.grey.shade300,
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            language,
            style: TextStyle(
              fontSize: 24.sp,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ),
    );
  }
}
