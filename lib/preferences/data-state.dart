import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class PreferencesDataState extends Equatable {
  final ThemeMode themeMode;

  const PreferencesDataState({
    required this.themeMode,
  });

  @override
  List<Object> get props => [
    themeMode,
  ];

  PreferencesDataState copyWith({
    ThemeMode? themeMode,
  }) {
    return PreferencesDataState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  factory PreferencesDataState.initial() {
    return const PreferencesDataState(
      themeMode: ThemeMode.light,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'themeMode': themeMode.name,
    };
  }

  factory PreferencesDataState.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        'themeMode': final String themeMode,
      } =>
        PreferencesDataState(
          themeMode: ThemeMode.values.byName(themeMode),
        ),
      _ => PreferencesDataState.initial(),
    };
  }
}
