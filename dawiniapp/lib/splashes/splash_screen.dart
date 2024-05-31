// ignore_for_file: avoid_unnecessary_containers

import 'package:dawini_full/main.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splash extends StatefulWidget {
  const Splash({super.key, required this.fontSize});
  final int fontSize;

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // _navigteToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 60.h,
      curve: Curves.easeInCirc,
      duration: 2000,
      splash: Center(
          child: Container(
        child: Image.asset(
          'assets/images/dawini.png',
        ),
        // child: const Text(
        //   "DAWINI APP",
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //       fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
        // ),
      )),
      nextScreen:  MyWidget(fontSize: widget.fontSize, locale: null,),
    );
  }
}
