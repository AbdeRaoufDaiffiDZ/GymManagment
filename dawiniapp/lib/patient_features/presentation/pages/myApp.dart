import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/patient_features/domain/usecases/patients_usecase.dart';
import 'package:dawini_full/patient_features/presentation/pages/weather_pag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Mypage extends StatefulWidget {
  Mypage({Key? key}) : super(key: key);

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isConnected = false;

  bool status = false;
  @override
  void initState() {
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey, body: isConnected ? Weather() : Loading());
  }
}
