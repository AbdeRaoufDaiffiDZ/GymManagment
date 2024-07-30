import 'package:admin/12sess/12session_bloc/bloc/12session_bloc.dart';
import 'package:admin/16session/16session_bloc/bloc/16session_bloc.dart';
import 'package:admin/8session/8session_bloc/bloc/8session_bloc.dart';
import 'package:admin/data/mongo_db.dart';
import 'package:admin/unlimited_plan_bloc/bloc/unlimited_plan_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<Unlimited_PlanBloc>(Unlimited_PlanBloc());
  locator.registerSingleton<Session_8_PlanBloc>(Session_8_PlanBloc());
  locator.registerSingleton<Session_12_PlanBloc>(Session_12_PlanBloc());
  locator.registerSingleton<Session_16_PlanBloc>(Session_16_PlanBloc());

  // locator.registerFactory(() => IntroductionBloc(locator(), locator(),
  //     locator(), locator(), locator(), locator(), locator()));

  locator.registerLazySingleton<MongoDatabase>(() => MongoDatabase());

  // // external
  // locator.registerLazySingleton(() => http.Client());
  // locator.registerLazySingleton(() => FirebaseDatabase());
  // locator.registerLazySingleton(() => FirebaseAuth.instance);
  // locator.registerSingleton<SharedPreferences>(sharedPreferences);
}
