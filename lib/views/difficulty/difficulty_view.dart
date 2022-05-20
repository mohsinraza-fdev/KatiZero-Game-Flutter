import 'package:flutter/material.dart';
import 'package:kati_zero/models/game_model.dart';
import 'package:kati_zero/shared/styles.dart';
import 'package:kati_zero/viewmodels/difficulty_viewmodel.dart';
import 'package:kati_zero/widgets/app_selection_button.dart';
import 'package:stacked/stacked.dart';

class DifficultyView extends StatelessWidget {
  const DifficultyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DifficultyViewModel>.nonReactive(
      viewModelBuilder: () => DifficultyViewModel(),
      builder: (context, model, child) => Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            backgroundColor: appLightBlue,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppSelectionButton(
                    onTap: () => model.setDifficulty(Difficulty.easy),
                    text: 'Easy'),
                const SizedBox(height: 20),
                AppSelectionButton(
                    onTap: () => model.setDifficulty(Difficulty.medium),
                    text: 'Medium'),
                const SizedBox(height: 20),
                AppSelectionButton(
                    onTap: () => model.setDifficulty(Difficulty.hard),
                    text: 'Hard'),
              ],
            ),
          ),
          Positioned(
            top: 60,
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                'Difficulty Selection',
                style: heading2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
