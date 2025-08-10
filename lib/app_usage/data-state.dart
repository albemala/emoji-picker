import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class AppUsageDataState extends Equatable {
  final int usageCount;

  const AppUsageDataState({required this.usageCount});

  @override
  List<Object> get props => [usageCount];

  AppUsageDataState copyWith({int? usageCount}) {
    return AppUsageDataState(usageCount: usageCount ?? this.usageCount);
  }

  Map<String, dynamic> toMap() {
    return {'usageCount': usageCount};
  }

  factory AppUsageDataState.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {'usageCount': final int usageCount} => AppUsageDataState(
        usageCount: usageCount,
      ),
      _ => defaultAppUsageDataState,
    };
  }
}

const defaultAppUsageDataState = AppUsageDataState(usageCount: 0);
