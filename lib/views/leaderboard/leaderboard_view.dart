import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kati_zero/shared/styles.dart';
import 'package:kati_zero/viewmodels/leaderboard_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../models/game_model.dart';
import 'item_list.dart';
import 'screen_header.dart';

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
