import 'package:admin/screens/dashboard/components/rfid_bloc/rfid_plan_bloc.dart';
import 'package:admin/screens/expense_list/expense_plan_bloc/bloc/expense_plan_bloc.dart';
import 'package:admin/screens/plans/12sess/12session_bloc/bloc/12session_bloc.dart';
import 'package:admin/screens/plans/16session/16session_bloc/bloc/16session_bloc.dart';
import 'package:admin/screens/plans/8session/8session_bloc/bloc/8session_bloc.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/injection_container.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/plans/unlimited/unlimited_plan_bloc/bloc/unlimited_plan_bloc.dart';
import 'package:admin/screens/products_screens/products_bloc/products_bloc.dart';
import 'package:admin/screens/products_screens/products_bloc/products_blocEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:admin/screens/plans/12sess/12session_bloc/bloc/session_12_event.dart'
    as Event12;

import 'package:admin/screens/plans/8session/8session_bloc/bloc/session_8_event.dart'
    as Event8;

import 'package:admin/screens/plans/16session/16session_bloc/bloc/session_16_event.dart'
    as Event16;

import 'package:admin/screens/expense_list/expense_plan_bloc/bloc/expense_plan_bloc.dart'
    as Expense;

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
        BlocProvider(create: (_) => locator<Session_16_PlanBloc>()),
        BlocProvider(create: (_) => locator<ProductsBloc>()),
        BlocProvider(create: (_) => locator<Expense_PlanBloc>()),
        BlocProvider(create: (_) => locator<Rfid_PlanBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Admin Panel',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Color(0xff202020)),
        ),
        home: GenderSelectionPage(),
      ),
    );
  }
}

class GenderSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                BlocsEventGet(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (context) => MenuAppController(),
                        ),
                      ],
                      child: MyInheritedWidget(
                          geneder: "Femme", child: MainScreen(gender: 'Femme')),
                    ),
                  ),
                );
              },
              child: Text('Femme'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                BlocsEventGet(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (context) => MenuAppController(),
                        ),
                      ],
                      child: MyInheritedWidget(
                          geneder: "Homme", child: MainScreen(gender: 'Homme')),
                    ),
                  ),
                );
              },
              child: Text('Homme'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final String geneder;

  MyInheritedWidget({required this.geneder, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) =>
      geneder != oldWidget.geneder;

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }
}

void BlocsEventGet(BuildContext context) {
  final Unlimited_PlanBloc _unlimited_bloc =
      BlocProvider.of<Unlimited_PlanBloc>(context);
  final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);
  final Session_8_PlanBloc session_8_planBloc =
      BlocProvider.of<Session_8_PlanBloc>(context);
  final Session_16_PlanBloc session_16_planBloc =
      BlocProvider.of<Session_16_PlanBloc>(context);
  final Session_12_PlanBloc session_12_planBloc =
      BlocProvider.of<Session_12_PlanBloc>(context);
  final Expense_PlanBloc expense_planBloc =
      BlocProvider.of<Expense_PlanBloc>(context);
  _unlimited_bloc.add(GetUsersEvent(context: context));
  session_8_planBloc.add(Event8.GetUsersEvent(context: context));
  session_12_planBloc.add(Event12.GetUsersEvent(context: context));
  session_16_planBloc.add(Event16.GetUsersEvent(context: context));
  expense_planBloc.add(Expense.GetExpensesEvent(context: context));
  productsBloc.add(GetProductsEvent(context: context));
}
