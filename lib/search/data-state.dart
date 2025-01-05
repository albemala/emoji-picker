import 'package:app/glyphs/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

@immutable
class SearchGlyphsDataState extends Equatable {
  final IList<Glyph> filteredEmoji;
  final IList<Glyph> filteredSymbols;
  final IList<Glyph> filteredKaomoji;

  const SearchGlyphsDataState({
    required this.filteredEmoji,
    required this.filteredSymbols,
    required this.filteredKaomoji,
  });

  @override
  List<Object> get props => [
        filteredEmoji,
        filteredSymbols,
        filteredKaomoji,
      ];
}

const defaultSearchGlyphsDataState = SearchGlyphsDataState(
  filteredEmoji: IList.empty(),
  filteredSymbols: IList.empty(),
  filteredKaomoji: IList.empty(),
);
