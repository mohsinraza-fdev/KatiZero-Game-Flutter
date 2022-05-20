import 'package:flutter/material.dart';
import 'package:kati_zero/shared/styles.dart';
import 'package:kati_zero/viewmodels/mode_selection_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/app_selection_button.dart';

class ModeSelectionView extends StatelessWidget {
  const ModeSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ModeSelectionViewModel>.nonReactive(
      viewModelBuilder: () => ModeSelectionViewModel(),
      builder: (context, model, child) => Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            backgroundColor: appLightBlue,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppSelectionButton(
                  text: 'Player   vs   AI Bot',
                  onTap: () => model.onBotSelection(),
                ),
                const SizedBox(height: 20),
                AppSelectionButton(
                  text: 'Player   vs   Player',
                  onTap: () => model.navigateToHome(),
                ),
              ],
            ),
          ),
          Positioned(
            top: 60,
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                'Mode Selection',
                style: heading2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
