import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AppViewState extends Equatable {
  final ThemeMode themeMode;
  final bool isLoading;

  const AppViewState({required this.themeMode, required this.isLoading});

  @override
  List<Object> get props => [themeMode, isLoading];

  AppViewState copyWith({ThemeMode? themeMode, bool? isLoading}) {
    return AppViewState(
      themeMode: themeMode ?? this.themeMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

const defaultAppViewState = AppViewState(
  themeMode: ThemeMode.light,
  isLoading: true,
);
