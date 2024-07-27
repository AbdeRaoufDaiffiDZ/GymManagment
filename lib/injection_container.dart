import 'package:admin/data/mongo_db.dart';
import 'package:admin/unlimited_plan_bloc/bloc/unlimited_plan_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<Unlimited_PlanBloc>(Unlimited_PlanBloc());
  // locator.registerFactory(() => IntroductionBloc(locator(), locator(),
  //     locator(), locator(), locator(), locator(), locator()));

  locator.registerLazySingleton<MongoDatabase>(
      () => MongoDatabase());

  // // external
  // locator.registerLazySingleton(() => http.Client());
  // locator.registerLazySingleton(() => FirebaseDatabase());
  // locator.registerLazySingleton(() => FirebaseAuth.instance);
  // locator.registerSingleton<SharedPreferences>(sharedPreferences);
}
