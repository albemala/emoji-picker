import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class AboutViewState extends Equatable {
  final String appVersion;

  const AboutViewState({required this.appVersion});

  @override
  List<Object> get props => [appVersion];

  AboutViewState copyWith({String? appVersion}) {
    return AboutViewState(
      appVersion: appVersion ?? this.appVersion,
    );
  }
}

const defaultAboutViewState = AboutViewState(
  appVersion: '',
);
