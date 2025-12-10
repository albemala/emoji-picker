import 'package:app/about/view-state.dart';
import 'package:app/about/view.dart';
import 'package:app/app-content/view-state.dart';
import 'package:app/app-content/view.dart';
import 'package:app/favorites/data-controller.dart';
import 'package:app/favorites/data-state.dart';
import 'package:app/glyph-data/data-controller.dart';
import 'package:app/glyph-data/data-state.dart';
import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-data/functions.dart';
import 'package:app/glyph-details/dialog.dart';
import 'package:app/recent/data-controller.dart';
import 'package:app/recent/data-state.dart';
import 'package:app/search/data-controller.dart';
import 'package:app/search/data-state.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:app/selected-glyph/data-state.dart';
import 'package:app/selected-tab/data-controller.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controllers.dart';
import 'views.dart';

Future<List<ScreenshotData>> createScreenshotData() async {
  final emoji = await loadEmoji();
  final symbols = await loadSymbols();
  final kaomoji = await loadKaomoji();
  return [
    createAboutViewScreenshotData(),

    // Glyph Details Screenshots
    createGlyphDetailsScreenshotData(
      selectedGlyph: emoji[2],
      fileName: 'glyph_details_emoji',
    ),
    createGlyphDetailsScreenshotData(
      selectedGlyph: symbols.where((e) => e.glyph == '&').first,
      fileName: 'glyph_details_symbol',
    ),
    createGlyphDetailsScreenshotData(
      selectedGlyph: kaomoji[0],
      fileName: 'glyph_details_kaomoji',
      isFavorite: true,
    ),

    // App Content View Screenshots
    createAppContentViewScreenshotData(
      fileName: 'app_content_view_emoji',
      selectedTabIndex: 0,
      emoji: emoji.take(20).toList(),
      symbols: symbols.take(20).toList(),
      kaomoji: kaomoji.take(10).toList(),
      favorites: [emoji[1], symbols[5], kaomoji[2]],
      recentEmoji: emoji.take(5).toList(),
      recentSymbols: symbols.take(5).toList(),
      recentKaomoji: kaomoji.take(3).toList(),
      selectedGlyph: emoji[0],
    ),
    createAppContentViewScreenshotData(
      fileName: 'app_content_view_symbols',
      selectedTabIndex: 1,
      emoji: emoji.take(20).toList(),
      symbols: symbols.take(20).toList(),
      kaomoji: kaomoji.take(10).toList(),
      favorites: [emoji[1], symbols[5], kaomoji[2]],
      recentEmoji: emoji.take(5).toList(),
      recentSymbols: symbols.take(5).toList(),
      recentKaomoji: kaomoji.take(3).toList(),
      selectedGlyph: symbols[0],
    ),
    createAppContentViewScreenshotData(
      fileName: 'app_content_view_kaomoji',
      selectedTabIndex: 2,
      emoji: emoji.take(20).toList(),
      symbols: symbols.take(20).toList(),
      kaomoji: kaomoji.take(10).toList(),
      favorites: [emoji[1], symbols[5], kaomoji[2]],
      recentEmoji: emoji.take(5).toList(),
      recentSymbols: symbols.take(5).toList(),
      recentKaomoji: kaomoji.take(3).toList(),
      selectedGlyph: kaomoji[0],
    ),
    createAppContentViewScreenshotData(
      fileName: 'app_content_view_favorites',
      selectedTabIndex: 3,
      emoji: emoji.take(20).toList(),
      symbols: symbols.take(20).toList(),
      kaomoji: kaomoji.take(10).toList(),
      favorites: [emoji[1], symbols[5], kaomoji[2]],
      recentEmoji: emoji.take(5).toList(),
      recentSymbols: symbols.take(5).toList(),
      recentKaomoji: kaomoji.take(3).toList(),
      selectedGlyph: emoji[1],
    ),
  ];
}

ScreenshotData createAboutViewScreenshotData() {
  return ScreenshotData(
    view: ScreenshotDialogView(
      child: AboutView(
        controller: MockAboutViewController(),
        state: const AboutViewState(appVersion: '4.0.0'),
      ),
    ),
    fileName: 'about_view',
  );
}

ScreenshotData createGlyphDetailsScreenshotData({
  required Glyph selectedGlyph,
  required String fileName,
  bool isFavorite = false,
}) {
  final selectedGlyphController = MockSelectedGlyphDataController(
    initialState: SelectedGlyphDataState.initial().copyWith(
      selectedGlyph: selectedGlyph,
    ),
  );

  final favoritesController = MockFavoritesDataController(
    initialState: FavoritesDataState.initial().copyWith(
      favoriteGlyphs: isFavorite ? IList([selectedGlyph.glyph]) : IList(),
    ),
  );

  return ScreenshotData(
    view: MultiBlocProvider(
      providers: [
        BlocProvider<SelectedGlyphDataController>.value(
          value: selectedGlyphController,
        ),
        BlocProvider<FavoritesDataController>.value(
          value: favoritesController,
        ),
      ],
      child: const GlyphDetailsDialog(),
    ),
    fileName: fileName,
  );
}

