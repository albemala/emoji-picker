import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class AboutViewState extends Equatable {
  final String appVersion;

  const AboutViewState({required this.appVersion});

  factory AboutViewState.initial() {
    return const AboutViewState(
      appVersion: '',
    );
  }

  @override
  List<Object> get props => [appVersion];

  AboutViewState copyWith({String? appVersion}) {
    return AboutViewState(
      appVersion: appVersion ?? this.appVersion,
    );
  }
}
