import 'package:app/glyphs/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class GlyphsDataState extends Equatable {
  final Iterable<Glyph> emoji;
  final Iterable<Glyph> symbols;
  final Iterable<Glyph> kaomoji;

  const GlyphsDataState({
    required this.emoji,
    required this.symbols,
    required this.kaomoji,
  });

  @override
  List<Object?> get props => [
        emoji,
        symbols,
        kaomoji,
      ];
}

const defaultGlyphsDataState = GlyphsDataState(
  emoji: [],
  symbols: [],
  kaomoji: [],
);
