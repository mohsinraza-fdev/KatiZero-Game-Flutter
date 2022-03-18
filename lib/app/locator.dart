import 'package:get_it/get_it.dart';
import 'package:kati_zero/services/board_service.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => BoardService());
}
