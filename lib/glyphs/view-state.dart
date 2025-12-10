import 'package:app/glyph-data/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

@immutable
class GlyphsViewState extends Equatable {
  final IList<GlyphGroupViewState> emoji;
  final IList<GlyphGroupViewState> symbols;
  final IList<GlyphGroupViewState> kaomoji;
  final IList<GlyphGroupViewState> favorites;
  final IList<GlyphGroupViewState> recentEmoji;
  final IList<GlyphGroupViewState> recentSymbols;
  final IList<GlyphGroupViewState> recentKaomoji;

  const GlyphsViewState({
    required this.emoji,
    required this.symbols,
    required this.kaomoji,
    required this.favorites,
    required this.recentEmoji,
    required this.recentSymbols,
    required this.recentKaomoji,
  });

  @override
  List<Object> get props => [
    emoji,
    symbols,
    kaomoji,
    favorites,
    recentEmoji,
    recentSymbols,
    recentKaomoji,
  ];

  GlyphsViewState copyWith({
    IList<GlyphGroupViewState>? emoji,
    IList<GlyphGroupViewState>? symbols,
    IList<GlyphGroupViewState>? kaomoji,
    IList<GlyphGroupViewState>? favorites,
    IList<GlyphGroupViewState>? recentEmoji,
    IList<GlyphGroupViewState>? recentSymbols,
    IList<GlyphGroupViewState>? recentKaomoji,
  }) {
    return GlyphsViewState(
      emoji: emoji ?? this.emoji,
      symbols: symbols ?? this.symbols,
      kaomoji: kaomoji ?? this.kaomoji,
      favorites: favorites ?? this.favorites,
      recentEmoji: recentEmoji ?? this.recentEmoji,
      recentSymbols: recentSymbols ?? this.recentSymbols,
      recentKaomoji: recentKaomoji ?? this.recentKaomoji,
    );
  }

  factory GlyphsViewState.initial() {
    return const GlyphsViewState(
      emoji: IList.empty(),
      symbols: IList.empty(),
      kaomoji: IList.empty(),
      favorites: IList.empty(),
      recentEmoji: IList.empty(),
      recentSymbols: IList.empty(),
      recentKaomoji: IList.empty(),
    );
  }
}

@immutable
class GlyphGroupViewState extends Equatable {
  final String title;
  final IList<Glyph> glyphs;

  const GlyphGroupViewState({
    required this.title,
    required this.glyphs,
  });

  @override
  List<Object> get props => [title, glyphs];

  GlyphGroupViewState copyWith({
    String? title,
    IList<Glyph>? glyphs,
  }) {
    return GlyphGroupViewState(
      title: title ?? this.title,
      glyphs: glyphs ?? this.glyphs,
    );
  }
}
