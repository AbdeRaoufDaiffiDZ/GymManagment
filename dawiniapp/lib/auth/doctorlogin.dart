// ignore_for_file: camel_case_types

import 'package:dawini_full/auth/domain/entity/auth_entity.dart';
import 'package:dawini_full/auth/presentation/bloc/auth_bloc.dart';
import 'package:dawini_full/auth/presentation/bloc/auth_event.dart';
import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:dawini_full/introduction_feature/presentation/screens/pages/typeScreen.dart';
import 'package:dawini_full/introduction_feature/presentation/screens/pages_shower.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class doctorsss extends StatefulWidget {
  final int fontSize;
  final String? error;
  const doctorsss({
    super.key,
    required this.fontSize,
    required this.error,
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
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    final AppLocalizations text = AppLocalizations.of(context)!;
    final IntroductionBloc bloc = BlocProvider.of<IntroductionBloc>(context);

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
                            decoration: const BoxDecoration(
                                color: Color(0xffECF2F2),
                                shape: BoxShape.circle),
                            child: IconButton(
                                onPressed: () {
                                              bloc.add(NextPage(id: 2));

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             PagesShower(fontSize: widget.fontSize,pageNumber: 2,
                                            )),
                                  );
                                },
                                icon: const Icon(
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
                      child: Text( text.hello_doctor_elevate,
                        
                        style: TextStyle(
                          color: const Color(0xff202020).withOpacity(0.95),
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          fontSize: 17.sp - widget.fontSize.sp,
                        ),
                      ),
                    ),
                    Container(
                      height: 45.h,
                      margin: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 10.w),
                      child: TextFormField(
                        onEditingComplete: () {
                          // Move focus to the next field when "Next" is pressed
                          FocusScope.of(context).nextFocus();
                        },
                        validator: validateEmail,
                        controller: doctorEmail,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0XFFECF2F2),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          hintText: text.enter_email,
                          hintStyle: TextStyle(
                            color: const Color(0XFF202020).withOpacity(0.7),
                            fontFamily: "Nunito",
                            fontSize: 14.sp - widget.fontSize.sp,
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
                          hintText: text.password,
                          hintStyle: TextStyle(
                            color: const Color(0XFF202020).withOpacity(0.7),
                            fontFamily: "Nunito",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    if (widget.error != null)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 15.w),
                        child: Text(
                          widget.error!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 12.w),
                      child: GestureDetector(
                        onTap: () {
                          if (doctorEmail.text.isNotEmpty &&
                              doctorPassword.text.isNotEmpty) {
                            AuthEntity auth = AuthEntity(
                                email: doctorEmail.text,
                                password: doctorPassword.text);

                            authBloc.add(
                                onLoginEvent(context: context, data: auth));
                          }
                        },
                        child: Container(
                          height: 45.h,
                          decoration: BoxDecoration(
                            color: const Color(0xff00C8D5),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Text(
                              text.login,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Nunito',
                                fontSize: 25.sp - widget.fontSize.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address.';
    }
    // You can optionally add a more robust email validation using a regular expression
    // but this basic check ensures a value is present
    return null;
  }
}
