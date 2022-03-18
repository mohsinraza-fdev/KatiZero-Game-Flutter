import 'package:injectable/injectable.dart';
import 'package:kati_zero/models/game_model.dart';

@lazySingleton
class BoardService {
  final List<Player> _players = [
    Player(id: Players.one, mark: Marks.zero),
    Player(id: Players.two, mark: Marks.cross)
  ];
  List<Player> get players => _players;

  List<Player?> _leaderBoard = <Player?>[];
  List<Player?> get leaderBoard => _leaderBoard;

  void addPlayerToLeaderBoard(Player? player) {
    _leaderBoard.insert(0, player);
  }
}
