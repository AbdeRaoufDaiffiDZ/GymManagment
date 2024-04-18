import 'package:dawini_full/introduction_feature/presentation/screens/pages/typeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class doctorsss extends StatefulWidget {
  const doctorsss({
    super.key,
  });

  @override
  State<doctorsss> createState() => _doctorsssState();
}

class _doctorsssState extends State<doctorsss> {
  TextEditingController doctorEmail = TextEditingController();
  TextEditingController doctorPassword = TextEditingController();
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    doctorEmail.dispose();
    doctorPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: Stack(
                        children: [
                          Container(
                            height: 230.h,
                            width: double.infinity,
                            child: Image.asset("assets/images/login.png"),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 0.h, horizontal: 8.w),
                            height: 34.w,
                            width: 34.w,
                            decoration: BoxDecoration(
                                color: Color(0xffECF2F2),
                                shape: BoxShape.circle),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserTypeSelector(
                                              type: "doctor",
                                            )),
                                  );
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 23,
                                  color: Color(0xff0AA9A9),
                                )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 340,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        "Hello, Doctor! Elevate your appointment with Dawini's smart management.",
                        style: TextStyle(
                          color: Color(0xff202020).withOpacity(0.95),
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                    Container(
                      height: 45.h,
                      margin: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 10.w),
                      child: TextFormField(
                        controller: doctorEmail,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0XFFECF2F2),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          hintText: "Enter your email",
                          hintStyle: TextStyle(
                            color: const Color(0XFF202020).withOpacity(0.7),
                            fontFamily: "Nunito",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 45.h,
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: TextFormField(
                        obscureText: _obscureText,
                        controller: doctorPassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: _togglePasswordVisibility,
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          filled: true,
                          fillColor: const Color(0XFFECF2F2),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: const Color(0XFF202020).withOpacity(0.7),
                            fontFamily: "Nunito",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 12.w),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 45.h,
                          child: Center(
                            child: Text(
                              "Enter",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Nunito',
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff00C8D5),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
