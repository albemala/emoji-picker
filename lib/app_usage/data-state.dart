import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class AppUsageDataState extends Equatable {
  final int usageCount;
  final int glyphCopiedCount;

  const AppUsageDataState({
    required this.usageCount,
    required this.glyphCopiedCount,
  });

  @override
  List<Object> get props => [usageCount, glyphCopiedCount];

  AppUsageDataState copyWith({
    int? usageCount,
    int? glyphCopiedCount,
  }) {
    return AppUsageDataState(
      usageCount: usageCount ?? this.usageCount,
      glyphCopiedCount: glyphCopiedCount ?? this.glyphCopiedCount,
    );
  }

  factory AppUsageDataState.initial() {
    return const AppUsageDataState(
      usageCount: 0,
      glyphCopiedCount: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'usageCount': usageCount,
      'glyphCopiedCount': glyphCopiedCount,
    };
  }

  factory AppUsageDataState.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        'usageCount': final int usageCount,
        'glyphCopiedCount': final int glyphCopiedCount,
      } =>
        AppUsageDataState(
          usageCount: usageCount,
          glyphCopiedCount: glyphCopiedCount,
        ),
      {'usageCount': final int usageCount} => AppUsageDataState(
        usageCount: usageCount,
        glyphCopiedCount: 0,
      ),
      _ => AppUsageDataState.initial(),
    };
  }
}
