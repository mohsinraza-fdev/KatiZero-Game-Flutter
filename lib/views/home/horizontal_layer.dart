import 'package:flutter/material.dart';

import '../../models/game_model.dart';
import '../../shared/styles.dart';
import '../../shared/ui_helpers.dart';

class HorizontalLayer extends StatelessWidget {
  HorizontalLayer({
    Key? key,
    required this.winner,
    required this.topLayer,
  }) : super(key: key);

  Winner? winner;
  bool topLayer;

  @override
  Widget build(BuildContext context) {
    double boardwidth =
        (screenWidth(context) - 60) > 400 ? 400 : (screenWidth(context) - 60);
    double boardHeight = boardwidth * 1.12;

    return IgnorePointer(
      ignoring: true,
      child: SizedBox(
        height: boardHeight,
        width: boardwidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (topLayer == true)
              AnimatedContainer(
                  margin: EdgeInsets.only(
                      bottom: winner == null
                          ? 8
                          : winner!.player.mark == Marks.zero
                              ? 16
                              : 8),
                  duration: Duration(milliseconds: 300),
                  height: 15,
                  width: (winner == null) ||
                          (winner?.winCombination !=
                              CombinationType.topHorizontal)
                      ? 5
                      : boardwidth - 50,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(225)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: (winner == null) ||
                                (winner?.winCombination !=
                                    CombinationType.topHorizontal)
                            ? Colors.transparent
                            : winner!.player.mark == Marks.cross
                                ? appLightBlue
                                : appDarkBlue,
                        borderRadius: BorderRadius.circular(25)),
                  )),
            Container(
              height: 2,
              decoration: BoxDecoration(
                  color: topLayer == false
                      ? Color(0xFFC5C5C5).withOpacity(0.4)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25)),
            ),
            if (topLayer == true)
              AnimatedContainer(
                  margin: EdgeInsets.only(
                      bottom: winner == null
                          ? 8
                          : winner!.player.mark == Marks.zero
                              ? 16
                              : 8),
                  duration: Duration(milliseconds: 300),
                  height: 15,
                  width: (winner == null) ||
                          (winner?.winCombination !=
                              CombinationType.middleHorizontal)
                      ? 5
                      : boardwidth - 50,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(225)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: (winner == null) ||
                                (winner?.winCombination !=
                                    CombinationType.middleHorizontal)
                            ? Colors.transparent
                            : winner!.player.mark == Marks.cross
                                ? appLightBlue
                                : appDarkBlue,
                        borderRadius: BorderRadius.circular(25)),
                  )),
            Container(
              height: 2,
              decoration: BoxDecoration(
                  color: topLayer == false
                      ? Color(0xFFC5C5C5).withOpacity(0.4)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25)),
            ),
            if (topLayer == true)
              AnimatedContainer(
                  margin: EdgeInsets.only(
                      bottom: winner == null
                          ? 8
                          : winner!.player.mark == Marks.zero
                              ? 16
                              : 8),
                  duration: Duration(milliseconds: 300),
                  height: 15,
                  width: (winner == null) ||
                          (winner?.winCombination !=
                              CombinationType.bottomHorizontal)
                      ? 5
                      : boardwidth - 50,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(225)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: (winner == null) ||
                                (winner?.winCombination !=
                                    CombinationType.bottomHorizontal)
                            ? Colors.transparent
                            : winner!.player.mark == Marks.cross
                                ? appLightBlue
                                : appDarkBlue,
                        borderRadius: BorderRadius.circular(25)),
                  )),
          ],
        ),
      ),
    );
  }
}
