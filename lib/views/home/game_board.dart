import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spring/spring.dart';
import 'package:stacked/stacked.dart';

import '../../models/game_model.dart';
import '../../shared/styles.dart';
import '../../shared/ui_helpers.dart';
import '../../viewmodels/home_viewmodel.dart';
import 'diagonal_layer.dart';
import 'horizontal_layer.dart';
import 'vertical_layer.dart';

class GameBoard extends ViewModelWidget<HomeViewModel> {
  const GameBoard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    double boardwidth =
        (screenWidth(context) - 60) > 400 ? 400 : (screenWidth(context) - 60);
    double boardHeight = boardwidth * 1.12;

    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          height: boardHeight,
          width: boardwidth,
          child: GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: boardwidth / boardHeight,
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (viewModel.winner == null) {
                        viewModel.dropMark(index);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 25),
                      alignment: Alignment.center,
                      child: viewModel.gameBoard[index ~/ 3][index % 3] ==
                              Marks.none
                          ? const IgnorePointer(
                              ignoring: true, child: SizedBox())
                          : Image(
                              image: AssetImage(viewModel.getImage(
                                  viewModel.gameBoard[index ~/ 3][index % 3]))),
                    ),
                  )),
        ),
        HorizontalLayer(
          winner: viewModel.winner,
          topLayer: false,
        ),
        VerticalLayer(
          winner: viewModel.winner,
        ),
        HorizontalLayer(
          winner: viewModel.winner,
          topLayer: true,
        ),
        DiagonalLayer(winner: viewModel.winner),
        if (viewModel.showTrophy == true)
          Spring.bubbleButton(
              child: GestureDetector(
            onTap: () => viewModel.hideTrophy(),
            child: Container(
              width: boardwidth,
              height: boardHeight,
              decoration: BoxDecoration(
                  color: appDarkBlue, borderRadius: BorderRadius.circular(30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset('images/trophy.svg'),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        viewModel.winner == null
                            ? 'It\'s a'
                            : viewModel.winner!.player.id == Players.one
                                ? 'Player 1'
                                : 'Player 2',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.20),
                      ),
                      Text(
                        viewModel.winner == null ? 'DRAW' : 'WON',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.40),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ))
      ],
    );
  }
}
