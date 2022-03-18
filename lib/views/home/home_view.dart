import 'package:flutter/material.dart';
import 'package:kati_zero/shared/ui_helpers.dart';
import 'package:kati_zero/viewmodels/home_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'game_board.dart';
import 'screen_footer.dart';
import 'turn_indicators.dart';
import 'versus_title.dart';

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
