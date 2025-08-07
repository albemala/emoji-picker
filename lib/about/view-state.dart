import 'package:app/widgets/ads.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class AboutViewState extends Equatable {
  final String appVersion;
  final AdType adType;

  const AboutViewState({required this.appVersion, this.adType = AdType.none});

  @override
  List<Object> get props => [appVersion, adType];

  AboutViewState copyWith({String? appVersion, AdType? adType}) {
    return AboutViewState(
      appVersion: appVersion ?? this.appVersion,
      adType: adType ?? this.adType,
    );
  }
}

const defaultAboutViewState = AboutViewState(
  appVersion: '',
  adType: AdType.none,
);
