import 'package:flutter/material.dart';

import '../../models/game_model.dart';
import '../../shared/styles.dart';
import '../../shared/ui_helpers.dart';

class VerticalLayer extends StatelessWidget {
  VerticalLayer({
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
      child: SizedBox(
        height: boardHeight,
        width: boardwidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedContainer(
                margin: EdgeInsets.only(bottom: 12),
                duration: Duration(milliseconds: 300),
                height: (winner == null) ||
                        (winner?.winCombination != CombinationType.leftVertical)
                    ? 5
                    : boardHeight - 50,
                width: 15,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(225)),
                child: Container(
                  decoration: BoxDecoration(
                      color: (winner == null) ||
                              (winner?.winCombination !=
                                  CombinationType.leftVertical)
                          ? Colors.transparent
                          : winner!.player.mark == Marks.cross
                              ? appLightBlue
                              : appDarkBlue,
                      borderRadius: BorderRadius.circular(25)),
                )),
            Container(
              width: 2,
              decoration: BoxDecoration(
                  color: Color(0xFFC5C5C5).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(25)),
            ),
            AnimatedContainer(
                margin: EdgeInsets.only(bottom: 12),
                duration: Duration(milliseconds: 300),
                height: (winner == null) ||
                        (winner?.winCombination !=
                            CombinationType.middleVertical)
                    ? 5
                    : boardHeight - 50,
                width: 15,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(225)),
                child: Container(
                  decoration: BoxDecoration(
                      color: (winner == null) ||
                              (winner?.winCombination !=
                                  CombinationType.middleVertical)
                          ? Colors.transparent
                          : winner!.player.mark == Marks.cross
                              ? appLightBlue
                              : appDarkBlue,
                      borderRadius: BorderRadius.circular(25)),
                )),
            Container(
              width: 2,
              decoration: BoxDecoration(
                  color: Color(0xFFC5C5C5).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(25)),
            ),
            AnimatedContainer(
                margin: EdgeInsets.only(bottom: 12),
                duration: Duration(milliseconds: 300),
                height: (winner == null) ||
                        (winner?.winCombination !=
                            CombinationType.rightVertical)
                    ? 5
                    : boardHeight - 50,
                width: 15,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(225)),
                child: Container(
                  decoration: BoxDecoration(
                      color: (winner == null) ||
                              (winner?.winCombination !=
                                  CombinationType.rightVertical)
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
