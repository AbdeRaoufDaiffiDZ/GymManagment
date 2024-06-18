// ignore_for_file: no_logic_in_create_state, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dawini_full/auth/domain/usecases/auth_usecase.dart';
import 'package:dawini_full/auth/presentation/bloc/auth_bloc.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_data_bloc/doctor_data_bloc.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/patients_info_bloc/patients_info_bloc.dart';
import 'package:dawini_full/firebase_options.dart';
import 'package:dawini_full/injection_container.dart';
import 'package:dawini_full/introduction_feature/data/lanugage_constant.dart';
import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:dawini_full/introduction_feature/presentation/screens/pages_shower.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/doctor_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/myApp.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  final int? pageNumber;
  const MyApp({
    super.key,
    this.pageNumber,
  });
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? language;
  int? fontSize;
  Locale? _locale;
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    lanugageGet().then((value) => setState(() {
          language = value;
        }));
    fontSizeGet().then((value) => setState(() {
          fontSize = value;
        }));
    _locale = DevicePreview.locale(context);
  }

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => setLocale(locale));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // BlocProvider(
          //   create: (_) => locator<ClinicsBloc>()..add(ClinicinitialEvent()),
          // ),
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
          ),
          BlocProvider(create: (_) => locator<AuthBloc>())
        ],
        child: ScreenUtilInit(
            designSize: const Size(320, 609),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                  locale: _locale,
                  builder: DevicePreview.appBuilder,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  debugShowCheckedModeBanner: false,
                  home: MyWidget(
                    fontSize: fontSize == null ? 0 : fontSize!,
                    locale:
                        _locale, // TODO HERE YOU CHANGE THE FONT SIZE, USER IS ABLE TO CHANGE FONTS SIZE FROM THIS PARM
                  ));
            }));
  }

  Future<String?> lanugageGet() async {
    final snapshot = await SharedPreferences.getInstance();
    return snapshot.getString('language');
  }

  Future<int?> fontSizeGet() async {
    final snapshot = await SharedPreferences.getInstance();
    return snapshot.getInt('fontSize');
  }
}

class MyWidget extends StatefulWidget {
  final int fontSize;
  final locale;
  const MyWidget({
    super.key,
    required this.fontSize,
    required this.locale,
  });

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  DoctorAuthStateUseCase doctorAuthStateUseCase = DoctorAuthStateUseCase();
  bool? status;
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    statusGet().then((value) => setState(() {
          status = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    Locale _currentLocale = widget.locale ?? Locale('en');
    if (status == true) {
      return LocaleProvider(
        currentLocale: _currentLocale,
        child: Scaffold(
          body: Mypage(
            popOrNot: false,
            fontSize: widget.fontSize,
          ),
        ),
      );
    } else {
      return LocaleProvider(
          currentLocale: _currentLocale,
          child: PagesShower(fontSize: widget.fontSize));
    }
  }

  Future<bool?> statusGet() async {
    final snapshot = await SharedPreferences.getInstance();
    return status = snapshot.getBool('ignore');
  }
}

class LocaleProvider extends InheritedWidget {
  final Locale currentLocale;

  const LocaleProvider({
    Key? key,
    required this.currentLocale,
    required Widget child,
  }) : super(key: key, child: child);

  static LocaleProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LocaleProvider>();
  }

  @override
  bool updateShouldNotify(LocaleProvider oldWidget) {
    return oldWidget.currentLocale != currentLocale;
  }
}
