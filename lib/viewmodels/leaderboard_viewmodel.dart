import 'package:kati_zero/app/locator.dart';
import 'package:kati_zero/models/game_model.dart';
import 'package:kati_zero/services/board_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LeaderboardViewModel extends BaseViewModel {
  final _boardService = locator<BoardService>();
  final _navigator = locator<NavigationService>();

  List<Player?> get leaderboardItems => _boardService.leaderBoard;
  bool get botEnabled => _boardService.botMode;

  void back() {
    _navigator.back();
  }
}
