enum Players {
  one,
  two,
}

enum Marks {
  cross,
  zero,
  none,
}

enum CombinationType {
  dexterDiagonal,
  sinisterDiagonal,
  middleVertical,
  leftVertical,
  rightVertical,
  middleHorizontal,
  topHorizontal,
  bottomHorizontal,
}

enum Difficulty {
  easy,
  medium,
  hard,
}

class Player {
  Players id;
  Marks mark;

  Player({required this.id, required this.mark});
}

class Winner {
  Player player;
  CombinationType winCombination;

  Winner({required this.player, required this.winCombination});
}
