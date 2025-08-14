import 'package:app/favorites/data-controller.dart';
import 'package:app/recent/data-controller.dart';
import 'package:app/testing/view-state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestingViewController extends Cubit<TestingViewState> {
  final FavoritesDataController _favoritesController;
  final RecentDataController _recentController;

  factory TestingViewController.fromContext(BuildContext context) {
    return TestingViewController(
      context.read<FavoritesDataController>(),
      context.read<RecentDataController>(),
    );
  }

  TestingViewController(
    this._favoritesController,
    this._recentController,
  ) : super(defaultTestingViewState);

  void clearFavorites() {
    _favoritesController.clearFavorites();
  }

  void clearRecents() {
    _recentController.clearRecentGlyphs();
  }
}
