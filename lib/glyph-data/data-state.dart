import 'package:app/glyph-data/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';

@immutable
class GlyphsDataState extends Equatable {
  final IList<Glyph> emoji;
  final IList<Glyph> symbols;
  final IList<Glyph> kaomoji;
  final IMap<String, Glyph> allGlyphsMap;

  const GlyphsDataState({
    required this.emoji,
    required this.symbols,
    required this.kaomoji,
    required this.allGlyphsMap,
  });

  @override
  List<Object> get props => [
    emoji,
    symbols,
    kaomoji,
    allGlyphsMap,
  ];
}

const defaultGlyphsDataState = GlyphsDataState(
  emoji: IList.empty(),
  symbols: IList.empty(),
  kaomoji: IList.empty(),
  allGlyphsMap: IMap.empty(),
);
