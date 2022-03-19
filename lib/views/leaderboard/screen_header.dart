import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../shared/styles.dart';
import '../../viewmodels/leaderboard_viewmodel.dart';

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
