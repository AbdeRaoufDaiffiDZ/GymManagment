import 'package:admin/data/http_local_data.dart';
import 'package:admin/screens/dashboard/components/rfid_bloc/rfid_plan_bloc.dart';
import 'package:admin/screens/expense_list/expense_plan_bloc/bloc/expense_plan_bloc.dart';
import 'package:admin/screens/plans/12sess/12session_bloc/bloc/12session_bloc.dart';
import 'package:admin/screens/plans/16session/16session_bloc/bloc/16session_bloc.dart';
import 'package:admin/screens/plans/8session/8session_bloc/bloc/8session_bloc.dart';
import 'package:admin/data/mongo_db.dart';
import 'package:admin/screens/plans/unlimited/unlimited_plan_bloc/bloc/unlimited_plan_bloc.dart';
import 'package:admin/screens/products_screens/products_bloc/products_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<Unlimited_PlanBloc>(Unlimited_PlanBloc());
  locator.registerSingleton<Session_8_PlanBloc>(Session_8_PlanBloc());
  locator.registerSingleton<Session_12_PlanBloc>(Session_12_PlanBloc());
  locator.registerSingleton<Session_16_PlanBloc>(Session_16_PlanBloc());
  locator.registerSingleton<ProductsBloc>(ProductsBloc());
  locator.registerSingleton<Expense_PlanBloc>(Expense_PlanBloc());
  locator.registerSingleton<Rfid_PlanBloc>(Rfid_PlanBloc());

  // locator.registerFactory(() => IntroductionBloc(locator(), locator(),
  //     locator(), locator(), locator(), locator(), locator()));

  locator.registerLazySingleton<MongoDatabase>(() => MongoDatabase());
  locator.registerLazySingleton<GetDataFromHttp>(() => GetDataFromHttp());

  // // external
  // locator.registerLazySingleton(() => http.Client());
  // locator.registerLazySingleton(() => FirebaseDatabase());
  // locator.registerLazySingleton(() => FirebaseAuth.instance);
  // locator.registerSingleton<SharedPreferences>(sharedPreferences);
}
