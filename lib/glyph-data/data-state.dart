import 'package:app/glyph-data/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';

@immutable
class GlyphsDataState extends Equatable {
  final IList<Glyph> emoji;
  final IList<Glyph> symbols;
  final IList<Glyph> kaomoji;

  const GlyphsDataState({
    required this.emoji,
    required this.symbols,
    required this.kaomoji,
  });

  @override
  List<Object> get props => [
        emoji,
        symbols,
        kaomoji,
      ];
}

const defaultGlyphsDataState = GlyphsDataState(
  emoji: IList.empty(),
  symbols: IList.empty(),
  kaomoji: IList.empty(),
);
