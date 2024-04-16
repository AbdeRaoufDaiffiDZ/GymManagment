// ignore_for_file: file_names, non_constant_identifier_names

import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserTypeSelector extends StatefulWidget {
  final String type;

  const UserTypeSelector({super.key, required this.type});

  @override
  State<UserTypeSelector> createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector> {
  bool isSelected = false;
  bool isPatient = false;
  bool isDoctor = false;
  @override
  Widget build(BuildContext context) {
    final IntroductionBloc bloc = BlocProvider.of<IntroductionBloc>(context);
    final AppLocalizations text = AppLocalizations.of(context)!;

    return Scaffold(
        backgroundColor: const Color(0xffEDF5F5),
        body: SafeArea(
            child: Column(children: [
          Stack(children: [
            Container(
              color: const Color(0xffEDF5F5),
              height: 310.h,
              width: double.infinity,
              child: Image.asset(
                "assets/images/ss.png",
                fit: BoxFit.scaleDown,
              ),
            ),
          ]),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0XFF000000).withOpacity(0.1),
                      blurRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      topRight: Radius.circular(25.r))),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Dawina , ",
                        style: TextStyle(
                          color: Color(0xff202020),
                          fontSize: 15.sp,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                        )),
                    Text("For effortless appointment booking .",
                        style: TextStyle(
                          color: Color(0xff202020),
                          fontSize: 15.sp,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                        )),
                    Text("Bridging Doctors and Patients",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            color: Colors.black45)),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Center(
                          child: usertypeContainer(
                              WhoIs: isPatient,
                              text.whoareyou,
                              "patient",
                              bloc)),
                    ),
                    Center(
                        child: usertypeContainer(
                            WhoIs: isDoctor, text.iamdoctor, "doctor", bloc)),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Center(
                        child: Container(
                          width: 45.w,
                          height: 45.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffECF2F2),
                          ),
                          child: IconButton(
                              onPressed: () {
                                if(isSelected){
                                 bloc.add(const NextPage(id: 3));

                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward,
                                size: 29.w,
                                color: isSelected ? Color(0xff0AA9A9):Color.fromARGB(94, 10, 169, 169), 
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ])));
  }

  Widget usertypeContainer(String MyType, String type, IntroductionBloc bloc,
      {required bool WhoIs}) {
    final AppLocalizations text = AppLocalizations.of(context)!;

    return InkWell(
      onTap: () {
      setState(() {
        if (MyType == text.whoareyou) {
            isPatient = true;
            isDoctor = false;
            bloc.add(const onTypeChoose(type: "patient"));
            print("object1");
          } else if (MyType == text.iamdoctor) {
            isPatient = false;
            isDoctor = true;
            bloc.add(const onTypeChoose(type: "doctor"));
            print("object2");
          }
          isSelected = true;
      });
      },
      child: Container(
        margin: EdgeInsets.all(8.w),
        width: 220.w,
        height: 45.h,
        decoration: BoxDecoration(
          color: Color(0xffFAFAFA),
          boxShadow: [
            BoxShadow(
              color:  Color(0XFF000000).withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            ),
          ],
          border: Border.all(width: 1.w, color:WhoIs ? Colors.green : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            MyType,
            style: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
                color: Color(0xff202020).withOpacity(0.8)),
          ),
        ),
      ),
    );
  }
}
