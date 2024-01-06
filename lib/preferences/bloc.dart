import 'package:app/local-store/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/flutter_state_management.dart';

class PreferencesConductor extends StorableConductor {
  factory PreferencesConductor.fromContext(BuildContext context) {
    return PreferencesConductor(
      ConductorStorage(
        context.getConductor<LocalStorageConductor>(),
      ),
    );
  }

  @override
  final ConductorStorage storage;

  final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);

  PreferencesConductor(this.storage) {
    _init();
  }

  Future<void> _init() async {
    await load();
    themeMode.addListener(_updateAndSave);
  }

  @override
  void dispose() {
    themeMode.removeListener(_updateAndSave);
    themeMode.dispose();
  }

  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
  }

  void toggleThemeMode() {
    themeMode.value = themeMode.value == ThemeMode.light //
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  void _updateAndSave() {
    save();
  }

  @override
  String get storeName => 'preferences';

  static const _themeModeKey = 'themeMode';

  @override
  Map<String, dynamic> toMap() {
    return {
      _themeModeKey: themeMode.value.index,
    };
  }

  @override
  void fromMap(Map<String, dynamic> map) {
    final themeModeIndex = map[_themeModeKey] as int? ?? ThemeMode.light.index;
    themeMode.value = ThemeMode.values[themeModeIndex];
  }
}
