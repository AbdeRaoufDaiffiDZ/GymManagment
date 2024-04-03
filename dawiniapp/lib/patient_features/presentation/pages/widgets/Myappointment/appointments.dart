// ignore_for_file: sized_box_for_whitespace

import 'package:dawini_full/patient_features/presentation/pages/widgets/Myappointment/current%20.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Myappointment/previous.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Myappointemtns extends StatefulWidget {
  const Myappointemtns({Key? key, String? uid}) : super(key: key);

  @override
  State<Myappointemtns> createState() => _MyappointemtnsState();
}

class _MyappointemtnsState extends State<Myappointemtns>
    with TickerProviderStateMixin {
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
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "My appointments",
                  style: TextStyle(
                      color: Color(0XFF202020),
                      fontSize: 30,
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
                      dividerColor: Colors.transparent,
                      controller: tabcontroller,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              width: 2.w, color: const Color(0XFF04CBCB)),
                          insets: EdgeInsets.symmetric(horizontal: 15.w)),
                      tabs: [
                        Tab(
                          child: SizedBox(
                            width: 130.w,
                            height: 30.h,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                text.current,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Nunito"),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            width: 130.w,
                            height: 30.h,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                text.previous,
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Nunito"),
                              ),
                            ),
                          ),
                        ),
                      ]),
                  Expanded(
                      child: TabBarView(
                          controller: tabcontroller,
                          children: const [newcurrent(), previousappointm()])),
                ]))),
      ),
    );
  }
}
