import 'dart:async';

import 'package:app/local-store/bloc.dart';
import 'package:app/preferences/data-state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferencesDataController extends Cubit<PreferencesDataState> {
  final LocalStoreDataController localStoreDataController;

  StreamSubscription<void>? selfSubscription;

  factory PreferencesDataController.fromContext(BuildContext context) {
    return PreferencesDataController(context.read<LocalStoreDataController>());
  }

  PreferencesDataController(this.localStoreDataController)
    : super(defaultPreferencesDataState) {
    _init();
  }

  Future<void> _init() async {
    await load();
    selfSubscription = stream.listen((_) {
      save();
    });
  }

  @override
  Future<void> close() {
    selfSubscription?.cancel();
    return super.close();
  }

  ThemeMode get themeMode => state.themeMode;
  set themeMode(ThemeMode mode) => emit(state.copyWith(themeMode: mode));

  void toggleThemeMode() {
    themeMode =
        themeMode ==
                ThemeMode
                    .light //
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static const storeName = 'preferences';

  Future<void> load() async {
    final map = await localStoreDataController.load(storeName);
    emit(PreferencesDataState.fromMap(map));
  }

  Future<void> save() async {
    await localStoreDataController.save(storeName, state.toMap());
  }
}
