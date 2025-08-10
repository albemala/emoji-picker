import 'dart:async';

import 'package:app/app/view-state.dart';
import 'package:app/app_usage/data-controller.dart';
import 'package:app/preferences/data-controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppViewController extends Cubit<AppViewState> {
  final AppUsageDataController appUsageDataController;
  final PreferencesDataController preferencesDataController;

  StreamSubscription<void>? preferencesDataControllerSubscription;

  factory AppViewController.fromContext(BuildContext context) {
    return AppViewController(
      context.read<AppUsageDataController>(),
      context.read<PreferencesDataController>(),
    );
  }

  AppViewController(
    this.appUsageDataController,
    this.preferencesDataController,
  ) : super(defaultAppViewState) {
    preferencesDataControllerSubscription = preferencesDataController.stream
        .listen((_) {
          updateViewState();
        });
    updateViewState();

    // Wait for data controllers initialization
    _waitForInitialization();
  }

  @override
  Future<void> close() {
    preferencesDataControllerSubscription?.cancel();
    return super.close();
  }

  Future<void> _waitForInitialization() async {
    await Future.wait([
      appUsageDataController.initializationComplete,
    ]);

    // Increment usage count after initialization is complete
    appUsageDataController.incrementUsageCount();

    updateViewState();
  }

  void updateViewState() {
    emit(
      state.copyWith(
        themeMode: preferencesDataController.state.themeMode,
        isLoading: !appUsageDataController.isInitialized.value,
      ),
    );
  }
}
