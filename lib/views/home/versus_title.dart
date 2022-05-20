import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kati_zero/viewmodels/home_viewmodel.dart';
import 'package:kati_zero/views/home/home_view.dart';
import 'package:stacked/stacked.dart';

import '../../shared/styles.dart';

class VersusTitle extends ViewModelWidget<HomeViewModel> {
  const VersusTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
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
                viewModel.botEnabled ? 'AI Bot' : 'Player 2',
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
