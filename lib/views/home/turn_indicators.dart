import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../models/game_model.dart';
import '../../shared/styles.dart';
import '../../viewmodels/home_viewmodel.dart';

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
