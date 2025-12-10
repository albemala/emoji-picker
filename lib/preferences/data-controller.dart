import 'package:app/preferences/data-state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_storage/flutter_data_storage.dart';

class PreferencesDataController extends StoredCubit<PreferencesDataState> {
  factory PreferencesDataController.fromContext(BuildContext context) {
    return PreferencesDataController();
  }

  PreferencesDataController() : super(PreferencesDataState.initial());

  @override
  Future<void> migrateData() async {}

  @override
  String get storeName => 'preferences';

  @override
  PreferencesDataState fromMap(Map<String, dynamic> json) {
    return PreferencesDataState.fromMap(json);
  }

  @override
  Map<String, dynamic> toMap(PreferencesDataState state) {
    return state.toMap();
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
}
