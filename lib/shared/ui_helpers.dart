import 'package:flutter/material.dart';

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double statusBarHeight(BuildContext context) =>
    MediaQuery.of(context).padding.top;
