import 'package:dawini_full/auth/domain/usecases/auth_usecase.dart';
import 'package:dawini_full/auth/presentation/welcomePage.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/patient_features/domain/usecases/patients_usecase.dart';
import 'package:dawini_full/patient_features/presentation/pages/weather_pag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mypage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final device;
  final String? uid;
  final bool popOrNot;

  const Mypage({Key? key, this.device, this.uid, required this.popOrNot})
      : super(key: key);

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isConnected = false;
  late String type;

  bool status = false;

  @override
  void initState() {
    super.initState();
    loadType();

    InternetConnectionChecker().onStatusChange.listen((status) {
      if (kDebugMode) {
        print(InternetConnectionStatus.values);
      }
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        isConnected = hasInternet;
      });
      _showSnackBar(hasInternet);
    });
  }

  void _showSnackBar(bool hasInternet) {
    AppLocalizations text = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          hasInternet ? text.internet_Restored : text.no_Interne_Connection),
      backgroundColor: hasInternet ? Colors.green : Colors.red,
    ));
  }

  final GetAppointmentLocalusecase getAppointmentLocalusecase =
      GetAppointmentLocalusecase();
  DoctorAuthStateUseCase doctorAuthStateUseCase = DoctorAuthStateUseCase();

  @override
  Widget build(BuildContext context) {
    // if (widget.uid == null) {
    //   return doctorsideHome();
    // } else {
    //   return Column(
    //     children: [
    //       Text(widget.uid!),
    //       MaterialButton(
    //           color: Colors.white,
    //           onPressed: () {
    //             doctorAuthStateUseCase.signOutDoctor();
    //           })
    //     ],
    //   );
    // }
    if (isConnected) {
      if (type == "patient") {
        return Scaffold(
            key: _scaffoldKey,
            body: Weather(
              device: widget.device,
              uid: widget.uid,
              popOrNot: widget.popOrNot,
            ));
      } else {
        return const doctorsideHome(
          popOrNot: false,
        );
      }
    } else {
      return const Loading();
    }
  }

  Future<void> loadType() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      type = (prefs.getString('type') ?? "patient");
    });
  }
}
