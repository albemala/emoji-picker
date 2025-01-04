import 'dart:async';

import 'package:app/app/view-state.dart';
import 'package:app/preferences/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppViewController extends Cubit<AppViewState> {
  final PreferencesBloc preferencesBloc;

  StreamSubscription<PreferencesState>? preferencesBlocSubscription;

  factory AppViewController.fromContext(BuildContext context) {
    return AppViewController(
      context.read<PreferencesBloc>(),
    );
  }

  AppViewController(
    this.preferencesBloc,
  ) : super(defaultAppViewState) {
    preferencesBlocSubscription = preferencesBloc.stream.listen((_) {
      updateViewState();
    });
    updateViewState();
  }

  @override
  Future<void> close() {
    preferencesBlocSubscription?.cancel();
    return super.close();
  }

  void updateViewState() {
    emit(
      state.copyWith(
        themeMode: preferencesBloc.state.themeMode,
      ),
    );
  }
}
