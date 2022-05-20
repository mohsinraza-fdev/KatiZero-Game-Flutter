import 'package:kati_zero/app/app.router.dart';
import 'package:kati_zero/views/home/home_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';
import '../models/game_model.dart';
import '../services/board_service.dart';

class DifficultyViewModel extends BaseViewModel {
  final _navigator = locator<NavigationService>();
  final _boardService = locator<BoardService>();

  void setDifficulty(Difficulty diff) {
    _boardService.difficulty = diff;
    _navigator.navigateTo(Routes.homeView);
  }
}
