//The new design for appointement
import 'package:dawini_full/patient_features/presentation/pages/widgets/Myappointment/current%20.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/Myappointment/previous.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Myappointemtns extends StatefulWidget {
  const Myappointemtns({
    super.key,
  });

  @override
  State<Myappointemtns> createState() => _MyappointemtnsState();
}

class _MyappointemtnsState extends State<Myappointemtns>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(length: 2, vsync: this);

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            body: SafeArea(
                child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 20.h),
            width: 190.w,
            child: const FittedBox(
              fit: BoxFit.fill,
              child: Text("My appointments",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF202020))),
            ),
          ),
          SizedBox(height: 10.h),
          TabBar(
            labelStyle: TextStyle(
                fontSize: 25.sp,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600),
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: Color(0XFF04CBCB)),
                insets: EdgeInsets.symmetric(horizontal: 25.0)),
            controller: tabcontroller,
            labelColor: const Color(0xFF202020),
            unselectedLabelColor: const Color(0XFF202020).withOpacity(0.4),
            tabs: const [
              Tab(
                text: 'Current',
              ),
              Tab(text: 'Previous'),
            ],
            indicatorColor: const Color(0XFF04CBCB),
          ),
          Expanded(
            // ignore: prefer_const_literals_to_create_immutables
            child: TabBarView(controller: tabcontroller, children: [
              const currentappointm(),
              // Content for the 'Previous' tab
              const previousappointm()
            ]),
          )
        ]))));
  }
}
