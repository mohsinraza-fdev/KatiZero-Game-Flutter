import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kati_zero/models/game_model.dart';
import 'package:kati_zero/shared/styles.dart';
import 'package:kati_zero/shared/ui_helpers.dart';
import 'package:kati_zero/viewmodels/home_viewmodel.dart';
import 'package:spring/spring.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'dart:math' as math;

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double boardwidth =
        (screenWidth(context) - 60) > 400 ? 400 : (screenWidth(context) - 60);
    double boardHeight = boardwidth * 1.12;

    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TurnIndicators(),
              VersusTitle(),
              GameBoard(),
              Spacer(),
              ScreenFooter()
            ],
          ),
        ),
      ),
    );
  }
}

class ScreenFooter extends ViewModelWidget<HomeViewModel> {
  const ScreenFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 25, bottom: 33, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () => viewModel.showLeaderboard(),
            child: Container(
              height: 62,
              width: 218,
              decoration: BoxDecoration(
                  color: appDarkBlue, borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset('images/leaderboard.svg'),
                    Text(
                      'Leader Board',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.18),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
              onTap: () => viewModel.reset(),
              child: SvgPicture.asset('images/reset.svg'))
        ],
      ),
    );
  }
}

class TurnIndicators extends HookViewModelWidget<HomeViewModel> {
  const TurnIndicators({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(BuildContext context, HomeViewModel viewModel) {
    var _animationController = useAnimationController();
    _animationController.duration = const Duration(milliseconds: 600);
    _animationController.repeat(reverse: true);

    return FadeTransition(
      opacity: _animationController,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            Icons.arrow_drop_down,
            color: (viewModel.turn == Players.one) &&
                    (viewModel.winner == null) &&
                    !viewModel.isDraw
                ? appDarkBlue
                : Colors.transparent,
            size: 30,
          ),
          const SizedBox(width: 62),
          Text(
            'VS',
            style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: Colors.transparent),
          ),
          const SizedBox(width: 62),
          Icon(
            Icons.arrow_drop_down,
            color: (viewModel.turn == Players.two) &&
                    (viewModel.winner == null) &&
                    !viewModel.isDraw
                ? appDarkBlue
                : Colors.transparent,
            size: 30,
          ),
        ],
      ),
    );
  }
}

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

class VersusTitle extends StatelessWidget {
  const VersusTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 65),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'images/zerox.svg',
              ),
              SizedBox(height: 11),
              Text(
                'Player 1',
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    letterSpacing: 0.25,
                    fontWeight: FontWeight.w600,
                    color: appTextColor1),
              )
            ],
          ),
          SizedBox(width: 25),
          Padding(
            padding: const EdgeInsets.only(bottom: 45),
            child: Text(
              'VS',
              style: GoogleFonts.poppins(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: appTextColor2),
            ),
          ),
          SizedBox(width: 25),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('images/crossx.svg'),
              SizedBox(height: 11),
              Text(
                'Player 2',
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    letterSpacing: 0.25,
                    fontWeight: FontWeight.w600,
                    color: appTextColor1),
              )
            ],
          )
        ],
      ),
    );
  }
}
