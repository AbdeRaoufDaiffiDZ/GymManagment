// ignore_for_file: file_names, non_constant_identifier_names

import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserTypeSelector extends StatefulWidget {
  final String type;

  const UserTypeSelector({super.key, required this.type});

  @override
  State<UserTypeSelector> createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final IntroductionBloc bloc = BlocProvider.of<IntroductionBloc>(context);
    final AppLocalizations text = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              // Container(
              //   width: 250.w,
              //   margin: const EdgeInsets.all(8),
              //   child: Image.asset("assets/images/pp.png"),
              // ),
              SizedBox(
                height: 20.h,
              ),
              Image.asset(
                "assets/images/dawini.png",
                width: 140.w,
                height: 36.h,
              ),
              Text(
                "For effortless Appointment Booking",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17.sp,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600),
              ),
              Text("Bridging Doctors and Patients",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      color: Colors.black45)),
              SizedBox(height: 10.h),
              usertypeContainer(text.whoareyou, "patient", bloc),
              usertypeContainer(text.iamdoctor, "doctor", bloc),
              InkWell(
                onTap: () {
                  if (isSelected) {
                    bloc.add(const NextPage(id: 3));
                  }
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF2CDBC6)
                        : const Color.fromARGB(108, 44, 219, 199),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      text.next,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
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

  Widget usertypeContainer(String MyType, String type, IntroductionBloc bloc) {
    final AppLocalizations text = AppLocalizations.of(context)!;

    return InkWell(
      onTap: () {
        if (MyType == text.whoareyou) {
          bloc.add(const onTypeChoose(type: "patient"));
        } else if (MyType == text.iamdoctor) {
          bloc.add(const onTypeChoose(type: "doctor"));
        }
        isSelected = true;
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 150.w,
        height: 40.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.type == type
                ? const Color(0xFF2CDBC6)
                : Colors.grey.shade300,
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            MyType,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ),
    );
  }
}
