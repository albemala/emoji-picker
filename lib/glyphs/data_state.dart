import 'package:app/glyphs/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class GlyphsState extends Equatable {
  final Iterable<Glyph> emoji;
  final Iterable<Glyph> symbols;
  final Iterable<Glyph> kaomoji;

  const GlyphsState({
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
