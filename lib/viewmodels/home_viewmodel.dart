import 'dart:async';

import "dart:math";
import 'package:kati_zero/app/app.router.dart';
import 'package:kati_zero/app/locator.dart';
import 'package:kati_zero/services/board_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../models/game_model.dart';

class HomeViewModel extends BaseViewModel {
  final _boardService = locator<BoardService>();
  final _navigator = locator<NavigationService>();

  List<Player> get players => _boardService.players;
  bool get botEnabled => _boardService.botMode;

  Players turn = Players.one;
  Winner? winner;
  bool isDraw = false;

  bool showTrophy = false;

  List<List<Marks>> gameBoard = <List<Marks>>[
    <Marks>[
      Marks.none,
      Marks.none,
      Marks.none,
    ],
    <Marks>[
      Marks.none,
      Marks.none,
      Marks.none,
    ],
    <Marks>[
      Marks.none,
      Marks.none,
      Marks.none,
    ]
  ];

  void switchTurn() {
    if (turn == Players.one) {
      turn = Players.two;
    } else {
      turn = Players.one;
    }
  }

  int getBotMarkIndex() {
    List<Marks> board = [...gameBoard[0], ...gameBoard[1], ...gameBoard[2]];
    List<int> emptyIndexes = <int>[];
    int index = 0;
    board.forEach((item) {
      if (item == Marks.none) {
        emptyIndexes.add(index);
      }
      index++;
    });
    final random = Random();
    int i = random.nextInt(emptyIndexes.length);
    return emptyIndexes[i];
  }

  void dropMark(int index) {
    int row = index ~/ 3;
    int col = index % 3;
    if (gameBoard[row][col] != Marks.none) {
      return;
    }
    for (Player player in players) {
      if (player.id == turn) {
        gameBoard[row][col] = player.mark;
      }
    }
    checkWinner();
    switchTurn();
    notifyListeners();

    if (winner != null || isDraw) {
      Timer(Duration(milliseconds: 500), () {
        showTrophy = true;
        notifyListeners();
      });
    }
  }

  String getImage(Marks mark) {
    switch (mark) {
      case Marks.cross:
        return 'images/cross.png';
      case Marks.zero:
        return 'images/zero.png';
      case Marks.none:
        return 'images/cross.png';
    }
  }

  void checkWinner() {
    if ((gameBoard[0][0] == gameBoard[0][1]) &&
        (gameBoard[0][0] == gameBoard[0][2]) &&
        (gameBoard[0][1] == gameBoard[0][2]) &&
        (gameBoard[0][0] != Marks.none)) {
      winner = Winner(
          player: getPlayerByMark(gameBoard[0][0])!,
          winCombination: CombinationType.topHorizontal);
      _boardService.addPlayerToLeaderBoard(getPlayerByMark(gameBoard[0][0])!);
    } else if ((gameBoard[1][0] == gameBoard[1][1]) &&
        (gameBoard[1][0] == gameBoard[1][2]) &&
        (gameBoard[1][1] == gameBoard[1][2]) &&
        (gameBoard[1][0] != Marks.none)) {
      winner = Winner(
          player: getPlayerByMark(gameBoard[1][0])!,
          winCombination: CombinationType.middleHorizontal);
      _boardService.addPlayerToLeaderBoard(getPlayerByMark(gameBoard[1][0])!);
    } else if ((gameBoard[2][0] == gameBoard[2][1]) &&
        (gameBoard[2][0] == gameBoard[2][2]) &&
        (gameBoard[2][1] == gameBoard[2][2]) &&
        (gameBoard[2][0] != Marks.none)) {
      winner = Winner(
          player: getPlayerByMark(gameBoard[2][0])!,
          winCombination: CombinationType.bottomHorizontal);
      _boardService.addPlayerToLeaderBoard(getPlayerByMark(gameBoard[2][0])!);
    } else if ((gameBoard[0][0] == gameBoard[1][0]) &&
        (gameBoard[0][0] == gameBoard[2][0]) &&
        (gameBoard[1][0] == gameBoard[2][0]) &&
        (gameBoard[0][0] != Marks.none)) {
      winner = Winner(
          player: getPlayerByMark(gameBoard[0][0])!,
          winCombination: CombinationType.leftVertical);
      _boardService.addPlayerToLeaderBoard(getPlayerByMark(gameBoard[0][0])!);
    } else if ((gameBoard[0][1] == gameBoard[1][1]) &&
        (gameBoard[0][1] == gameBoard[2][1]) &&
        (gameBoard[1][1] == gameBoard[2][1]) &&
        (gameBoard[0][1] != Marks.none)) {
      winner = Winner(
          player: getPlayerByMark(gameBoard[0][1])!,
          winCombination: CombinationType.middleVertical);
      _boardService.addPlayerToLeaderBoard(getPlayerByMark(gameBoard[0][1])!);
    } else if ((gameBoard[0][2] == gameBoard[1][2]) &&
        (gameBoard[0][2] == gameBoard[2][2]) &&
        (gameBoard[1][2] == gameBoard[2][2]) &&
        (gameBoard[0][2] != Marks.none)) {
      winner = Winner(
          player: getPlayerByMark(gameBoard[0][2])!,
          winCombination: CombinationType.rightVertical);
      _boardService.addPlayerToLeaderBoard(getPlayerByMark(gameBoard[0][2])!);
    } else if ((gameBoard[0][0] == gameBoard[1][1]) &&
        (gameBoard[0][0] == gameBoard[2][2]) &&
        (gameBoard[1][1] == gameBoard[2][2]) &&
        (gameBoard[0][0] != Marks.none)) {
      winner = Winner(
          player: getPlayerByMark(gameBoard[0][0])!,
          winCombination: CombinationType.dexterDiagonal);
      _boardService.addPlayerToLeaderBoard(getPlayerByMark(gameBoard[0][0])!);
    } else if ((gameBoard[0][2] == gameBoard[1][1]) &&
        (gameBoard[0][2] == gameBoard[2][0]) &&
        (gameBoard[1][1] == gameBoard[2][0]) &&
        (gameBoard[0][2] != Marks.none)) {
      winner = Winner(
          player: getPlayerByMark(gameBoard[0][2])!,
          winCombination: CombinationType.sinisterDiagonal);
      _boardService.addPlayerToLeaderBoard(getPlayerByMark(gameBoard[0][2])!);
    } else if (!(gameBoard
        .expand((element) => element)
        .toList()
        .contains(Marks.none))) {
      _boardService.addPlayerToLeaderBoard(null);
      isDraw = true;
    } else {
      return;
    }
  }

  Player? getPlayerByMark(Marks mark) {
    for (Player player in players) {
      if (player.mark == mark) {
        return player;
      }
    }
  }

  void reset() {
    turn = Players.one;
    showTrophy = false;
    winner = null;
    isDraw = false;
    gameBoard = <List<Marks>>[
      <Marks>[
        Marks.none,
        Marks.none,
        Marks.none,
      ],
      <Marks>[
        Marks.none,
        Marks.none,
        Marks.none,
      ],
      <Marks>[
        Marks.none,
        Marks.none,
        Marks.none,
      ]
    ];
    notifyListeners();
  }

  hideTrophy() {
    showTrophy = false;
    notifyListeners();
  }

  void showLeaderboard() {
    _navigator.navigateTo(Routes.leaderboardView);
  }
}
