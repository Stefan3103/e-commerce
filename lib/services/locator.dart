import 'package:get_it/get_it.dart';
import 'package:shop_app/models/UserService.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => UserService());
}
