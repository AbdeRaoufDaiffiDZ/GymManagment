// ignore_for_file: no_logic_in_create_state, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dawini_full/auth/domain/usecases/auth_usecase.dart';
import 'package:dawini_full/auth/presentation/bloc/auth_bloc.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_data_bloc/doctor_data_bloc.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/patients_info_bloc/patients_info_bloc.dart';
import 'package:dawini_full/firebase_options.dart';
import 'package:dawini_full/injection_container.dart';
import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:dawini_full/introduction_feature/presentation/screens/pages_shower.dart';
import 'package:dawini_full/patient_features/presentation/bloc/clinics_bloc/bloc/clinics_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/doctor_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/myApp.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String device = "deviceInfo.androidInfo";
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'turn notification',
            channelDescription:
                'send notification when your turn is near or past')
      ],
      debug: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );

  setupLocator();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MyApp(
      device: device,
    ),
  );
}

class MyApp extends StatelessWidget {
  final device;
  const MyApp({
    Key? key,
    this.device,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => locator<ClinicsBloc>()..add(ClinicinitialEvent()),
          ),
          BlocProvider(create: (_) => locator<AuthBloc>()),
          BlocProvider(create: (_) => locator<DoctorPatientsBloc>()),
          BlocProvider(
            create: (_) => locator<DoctorBloc>()..add(DoctorinitialEvent()),
          ),
          BlocProvider(
            create: (_) => locator<IntroductionBloc>(),
          ),
          BlocProvider(
            create: (_) => locator<PatientsInfoBloc>(),
          ),
          BlocProvider(
            create: (_) => locator<PatientsBloc>()..add(PatientsinitialEvent()),
          )
        ],
        child: ScreenUtilInit(
            designSize: const Size(320, 609),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                  locale: DevicePreview.locale(context),
                  builder: DevicePreview.appBuilder,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  debugShowCheckedModeBanner: false,
                  home: MyWidget(
                    device: device,
                  ));
            }));
  }
}

class MyWidget extends StatefulWidget {
  final device;
  const MyWidget({super.key, this.device});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isConnected = false;
  bool isAuthuntificated = false;
  bool status = false;
  late String type;

  DoctorAuthStateUseCase doctorAuthStateUseCase = DoctorAuthStateUseCase();
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    _loadStatus();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.device);
    }

    if (status) {
      return Scaffold(
        body: Mypage(
          device: widget.device,
          popOrNot: false,
        ),
      );
    } else {
      return const PagesShower();
    }
  }

  Future<void> _loadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      status = (prefs.getBool('ignore') ?? false);
    });
  }
}
