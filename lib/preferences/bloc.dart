import 'package:app/local-store/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const defaultThemeMode = ThemeMode.light;

@immutable
class PreferencesState extends Equatable {
  final ThemeMode themeMode;

  const PreferencesState({
    required this.themeMode,
  });

  @override
  List<Object?> get props => [
        themeMode,
      ];
}

const _themeModeKey = 'themeMode';

Map<String, dynamic> preferencesStateToMap(PreferencesState preferencesState) {
  return {
    _themeModeKey: preferencesState.themeMode.index,
  };
}

PreferencesState preferencesStateFromMap(Map<String, dynamic> map) {
  final themeModeIndex = map[_themeModeKey] as int? ?? defaultThemeMode.index;
  return PreferencesState(
    themeMode: ThemeMode.values[themeModeIndex],
  );
}

const preferencesStoreName = 'preferences';

class PreferencesBloc extends Cubit<PreferencesState> {
  factory PreferencesBloc.fromContext(BuildContext context) {
    return PreferencesBloc(
      context.read<LocalStoreBloc>(),
    );
  }

  final LocalStoreBloc _localStoreBloc;

  PreferencesBloc(
    this._localStoreBloc,
  ) : super(
          const PreferencesState(
            themeMode: defaultThemeMode,
          ),
        ) {
    _init();
  }

  Future<void> _init() async {
    await _load();
  }

  void toggleThemeMode() {
    setThemeMode(
      state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    );
  }

  void setThemeMode(ThemeMode mode) {
    emit(
      PreferencesState(
        themeMode: mode,
      ),
    );
    _save();
  }

  Future<void> _load() async {
    final map = await _localStoreBloc.load(preferencesStoreName);
    emit(
      preferencesStateFromMap(map),
    );
  }

  Future<void> _save() async {
    await _localStoreBloc.save(
      preferencesStoreName,
      preferencesStateToMap(state),
    );
  }
}
