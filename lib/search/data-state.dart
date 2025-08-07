import 'package:app/glyph-data/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

@immutable
class SearchGlyphsDataState extends Equatable {
  final IList<Glyph> filteredEmoji;
  final IList<Glyph> filteredSymbols;
  final IList<Glyph> filteredKaomoji;
  final String searchQuery;

  const SearchGlyphsDataState({
    required this.filteredEmoji,
    required this.filteredSymbols,
    required this.filteredKaomoji,
    required this.searchQuery,
  });

  @override
  List<Object> get props => [
    filteredEmoji,
    filteredSymbols,
    filteredKaomoji,
    searchQuery,
  ];

  SearchGlyphsDataState copyWith({
    IList<Glyph>? filteredEmoji,
    IList<Glyph>? filteredSymbols,
    IList<Glyph>? filteredKaomoji,
    String? searchQuery,
  }) {
    return SearchGlyphsDataState(
      filteredEmoji: filteredEmoji ?? this.filteredEmoji,
      filteredSymbols: filteredSymbols ?? this.filteredSymbols,
      filteredKaomoji: filteredKaomoji ?? this.filteredKaomoji,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

const defaultSearchGlyphsDataState = SearchGlyphsDataState(
  filteredEmoji: IList.empty(),
  filteredSymbols: IList.empty(),
  filteredKaomoji: IList.empty(),
  searchQuery: '',
);
