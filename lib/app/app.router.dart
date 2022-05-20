// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../views/difficulty/difficulty_view.dart';
import '../views/home/home_view.dart';
import '../views/leaderboard/leaderboard_view.dart';
import '../views/mode_selection/mode_selection_view.dart';
import '../views/splash/splash_view.dart';

class Routes {
  static const String splashView = '/';
  static const String homeView = '/home-view';
  static const String leaderboardView = '/leaderboard-view';
  static const String modeSelectionView = '/mode-selection-view';
  static const String difficultyView = '/difficulty-view';
  static const all = <String>{
    splashView,
    homeView,
    leaderboardView,
    modeSelectionView,
    difficultyView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.leaderboardView, page: LeaderboardView),
    RouteDef(Routes.modeSelectionView, page: ModeSelectionView),
    RouteDef(Routes.difficultyView, page: DifficultyView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SplashView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    LeaderboardView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LeaderboardView(),
        settings: data,
      );
    },
    ModeSelectionView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ModeSelectionView(),
        settings: data,
      );
    },
    DifficultyView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DifficultyView(),
        settings: data,
      );
    },
  };
}
