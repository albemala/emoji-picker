import 'package:app/glyph-data/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

@immutable
class SearchGlyphsDataState extends Equatable {
  final String searchQuery;
  final IList<Glyph> filteredEmoji;
  final IList<Glyph> filteredSymbols;
  final IList<Glyph> filteredKaomoji;
  final IList<Glyph> filteredFavorites;
  final IList<Glyph> filteredRecentEmoji;
  final IList<Glyph> filteredRecentSymbols;
  final IList<Glyph> filteredRecentKaomoji;

  const SearchGlyphsDataState({
    required this.searchQuery,
    required this.filteredEmoji,
    required this.filteredSymbols,
    required this.filteredKaomoji,
    required this.filteredFavorites,
    required this.filteredRecentEmoji,
    required this.filteredRecentSymbols,
    required this.filteredRecentKaomoji,
  });

  @override
  List<Object> get props => [
    searchQuery,
    filteredEmoji,
    filteredSymbols,
    filteredKaomoji,
    filteredFavorites,
    filteredRecentEmoji,
    filteredRecentSymbols,
    filteredRecentKaomoji,
  ];

  SearchGlyphsDataState copyWith({
    String? searchQuery,
    IList<Glyph>? filteredEmoji,
    IList<Glyph>? filteredSymbols,
    IList<Glyph>? filteredKaomoji,
    IList<Glyph>? filteredFavorites,
    IList<Glyph>? filteredRecentEmoji,
    IList<Glyph>? filteredRecentSymbols,
    IList<Glyph>? filteredRecentKaomoji,
  }) {
    return SearchGlyphsDataState(
      searchQuery: searchQuery ?? this.searchQuery,
      filteredEmoji: filteredEmoji ?? this.filteredEmoji,
      filteredSymbols: filteredSymbols ?? this.filteredSymbols,
      filteredKaomoji: filteredKaomoji ?? this.filteredKaomoji,
      filteredFavorites: filteredFavorites ?? this.filteredFavorites,
      filteredRecentEmoji: filteredRecentEmoji ?? this.filteredRecentEmoji,
      filteredRecentSymbols:
          filteredRecentSymbols ?? this.filteredRecentSymbols,
      filteredRecentKaomoji:
          filteredRecentKaomoji ?? this.filteredRecentKaomoji,
    );
  }
}

const defaultSearchGlyphsDataState = SearchGlyphsDataState(
  searchQuery: '',
  filteredEmoji: IList.empty(),
  filteredSymbols: IList.empty(),
  filteredKaomoji: IList.empty(),
  filteredFavorites: IList.empty(),
  filteredRecentEmoji: IList.empty(),
  filteredRecentSymbols: IList.empty(),
  filteredRecentKaomoji: IList.empty(),
);
