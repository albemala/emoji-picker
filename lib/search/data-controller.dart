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
  ) : super(defaultSearchGlyphsDataState) {
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
    final filteredEmoji =
        state.searchQuery.isEmpty
            ? glyphData.emoji
            : glyphData.emoji.where(test).toIList();
    final filteredSymbols =
        state.searchQuery.isEmpty
            ? glyphData.symbols
            : glyphData.symbols.where(test).toIList();
    final filteredKaomoji =
        state.searchQuery.isEmpty
            ? glyphData.kaomoji
            : glyphData.kaomoji.where(test).toIList();

    final favoriteGlyphStrings = favoritesDataController.state.favoriteGlyphs;
    bool isFavorite(Glyph g) => favoriteGlyphStrings.contains(g.glyph);

    final filteredFavorites =
        [
          ...filteredEmoji.where(isFavorite),
          ...filteredSymbols.where(isFavorite),
          ...filteredKaomoji.where(isFavorite),
        ].toIList();

    // Filter recent glyphs by type and search query
    final recentGlyphStrings = recentDataController.getRecentGlyphStrings();
    bool isRecent(Glyph g) => recentGlyphStrings.contains(g.glyph);

    final filteredRecentEmoji =
        state.searchQuery.isEmpty
            ? filteredEmoji.where(isRecent).toIList()
            : filteredEmoji.where((g) => isRecent(g) && test(g)).toIList();
    final filteredRecentSymbols =
        state.searchQuery.isEmpty
            ? filteredSymbols.where(isRecent).toIList()
            : filteredSymbols.where((g) => isRecent(g) && test(g)).toIList();
    final filteredRecentKaomoji =
        state.searchQuery.isEmpty
            ? filteredKaomoji.where(isRecent).toIList()
            : filteredKaomoji.where((g) => isRecent(g) && test(g)).toIList();

    emit(
      state.copyWith(
        filteredEmoji: filteredEmoji,
        filteredSymbols: filteredSymbols,
        filteredKaomoji: filteredKaomoji,
        filteredFavorites: filteredFavorites,
        filteredRecentEmoji: filteredRecentEmoji,
        filteredRecentSymbols: filteredRecentSymbols,
        filteredRecentKaomoji: filteredRecentKaomoji,
      ),
    );
  }
}
