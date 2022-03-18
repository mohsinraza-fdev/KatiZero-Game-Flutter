import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kati_zero/app/app.router.dart';
import 'package:kati_zero/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final _navigator = locator<NavigationService>();

  switchScreen() {
    Future.delayed(Duration(seconds: 3),
        () => _navigator.clearStackAndShow(Routes.homeView));
  }
}
