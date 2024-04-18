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
      //    backgroundColor: const Color(0xffEDF5F5),
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
              color: const Color(0xffEDF5F5),
              height: 350.h,
              width: double.maxFinite,
              child: Image.asset(
                "assets/images/ss.png",
                fit: BoxFit.scaleDown,
              )),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0XFF000000).withOpacity(0.1),
                      blurRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 25.h,
                      width: 200.w,
                      child: const FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text("Dawina , ",
                            style: TextStyle(
                              color: Color(0xff202020),
                              fontSize: 19,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                    Container(
                      height: 25.h,
                      width: 300.w,
                      child: const FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text("For effortless appointment booking .",
                            style: TextStyle(
                              color: Color(0xff202020),
                              fontSize: 19,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                    Container(
                      height: 25.h,
                      width: 300.w,
                      child: const FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text("Bridging Doctors and Patients ",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                color: Colors.black45)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Container(
                        height: 130.h,
                        margin: const EdgeInsets.only(top: 8),
                        child: Column(
                          children: [
                            Center(
                                child: usertypeContainer(
                                    WhoIs: isPatient,
                                    text.whoareyou,
                                    "patient",
                                    bloc)),
                            Center(
                                child: usertypeContainer(
                                    WhoIs: isDoctor,
                                    text.iamdoctor,
                                    "doctor",
                                    bloc)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
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
                                if (isSelected) {
                                  bloc.add(const NextPage(id: 3));
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward,
                                size: 29.w,
                                color: isSelected
                                    ? const Color(0xff0AA9A9)
                                    : const Color.fromARGB(94, 10, 169, 169),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ]),
      ),
    );
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
          color: const Color(0xffFAFAFA),
          boxShadow: [
            BoxShadow(
              color: const Color(0XFF000000).withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            ),
          ],
          border: Border.all(
              width: 1.w, color: WhoIs ? Colors.green : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            MyType,
            style: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
                color: const Color(0xff202020).withOpacity(0.8)),
          ),
        ),
      ),
    );
  }
}
