import 'dart:async';

import 'package:app/local-store/bloc.dart';
import 'package:app/preferences/data-state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferencesDataController extends Cubit<PreferencesDataState> {
  final LocalStoreDataController _localStoreDataController;

  StreamSubscription<void>? _selfSubscription;

  factory PreferencesDataController.fromContext(BuildContext context) {
    return PreferencesDataController(
      context.read<LocalStoreDataController>(),
    );
  }

  PreferencesDataController(
    this._localStoreDataController,
  ) : super(defaultPreferencesDataState) {
    _init();
  }

  Future<void> _init() async {
    await _load();
    _selfSubscription = stream.listen((_) {
      _save();
    });
  }

  @override
  Future<void> close() {
    _selfSubscription?.cancel();
    return super.close();
  }

  ThemeMode get themeMode => state.themeMode;
  set themeMode(ThemeMode mode) => emit(state.copyWith(themeMode: mode));

  void toggleThemeMode() {
    themeMode == ThemeMode.light //
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  static const storeName = 'preferences';

  Future<void> _load() async {
    final map = await _localStoreDataController.load(storeName);
    emit(
      PreferencesDataState.fromMap(map),
    );
  }

  Future<void> _save() async {
    await _localStoreDataController.save(
      storeName,
      state.toMap(),
    );
  }
}
