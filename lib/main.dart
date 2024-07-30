import 'package:admin/12sess/12session_bloc/bloc/12session_bloc.dart';
import 'package:admin/16session/16session_bloc/bloc/16session_bloc.dart';
import 'package:admin/8session/8session_bloc/bloc/8session_bloc.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/injection_container.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/unlimited_plan_bloc/bloc/unlimited_plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(); // Initialize service locator
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<Unlimited_PlanBloc>()),
        BlocProvider(create: (_) => locator<Session_8_PlanBloc>()),
        BlocProvider(create: (_) => locator<Session_12_PlanBloc>()),
        BlocProvider(create: (_) => locator<Session_16_PlanBloc>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Admin Panel',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xffFAFAFA),
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Color(0xff202020)),
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuAppController(),
            ),
          ],
          child: MainScreen(),
        ),
      ),
    );
  }
}
