import 'dart:async';

import 'package:app/app/view-state.dart';
import 'package:app/preferences/data-controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppViewController extends Cubit<AppViewState> {
  final PreferencesDataController preferencesDataController;
  StreamSubscription<void>? preferencesDataControllerSubscription;

  factory AppViewController.fromContext(BuildContext context) {
    return AppViewController(context.read<PreferencesDataController>());
  }

  AppViewController(this.preferencesDataController)
    : super(defaultAppViewState) {
    preferencesDataControllerSubscription = preferencesDataController.stream
        .listen((_) {
          updateViewState();
        });
    updateViewState();
  }

  @override
  Future<void> close() {
    preferencesDataControllerSubscription?.cancel();
    return super.close();
  }

  void updateViewState() {
    emit(state.copyWith(themeMode: preferencesDataController.state.themeMode));
  }
}