ScreenshotData createAppContentViewScreenshotData({
  required String fileName,
  required int selectedTabIndex,
  required List<Glyph> emoji,
  required List<Glyph> symbols,
  required List<Glyph> kaomoji,
  required List<Glyph> favorites,
  required List<Glyph> recentEmoji,
  required List<Glyph> recentSymbols,
  required List<Glyph> recentKaomoji,
  String searchQuery = '',
  required Glyph selectedGlyph,
}) {
  // Create recent glyph entries with timestamps
  List<RecentGlyphEntry> mapGlyphsToRecentEntries(List<Glyph> glyphs) {
    return glyphs
        .map(
          (glyph) => RecentGlyphEntry(
            glyph: glyph.glyph,
            timestamp: DateTime.now().subtract(
              Duration(minutes: glyphs.indexOf(glyph)),
            ),
          ),
        )
        .toList();
  }

  final recentEmojiEntries = mapGlyphsToRecentEntries(recentEmoji);
  final recentSymbolsEntries = mapGlyphsToRecentEntries(recentSymbols);
  final recentKaomojiEntries = mapGlyphsToRecentEntries(recentKaomoji);

  // Create mock controllers
  final allGlyphs = [
    ...emoji,
    ...symbols,
    ...kaomoji,
  ];
  final allGlyphsMap = <String, Glyph>{
    for (final glyph in allGlyphs) glyph.glyph: glyph,
  }.toIMap();

  final glyphsDataController = MockGlyphsDataController(
    initialState: GlyphsDataState(
      emoji: emoji.toIList(),
      symbols: symbols.toIList(),
      kaomoji: kaomoji.toIList(),
      allGlyphsMap: allGlyphsMap,
    ),
  );

  final favoritesDataController = MockFavoritesDataController(
    initialState: FavoritesDataState.initial().copyWith(
      favoriteGlyphs: favorites.map((glyph) => glyph.glyph).toIList(),
    ),
  );

  final recentDataController = MockRecentDataController(
    initialState: RecentDataState.initial().copyWith(
      recentGlyphs: [
        ...recentEmojiEntries,
        ...recentSymbolsEntries,
        ...recentKaomojiEntries,
      ].toIList(),
    ),
  );

  final searchGlyphsDataController = MockSearchGlyphsDataController(
    initialState: SearchGlyphsDataState.initial().copyWith(
      searchQuery: searchQuery,
      filteredEmoji: emoji.toIList(),
      filteredSymbols: symbols.toIList(),
      filteredKaomoji: kaomoji.toIList(),
      filteredFavorites: favorites.toIList(),
      filteredRecentEmoji: recentEmoji.toIList(),
      filteredRecentSymbols: recentSymbols.toIList(),
      filteredRecentKaomoji: recentKaomoji.toIList(),
    ),
  );

  // Create tab controller (needed for all views)
  final selectedTabDataController = MockSelectedTabDataController(
    initialIndex: selectedTabIndex,
  );

  // Instantiate MockSelectedGlyphDataController as per user's instruction
  final selectedGlyphDataController = MockSelectedGlyphDataController(
    initialState: SelectedGlyphDataState.initial().copyWith(
      selectedGlyph: selectedGlyph,
    ),
  );

  return ScreenshotData(
    view: MultiBlocProvider(
      providers: [
        BlocProvider<GlyphsDataController>.value(
          value: glyphsDataController,
        ),
        BlocProvider<FavoritesDataController>.value(
          value: favoritesDataController,
        ),
        BlocProvider<RecentDataController>.value(
          value: recentDataController,
        ),
        BlocProvider<SearchGlyphsDataController>.value(
          value: searchGlyphsDataController,
        ),
        BlocProvider<SelectedTabDataController>.value(
          value: selectedTabDataController,
        ),
        BlocProvider<SelectedGlyphDataController>.value(
          value: selectedGlyphDataController,
        ),
      ],
      child: AppContentView(
        controller: MockAppContentViewController(),
        state: AppContentViewState.initial(),
      ),
    ),
    fileName: fileName,
  );
}

class ScreenshotData {
  final Widget view;
  final String fileName;

  const ScreenshotData({required this.view, required this.fileName});
}
