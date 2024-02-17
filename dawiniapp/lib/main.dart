import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dawini_full/firebase_options.dart';
import 'package:dawini_full/injection_container.dart';
import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:dawini_full/introduction_feature/presentation/screens/pages_shower.dart';
import 'package:dawini_full/patient_features/presentation/bloc/auth_bloc/bloc/doctor_auth_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/clinics_bloc/bloc/clinics_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/myApp.dart';
import 'package:device_info_plus/device_info_plus.dart';
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
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  final device = await deviceInfo.androidInfo;
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
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );

  setupLocator();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MyApp(
      device: device.fingerprint,
    ), // Wrap your app
  );
}

class MyApp extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final device;
  const MyApp({
    Key? key,
    this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.authStateChanges().listen((user) {
    //   if (user == null) {
    //     print("disconnected");
    //   } else {
    //     print("connected");
    //   }
    // });

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => locator<ClinicsBloc>()..add(ClinicinitialEvent()),
          ),
          BlocProvider(create: (_) => locator<DoctorAuthBloc>()),
          BlocProvider(
            create: (_) => locator<DoctorBloc>()..add(DoctorinitialEvent()),
          ),
          BlocProvider(
            create: (_) => locator<IntroductionBloc>(),
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
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                debugShowCheckedModeBanner: false,
                home: MyWidget(device: device),
              );
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
    // _isAuth();
    if (kDebugMode) {
      print(widget.device);
    }

    if (status) {
      return Mypage(device: widget.device);
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

  // Future<void> _isAuth() async {
  //   FirebaseAuth.instance.authStateChanges().listen((user) {
  //     if (user == null) {
  //       setState(() {
  //         isAuthuntificated = false;
  //       });
  //     } else {
  //       setState(() {
  //         isAuthuntificated = true;
  //       });
  //     }
  //   });
  // }
}
