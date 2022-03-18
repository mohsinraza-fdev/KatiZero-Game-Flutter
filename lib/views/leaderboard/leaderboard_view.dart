import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kati_zero/shared/styles.dart';
import 'package:kati_zero/viewmodels/leaderboard_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../models/game_model.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeaderboardViewModel>.nonReactive(
        viewModelBuilder: () => LeaderboardViewModel(),
        builder: (context, model, child) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    ScreenHeader(),
                    SizedBox(height: 56),
                    ItemList(),
                  ],
                ),
              ),
            ));
  }
}

class ItemList extends ViewModelWidget<LeaderboardViewModel> {
  const ItemList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, LeaderboardViewModel viewModel) {
    return Expanded(
        child: ListView.builder(
      padding: EdgeInsets.only(top: 9),
      itemCount: viewModel.leaderboardItems.length,
      itemBuilder: (BuildContext context, int index) => Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 9),
        height: 98,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: viewModel.leaderboardItems[index] != null
              ? Color(0xFFF5F5F5)
              : Color.fromARGB(255, 255, 228, 228),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (viewModel.leaderboardItems[index] != null) ...[
              SizedBox(width: 34),
              viewModel.leaderboardItems[index]!.mark == Marks.cross
                  ? SvgPicture.asset('images/cross_mini.svg')
                  : SvgPicture.asset('images/zero_mini.svg'),
              SizedBox(width: 23),
              Text(
                viewModel.leaderboardItems[index]!.id == Players.one
                    ? 'Player 1'
                    : 'Player 2',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              Image(image: AssetImage('images/trophy_mini.png')),
              SizedBox(width: 19),
            ],
            if (viewModel.leaderboardItems[index] == null) ...[
              Text(
                'Draw',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                  color: Colors.black,
                ),
              ),
            ]
          ],
        ),
      ),
    ));
  }
}

class ScreenHeader extends ViewModelWidget<LeaderboardViewModel> {
  const ScreenHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, LeaderboardViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 55),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () => viewModel.back(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Image(image: AssetImage('images/back.png')),
              )),
          SizedBox(width: 26),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  'LEADER',
                  style: GoogleFonts.poppins(
                    color: appDarkBlue,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 7.5,
                    height: 1,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'BOARD',
                style: GoogleFonts.poppins(
                  color: appDarkBlue,
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 10.5,
                  height: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
