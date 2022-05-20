import 'package:flutter/material.dart';

import '../shared/styles.dart';

class AppSelectionButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const AppSelectionButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: appDarkBlue,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Text(
          text,
          style: heading1.copyWith(color: appTextColor2),
        ),
      ),
    );
  }
}
