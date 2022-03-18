import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../models/game_model.dart';
import '../../shared/styles.dart';
import '../../shared/ui_helpers.dart';

class DiagonalLayer extends StatelessWidget {
  DiagonalLayer({
    Key? key,
    required this.winner,
  }) : super(key: key);

  Winner? winner;

  @override
  Widget build(BuildContext context) {
    double boardwidth =
        (screenWidth(context) - 60) > 400 ? 400 : (screenWidth(context) - 60);
    double boardHeight = boardwidth * 1.12;

    return IgnorePointer(
      ignoring: true,
      child: Container(
        clipBehavior: Clip.none,
        width: boardwidth,
        height: boardHeight,
        child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                left: winner == null
                    ? (boardwidth / 2)
                    : (winner?.winCombination == CombinationType.dexterDiagonal)
                        ? -46
                        : -31,
                child: Transform.rotate(
                  angle: winner == null
                      ? math.pi / 180 * 48.2
                      : (winner != null) &&
                              (winner?.winCombination ==
                                  CombinationType.dexterDiagonal)
                          ? math.pi / 180 * 48.2
                          : -(math.pi / 180 * 48.2),
                  child: AnimatedContainer(
                      margin: EdgeInsets.only(
                        bottom: 20,
                        left: 0,
                        top: 0,
                        right: 0,
                      ),
                      duration: Duration(milliseconds: 300),
                      height: 15,
                      width: (winner == null) ||
                              (winner?.winCombination !=
                                      CombinationType.dexterDiagonal &&
                                  winner?.winCombination !=
                                      CombinationType.sinisterDiagonal)
                          ? 5
                          : boardwidth + 77,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(225)),
                      child: Container(
                        decoration: BoxDecoration(
                            color: (winner == null) ||
                                    (winner?.winCombination !=
                                            CombinationType.dexterDiagonal &&
                                        winner?.winCombination !=
                                            CombinationType.sinisterDiagonal)
                                ? Colors.transparent
                                : winner!.player.mark == Marks.cross
                                    ? appLightBlue
                                    : appDarkBlue,
                            borderRadius: BorderRadius.circular(25)),
                      )),
                ),
              ),
            ]),
      ),
    );
  }
}
