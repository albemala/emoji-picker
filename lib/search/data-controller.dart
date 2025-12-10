import 'dart:async';

import 'package:app/favorites/data-controller.dart';
import 'package:app/glyph-data/data-controller.dart';
import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/recent/data-controller.dart';
import 'package:app/search/data-state.dart';
import 'package:app/search/functions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchGlyphsDataController extends Cubit<SearchGlyphsDataState> {
  final GlyphsDataController glyphsDataController;
  final FavoritesDataController favoritesDataController;
  final RecentDataController recentDataController;

  StreamSubscription<void>? glyphsDataControllerSubscription;
  StreamSubscription<void>? favoritesDataControllerSubscription;
  StreamSubscription<void>? recentDataControllerSubscription;

  final focusNode = FocusNode();

  factory SearchGlyphsDataController.fromContext(BuildContext context) {
    return SearchGlyphsDataController(
      context.read<GlyphsDataController>(),
      context.read<FavoritesDataController>(),
      context.read<RecentDataController>(),
    );
  }

  SearchGlyphsDataController(
    this.glyphsDataController,
    this.favoritesDataController,
    this.recentDataController,
  ) : super(SearchGlyphsDataState.initial()) {
    glyphsDataControllerSubscription = glyphsDataController.stream.listen((_) {
      updateFilteredData();
    });
    favoritesDataControllerSubscription = favoritesDataController.stream.listen(
      (_) {
        updateFilteredData();
      },
    );
    recentDataControllerSubscription = recentDataController.stream.listen(
      (_) {
        updateFilteredData();
      },
    );
    updateFilteredData();
  }

  @override
  Future<void> close() {
    glyphsDataControllerSubscription?.cancel();
    favoritesDataControllerSubscription?.cancel();
    recentDataControllerSubscription?.cancel();
    return super.close();
  }

  void setSearchQuery(String value) {
    emit(state.copyWith(searchQuery: value));
    updateFilteredData();
  }

  void updateFilteredData() {
    bool test(Glyph glyph) => matchesSearchTerm(glyph, state.searchQuery);

    final glyphData = glyphsDataController.state;
    final filteredEmoji = state.searchQuery.isEmpty
        ? glyphData.emoji
        : glyphData.emoji.where(test).toIList();
    final filteredSymbols = state.searchQuery.isEmpty
        ? glyphData.symbols
        : glyphData.symbols.where(test).toIList();
    final filteredKaomoji = state.searchQuery.isEmpty
        ? glyphData.kaomoji
        : glyphData.kaomoji.where(test).toIList();

    // Step 1: Lookup - Convert glyph strings to actual Glyph objects using map lookups
    final favoriteGlyphStrings = favoritesDataController.state.favoriteGlyphs;
    final recentGlyphStrings = recentDataController.getRecentGlyphStrings();

    final favoriteGlyphs = favoriteGlyphStrings
        .map((glyphString) => glyphData.allGlyphsMap[glyphString])
        .whereType<Glyph>() // Filter out nulls
        .toIList();

    final recentGlyphs = recentGlyphStrings
        .map((glyphString) => glyphData.allGlyphsMap[glyphString])
        .whereType<Glyph>() // Filter out nulls
        .toIList();

    // Step 2: Categorize recent glyphs by type
    final recentEmoji = recentGlyphs
        .where((g) => g.type == GlyphType.emoji)
        .toIList();
    final recentSymbols = recentGlyphs
        .where((g) => g.type == GlyphType.symbol)
        .toIList();
    final recentKaomoji = recentGlyphs
        .where((g) => g.type == GlyphType.kaomoji)
        .toIList();

    // Step 3: Apply search query filtering using consistent where pattern
    final filteredFavorites = state.searchQuery.isEmpty
        ? favoriteGlyphs
        : favoriteGlyphs.where(test).toIList();

    final filteredRecentEmoji = state.searchQuery.isEmpty
        ? recentEmoji
        : recentEmoji.where(test).toIList();

    final filteredRecentSymbols = state.searchQuery.isEmpty
        ? recentSymbols
        : recentSymbols.where(test).toIList();

    final filteredRecentKaomoji = state.searchQuery.isEmpty
        ? recentKaomoji
        : recentKaomoji.where(test).toIList();

    emit(
      state.copyWith(
        filteredEmoji: filteredEmoji,
        filteredSymbols: filteredSymbols,
        filteredKaomoji: filteredKaomoji,
        filteredFavorites: filteredFavorites.toIList(),
        filteredRecentEmoji: filteredRecentEmoji.toIList(),
        filteredRecentSymbols: filteredRecentSymbols.toIList(),
        filteredRecentKaomoji: filteredRecentKaomoji.toIList(),
      ),
    );
  }
}
