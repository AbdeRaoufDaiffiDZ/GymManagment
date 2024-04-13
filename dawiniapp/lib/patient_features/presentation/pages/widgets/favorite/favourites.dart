// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables

import 'package:dawini_full/patient_features/presentation/pages/widgets/favorite/clinics.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/favorite/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class favorite extends StatefulWidget {
  final int fontSize;

  favorite({super.key, required this.fontSize});

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(length: 2, vsync: this);
    final AppLocalizations text = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color(0XFFFAFAFA),
          title: Center(
            child: Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 200.w,
              height: 30.h,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text.my_favorite,
                  style: TextStyle(
                      color: const Color(0XFF202020),
                      fontSize: 33.sp - widget.fontSize.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito'),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
            child: Container(
                color: const Color(0XFFFAFAFA),
                child: Column(children: [
                  TabBar(
                      controller: tabcontroller,
                      labelColor: Colors.black,
                      dividerColor: Colors.transparent,
                      unselectedLabelColor: Colors.grey,
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              width: 2.w, color: const Color(0XFF04CBCB)),
                          insets: EdgeInsets.symmetric(horizontal: 14.w)),
                      tabs: [
                        Tab(
                          child: SizedBox(
                            width: 130.w,
                            height: 30.h,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                text.doctors,
                                style: TextStyle(
                                    fontSize: 22.dg - widget.fontSize.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Nunito"),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: SizedBox(
                            width: 130.w,
                            height: 30.h,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                text.clinics,
                                style: TextStyle(
                                    fontSize: 22.sp - widget.fontSize.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Nunito"),
                              ),
                            ),
                          ),
                        ),
                      ]),
                  Expanded(
                      child: TabBarView(controller: tabcontroller, children: [
                    myfavdoctors(
                      fontSize: widget.fontSize,
                    ),
                    myfavclincs(
                      fontSize: widget.fontSize,
                    )
                  ])),
                ]))),
      ),
    );
  }
}
