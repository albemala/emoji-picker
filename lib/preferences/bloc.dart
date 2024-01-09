import 'package:app/local-store/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bloc.g.dart';

const defaultThemeMode = ThemeMode.light;

@JsonSerializable()
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

  factory PreferencesState.fromJson(Map<String, dynamic> json) {
    return _$PreferencesStateFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PreferencesStateToJson(this);
  }
}

class PreferencesBloc extends Cubit<PreferencesState> {
  final LocalStoreBloc _localStoreBloc;

  factory PreferencesBloc.fromContext(BuildContext context) {
    return PreferencesBloc(
      context.read<LocalStoreBloc>(),
    );
  }

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
      state.themeMode == ThemeMode.light //
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }

  void setThemeMode(ThemeMode themeMode) {
    _updateStateAndSave(
      themeMode: themeMode,
    );
  }

  void _updateStateAndSave({
    ThemeMode? themeMode,
  }) {
    emit(
      PreferencesState(
        themeMode: themeMode ?? state.themeMode,
      ),
    );
    _save();
  }

  static const storeName = 'preferences';

  Future<void> _load() async {
    final map = await _localStoreBloc.load(storeName);
    emit(
      PreferencesState.fromJson(map),
    );
  }

  Future<void> _save() async {
    await _localStoreBloc.save(
      storeName,
      state.toJson(),
    );
  }
}
