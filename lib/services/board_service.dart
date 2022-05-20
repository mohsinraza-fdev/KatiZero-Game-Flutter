import 'package:injectable/injectable.dart';
import 'package:kati_zero/models/game_model.dart';
import 'package:kati_zero/views/difficulty/difficulty_view.dart';

@lazySingleton
class BoardService {
  final List<Player> _players = [
    Player(id: Players.one, mark: Marks.zero),
    Player(id: Players.two, mark: Marks.cross)
  ];
  List<Player> get players => _players;

  List<Player?> _leaderBoard = <Player?>[];
  List<Player?> get leaderBoard => _leaderBoard;

  bool botMode = false;
  Difficulty difficulty = Difficulty.easy;

  void addPlayerToLeaderBoard(Player? player) {
    _leaderBoard.insert(0, player);
  }

  void clearLeaderBoard() {
    _leaderBoard = <Player?>[];
  }
}
