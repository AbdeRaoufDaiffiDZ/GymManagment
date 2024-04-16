// ignore_for_file: file_names

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dawini_full/auth/domain/usecases/auth_usecase.dart';
import 'package:dawini_full/auth/presentation/welcomePage.dart';
import 'package:dawini_full/patient_features/domain/usecases/patients_usecase.dart';
import 'package:dawini_full/patient_features/presentation/pages/weather_pag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mypage extends StatefulWidget {
    final int fontSize;

  // ignore: prefer_typing_uninitialized_variables
  final bool popOrNot;

  const Mypage({super.key, required this.popOrNot, required this.fontSize});

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var isConnected = false;
  bool isAlerSet = false;
  late StreamSubscription subscription;
  bool status = false;
  String? type;
  @override
  void initState() {
    getConnectivity();
    loadType();
    super.initState();
  }

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isConnected = await InternetConnectionChecker().hasConnection;
        if (!isConnected && isAlerSet == false) {
          showDialogBox();
          setState(() {
            isAlerSet = true;
          });
        }
      });
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text("No Connection"),
            content: const Text('Please Check your internet connectivity'),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, 'Cancel');
                    setState(() {
                      isAlerSet = false;
                    });
                    isConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (!isConnected) {
                      showDialogBox();
                      setState(() {
                        isAlerSet = true;
                      });
                    }
                  },
                  child: const Text('Ok'))
            ],
          ));

  final GetAppointmentLocalusecase getAppointmentLocalusecase =
      GetAppointmentLocalusecase();
  DoctorAuthStateUseCase doctorAuthStateUseCase = DoctorAuthStateUseCase();

  @override
  Widget build(BuildContext context) {
    if (type != "doctor" || type == null) {
      return Scaffold(
          key: _scaffoldKey,
          body:  Weather(fontSize: widget.fontSize
          ));
    } else {
      return  doctorsideHome(fontSize: widget.fontSize,);
    }
  }

  Future loadType() async {
    final snapshot = await SharedPreferences.getInstance();
    setState(() {
      type = snapshot.getString('type');
    });
  }
}
