import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class AppContentViewState extends Equatable {
  const AppContentViewState();

  @override
  List<Object> get props => [];

  AppContentViewState copyWith() {
    return const AppContentViewState();
  }
}

const defaultAppContentViewState = AppContentViewState();
