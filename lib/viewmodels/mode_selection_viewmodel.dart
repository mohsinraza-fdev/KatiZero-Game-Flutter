import 'package:kati_zero/app/app.router.dart';
import 'package:kati_zero/app/locator.dart';
import 'package:kati_zero/services/board_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ModeSelectionViewModel extends BaseViewModel {
  final _navigator = locator<NavigationService>();
  final _boardService = locator<BoardService>();

  void navigateToHome() {
    _boardService.botMode = false;
    _navigator
        .navigateTo(Routes.homeView)
        ?.then((value) => _boardService.clearLeaderBoard());
  }

  void onBotSelection() {
    _boardService.botMode = true;
    _navigator
        .navigateTo(Routes.difficultyView)
        ?.then((value) => _boardService.clearLeaderBoard());
  }
}
