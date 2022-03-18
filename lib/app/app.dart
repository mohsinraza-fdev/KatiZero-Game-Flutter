import 'package:kati_zero/views/home/home_view.dart';
import 'package:kati_zero/views/leaderboard/leaderboard_view.dart';
import 'package:kati_zero/views/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(routes: [
  MaterialRoute(page: SplashView, initial: true),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: LeaderboardView),
])
class AppSetup {}
