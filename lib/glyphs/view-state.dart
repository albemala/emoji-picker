import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/widgets/ads.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

@immutable
class GlyphsViewState extends Equatable {
  final IList<GlyphGroupViewState> emoji;
  final IList<GlyphGroupViewState> symbols;
  final IList<GlyphGroupViewState> kaomoji;

  const GlyphsViewState({
    required this.emoji,
    required this.symbols,
    required this.kaomoji,
  });

  @override
  List<Object> get props => [emoji, symbols, kaomoji];

  GlyphsViewState copyWith({
    IList<GlyphGroupViewState>? emoji,
    IList<GlyphGroupViewState>? symbols,
    IList<GlyphGroupViewState>? kaomoji,
  }) {
    return GlyphsViewState(
      emoji: emoji ?? this.emoji,
      symbols: symbols ?? this.symbols,
      kaomoji: kaomoji ?? this.kaomoji,
    );
  }
}

@immutable
class GlyphGroupViewState extends Equatable {
  final String title;
  final IList<Glyph> glyphs;
  final AdType ad;

  const GlyphGroupViewState({
    required this.title,
    required this.glyphs,
    required this.ad,
  });

  @override
  List<Object> get props => [title, glyphs, ad];

  GlyphGroupViewState copyWith({
    String? title,
    IList<Glyph>? glyphs,
    AdType? ad,
  }) {
    return GlyphGroupViewState(
      title: title ?? this.title,
      glyphs: glyphs ?? this.glyphs,
      ad: ad ?? this.ad,
    );
  }
}

const defaultGlyphsViewState = GlyphsViewState(
  emoji: IList.empty(),
  symbols: IList.empty(),
  kaomoji: IList.empty(),
);
