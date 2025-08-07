import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AppViewState extends Equatable {
  final ThemeMode themeMode;

  const AppViewState({required this.themeMode});

  @override
  List<Object> get props => [themeMode];

  AppViewState copyWith({ThemeMode? themeMode}) {
    return AppViewState(themeMode: themeMode ?? this.themeMode);
  }
}

const defaultAppViewState = AppViewState(themeMode: ThemeMode.light);
