import 'package:app/about/view-state.dart';
import 'package:app/about/view.dart';
import 'package:app/app-content/view-state.dart';
import 'package:app/app-content/view.dart';
import 'package:app/glyph-data/data-controller.dart';
import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-data/functions.dart';
import 'package:app/preferences/data-controller.dart';
import 'package:app/search/data-controller.dart';
import 'package:app/search/data-state.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:app/selected-glyph/data-state.dart';
import 'package:app/selected-tab/data-controller.dart';
import 'package:app/widgets/ads.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'defines.dart';

Future<List<ScreenshotData>> createScreenshotData() async {
  final emoji = await loadEmoji();
  final symbols = await loadSymbols();
  final kaomoji = await loadKaomoji();
  // final emojiByGroup = groupGlyphsByGroup(emoji);
  // final symbolByGroup = groupGlyphsByGroup(symbols);
  // final kaomojiByGroup = groupGlyphsByGroup(kaomoji);
  return [
    createAboutViewScreenshotData(),
    createContentViewScreenshotData(
      tabIndex: 0,
      filteredEmoji: emoji,
      filteredSymbols: [],
      filteredKaomoji: [],
      fileName: 'emoji_view',
    ),
    createContentViewScreenshotData(
      tabIndex: 1,
      filteredEmoji: [],
      filteredSymbols: symbols,
      filteredKaomoji: [],
      fileName: 'symbols_view',
    ),
    createContentViewScreenshotData(
      tabIndex: 2,
      filteredEmoji: [],
      filteredSymbols: [],
      filteredKaomoji: kaomoji,
      fileName: 'kaomoji_view',
    ),
    createSelectedGlyphScreenshotData(
      tabIndex: 0,
      emoji: emoji,
      symbols: [],
      kaomoji: [],
      fileName: 'selected_emoji',
      selectedGlyph: emoji[2],
    ),
    createSelectedGlyphScreenshotData(
      tabIndex: 1,
      emoji: [],
      symbols: symbols,
      kaomoji: [],
      fileName: 'selected_symbol',
      selectedGlyph: symbols.where((e) => e.glyph == '&').first,
    ),
    createSelectedGlyphScreenshotData(
      tabIndex: 2,
      emoji: [],
      symbols: [],
      kaomoji: kaomoji,
      fileName: 'selected_kaomoji',
      selectedGlyph: kaomoji[0],
    ),
    // for (final entry in emojiByGroup.entries)
    //   createContentViewScreenshotData(
    //     tabIndex: 0,
    //     filteredEmoji: entry.value,
    //     filteredSymbols: [],
    //     filteredKaomoji: [],
    //     fileName: '${filterAlphabetic(entry.key)}_emoji_view',
    //   ),
    // for (final entry in symbolByGroup.entries)
    //   createContentViewScreenshotData(
    //     tabIndex: 1,
    //     filteredEmoji: [],
    //     filteredSymbols: entry.value,
    //     filteredKaomoji: [],
    //     fileName: '${filterAlphabetic(entry.key)}_symbols_view',
    //   ),
    // for (final entry in kaomojiByGroup.entries)
    //   createContentViewScreenshotData(
    //     tabIndex: 2,
    //     filteredEmoji: [],
    //     filteredSymbols: [],
    //     filteredKaomoji: entry.value,
    //     fileName: '${filterAlphabetic(entry.key)}_kaomoji_view',
    //   ),
  ];
}

String filterAlphabetic(String input) {
  final regExp = RegExp('[^a-z]');
  return input.toLowerCase().replaceAll(regExp, '');
}

ScreenshotData createAboutViewScreenshotData() {
  return ScreenshotData(
    view: ScreenshotDialogView(
      child: AboutView(
        controller: MockAboutViewController(),
        state: AboutViewState(
          appVersion: '3.0.0',
          adType: AdType.values.first,
        ),
      ),
    ),
    fileName: 'about_view',
  );
}

ScreenshotData createContentViewScreenshotData({
  required int tabIndex,
  required List<Glyph> filteredEmoji,
  required List<Glyph> filteredSymbols,
  required List<Glyph> filteredKaomoji,
  required String fileName,
}) {
  final selectedTabDataController = SelectedTabDataController();
  selectedTabDataController.tabController.animateTo(
    tabIndex,
    duration: Duration.zero,
  );

  return ScreenshotData(
    view: MultiBlocProvider(
      providers: [
        BlocProvider<PreferencesDataController>.value(
          value: MockPreferencesDataController(),
        ),
        BlocProvider<GlyphsDataController>.value(
          value: MockGlyphsDataController(),
        ),
        BlocProvider<SearchGlyphsDataController>.value(
          value: MockSearchGlyphsDataController(
            initialState: defaultSearchGlyphsDataState.copyWith(
              filteredEmoji: filteredEmoji.toIList(),
              filteredSymbols: filteredSymbols.toIList(),
              filteredKaomoji: filteredKaomoji.toIList(),
            ),
          ),
        ),
        BlocProvider<SelectedGlyphDataController>.value(
          value: MockSelectedGlyphDataController(),
        ),
        BlocProvider<SelectedTabDataController>.value(
          value: selectedTabDataController,
        ),
      ],
      child: AppContentView(
        controller: MockAppContentViewController(),
        state: defaultAppContentViewState,
      ),
    ),
    fileName: fileName,
  );
}

ScreenshotData createSelectedGlyphScreenshotData({
  required int tabIndex,
  required List<Glyph> emoji,
  required List<Glyph> symbols,
  required List<Glyph> kaomoji,
  required String fileName,
  required Glyph selectedGlyph,
}) {
  final selectedTabDataController = SelectedTabDataController();
  selectedTabDataController.tabController.animateTo(
    tabIndex,
    duration: Duration.zero,
  );

  final selectedGlyphController = MockSelectedGlyphDataController(
    initialState: defaultSelectedGlyphDataState.copyWith(
      selectedGlyph: selectedGlyph,
    ),
  );

  return ScreenshotData(
    view: MultiBlocProvider(
      providers: [
        BlocProvider<PreferencesDataController>.value(
          value: MockPreferencesDataController(),
        ),
        BlocProvider<GlyphsDataController>.value(
          value: MockGlyphsDataController(),
        ),
        BlocProvider<SearchGlyphsDataController>.value(
          value: MockSearchGlyphsDataController(
            initialState: defaultSearchGlyphsDataState.copyWith(
              filteredEmoji: emoji.toIList(),
              filteredSymbols: symbols.toIList(),
              filteredKaomoji: kaomoji.toIList(),
            ),
          ),
        ),
        BlocProvider<SelectedGlyphDataController>.value(
          value: selectedGlyphController,
        ),
        BlocProvider<SelectedTabDataController>.value(
          value: selectedTabDataController,
        ),
      ],
      child: AppContentView(
        controller: MockAppContentViewController(),
        state: defaultAppContentViewState,
      ),
    ),
    fileName: fileName,
  );
}

class ScreenshotData {
  final Widget view;
  final String fileName;

  const ScreenshotData({
    required this.view,
    required this.fileName,
  });
}

class ScreenshotDialogView extends StatelessWidget {
  final Widget child;

  const ScreenshotDialogView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: child,
          ),
        ),
      ),
    );
  }
}
