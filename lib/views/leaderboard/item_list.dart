import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../models/game_model.dart';
import '../../viewmodels/leaderboard_viewmodel.dart';

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

