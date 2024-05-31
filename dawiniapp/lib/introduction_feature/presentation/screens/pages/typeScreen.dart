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
  double screenHeight = MediaQuery.of(context).size.height;
     double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffEDF5F5),
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
              color: const Color(0xffEDF5F5),
              height:  0.5*screenHeight,
              width: double.maxFinite,
              child: Image.asset(
                "assets/images/ss.png",
                fit: BoxFit.scaleDown,
              )),
          Container(
            height: 0.5*screenHeight,
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
                padding: EdgeInsets.symmetric(vertical: 0.5*screenHeight*0.01, horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height:0.5*screenHeight*0.1,
                      width: 200.w,
                      child:  FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text("Dawina , ",
                            style: TextStyle(
                              color: Color(0xff202020),
                              fontSize: 19.sp,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                    Container(
                      height: 0.5*screenHeight*0.1,
                      width: 300.w,
                      child:  FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text("For effortless appointment booking .",
                            style: TextStyle(
                              color: Color(0xff202020),
                              fontSize: 19.sp,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                    Container(
                      height: 0.5*screenHeight*0.1,
                      width: 300.w,
                      child:  FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text("Bridging Doctors and Patients ",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                color: Colors.black45)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.5*screenHeight*0.01),
                      child: Container(
                        height: 0.5*screenHeight*0.4,
                        margin:  EdgeInsets.only(top: 0.5*screenHeight*0.01),
                        child: Column(
                          children: [
                            Center(
                                child: usertypeContainer(
                                    WhoIs: isPatient,
                                    text.whoareyou,
                                    "patient",
                                    bloc, screenHeight)),
                            Center(
                                child: usertypeContainer(
                                    WhoIs: isDoctor,
                                    text.iamdoctor,
                                    "doctor",
                                    bloc, screenHeight)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(0.5*screenHeight*0.01),
                      child: Center(
                        child: Container(
                          width: 0.5*screenHeight*0.15,
                          height: 0.5*screenHeight*0.15,
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
                                size: 0.5*screenHeight*0.08,
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

  Widget usertypeContainer(String MyType, String type, IntroductionBloc bloc,double screenHeight,
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
        margin: EdgeInsets.all(0.5*screenHeight*0.4*0.05),
        width: 220.w,
        height: 0.5*screenHeight*0.4*0.35,
        decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          boxShadow: [
            WhoIs
                ? BoxShadow(
                    color: Color(0xff04CBCB),
                    blurRadius: 2,
                    spreadRadius: 1,
                    offset: const Offset(0, 0),
                  )
                : BoxShadow(
                    color: Color(0xff202020).withOpacity(0.3),
                    blurRadius: 2,
                    spreadRadius: 0,
                    offset: const Offset(0, 0),
                  ),
          ],
          /*   border: Border.all(
              width: 1.w,
              color: WhoIs ? Color(0xff04CBCB) : Colors.transparent),*/
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            MyType,
            style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
                color: const Color(0xff202020).withOpacity(0.8)),
          ),
        ),
      ),
    );
  }
}
