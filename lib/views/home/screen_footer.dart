import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../shared/styles.dart';
import '../../viewmodels/home_viewmodel.dart';

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
