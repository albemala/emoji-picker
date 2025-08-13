import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

@immutable
class RecentGlyphEntry extends Equatable {
  final String glyph;
  final DateTime timestamp;

  const RecentGlyphEntry({
    required this.glyph,
    required this.timestamp,
  });

  @override
  List<Object> get props => [glyph, timestamp];

  Map<String, dynamic> toMap() {
    return {
      'glyph': glyph,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory RecentGlyphEntry.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        'glyph': final String glyph,
        'timestamp': final int timestamp,
      } =>
        RecentGlyphEntry(
          glyph: glyph,
          timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
        ),
      _ => defaultRecentGlyphEntry,
    };
  }
}

final defaultRecentGlyphEntry = RecentGlyphEntry(
  glyph: '',
  timestamp: DateTime.fromMillisecondsSinceEpoch(0),
);

@immutable
class RecentDataState extends Equatable {
  final IList<RecentGlyphEntry> recentGlyphs;

  const RecentDataState({
    required this.recentGlyphs,
  });

  @override
  List<Object> get props => [recentGlyphs];

  RecentDataState copyWith({
    IList<RecentGlyphEntry>? recentGlyphs,
  }) {
    return RecentDataState(
      recentGlyphs: recentGlyphs ?? this.recentGlyphs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recentGlyphs': recentGlyphs.map((entry) => entry.toMap()).toList(),
    };
  }

  factory RecentDataState.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        'recentGlyphs': final List<dynamic> recentGlyphs,
      } =>
        RecentDataState(
          recentGlyphs:
              recentGlyphs
                  .cast<Map<String, dynamic>>()
                  .map(RecentGlyphEntry.fromMap)
                  .toIList(),
        ),
      _ => defaultRecentDataState,
    };
  }
}

final defaultRecentDataState = RecentDataState(recentGlyphs: IList());
