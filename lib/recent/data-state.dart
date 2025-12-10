import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

@immutable
class RecentGlyphEntry extends Equatable {
  final String glyph;
  final DateTime timestamp;

  RecentGlyphEntry({
    required this.glyph,
    required this.timestamp,
  });

  factory RecentGlyphEntry.initial() {
    return RecentGlyphEntry(
      glyph: '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

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
      _ => RecentGlyphEntry.initial(),
    };
  }
}

@immutable
class RecentDataState extends Equatable {
  final IList<RecentGlyphEntry> recentGlyphs;

  RecentDataState({
    required this.recentGlyphs,
  });

  factory RecentDataState.initial() {
    return RecentDataState(recentGlyphs: IList());
  }

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
          recentGlyphs: recentGlyphs
              .cast<Map<String, dynamic>>()
              .map(RecentGlyphEntry.fromMap)
              .toIList(),
        ),
      _ => RecentDataState.initial(),
    };
  }
}
