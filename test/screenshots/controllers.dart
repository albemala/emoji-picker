import 'package:app/about/view-controller.dart';
import 'package:app/app-content/view-controller.dart';
import 'package:app/favorites/data-controller.dart';
import 'package:app/favorites/data-state.dart';
import 'package:app/glyph-data/data-controller.dart';
import 'package:app/glyph-data/data-state.dart';
import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-details/view-controller.dart';
import 'package:app/glyph-details/view-state.dart';
import 'package:app/preferences/data-controller.dart';
import 'package:app/preferences/data-state.dart';
import 'package:app/recent/data-controller.dart';
import 'package:app/recent/data-state.dart';
import 'package:app/search/data-controller.dart';
import 'package:app/search/data-state.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:app/selected-glyph/data-state.dart';
import 'package:app/selected-tab/data-controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext //
    extends Mock
    implements BuildContext {}

class MockPreferencesDataController //
    extends Mock
    implements PreferencesDataController {
  @override
  Stream<PreferencesDataState> get stream {
    return Stream.value(PreferencesDataState.initial());
  }

  @override
  PreferencesDataState get state {
    return PreferencesDataState.initial();
  }
}

class MockGlyphsDataController //
    extends Mock
    implements GlyphsDataController {
  final GlyphsDataState? initialState;

  MockGlyphsDataController({this.initialState});

  @override
  Stream<GlyphsDataState> get stream {
    return Stream.value(initialState ?? GlyphsDataState.initial());
  }

  @override
  GlyphsDataState get state {
    return initialState ?? GlyphsDataState.initial();
  }
}

class MockSearchGlyphsDataController //
    extends Mock
    implements SearchGlyphsDataController {
  final SearchGlyphsDataState? initialState;

  MockSearchGlyphsDataController({this.initialState});

  @override
  Stream<SearchGlyphsDataState> get stream {
    return Stream.value(initialState ?? SearchGlyphsDataState.initial());
  }

  @override
  SearchGlyphsDataState get state {
    return initialState ?? SearchGlyphsDataState.initial();
  }

  @override
  FocusNode get focusNode => FocusNode();
}

class MockSelectedGlyphDataController //
    extends Mock
    implements SelectedGlyphDataController {
  final SelectedGlyphDataState? initialState;

  MockSelectedGlyphDataController({this.initialState});

  @override
  Stream<SelectedGlyphDataState> get stream {
    return Stream.value(initialState ?? SelectedGlyphDataState.initial());
  }

  @override
  SelectedGlyphDataState get state {
    return initialState ?? SelectedGlyphDataState.initial();
  }

  @override
  Glyph get selectedGlyph => state.selectedGlyph;
}

class MockFavoritesDataController //
    extends Mock
    implements FavoritesDataController {
  final FavoritesDataState? initialState;

  MockFavoritesDataController({this.initialState});

  @override
  Stream<FavoritesDataState> get stream {
    return Stream.value(initialState ?? FavoritesDataState.initial());
  }

  @override
  FavoritesDataState get state {
    return initialState ?? FavoritesDataState.initial();
  }

  @override
  bool isFavorite(Glyph glyph) {
    return state.favoriteGlyphs.contains(glyph.glyph);
  }
}

class MockGlyphDetailsViewController //
    extends Mock
    implements GlyphDetailsViewController {
  final GlyphDetailsViewState? initialState;

  MockGlyphDetailsViewController({this.initialState});

  @override
  Stream<GlyphDetailsViewState> get stream {
    return Stream.value(initialState ?? GlyphDetailsViewState.initial());
  }

  @override
  GlyphDetailsViewState get state {
    return initialState ?? GlyphDetailsViewState.initial();
  }
}

class MockRecentDataController //
    extends Mock
    implements RecentDataController {
  final RecentDataState? initialState;

  MockRecentDataController({this.initialState});

  @override
  Stream<RecentDataState> get stream {
    return Stream.value(initialState ?? RecentDataState.initial());
  }

  @override
  RecentDataState get state {
    return initialState ?? RecentDataState.initial();
  }

  @override
  List<String> getRecentGlyphStrings() {
    return state.recentGlyphs.map((entry) => entry.glyph).toList();
  }
}

class MockSelectedTabDataController //
    extends Mock
    implements SelectedTabDataController, TickerProvider {
  MockSelectedTabDataController({int initialIndex = 0}) {
    _tabController = TabController(
      length: 4, // Assuming 4 tabs as per SelectedTabDataController
      vsync: this,
      initialIndex: initialIndex,
    );
  }

  late final TabController _tabController;

  @override
  TabController get tabController => _tabController;

  @override
  Stream<void> get stream => Stream.value(null);

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }

  @override
  Future<void> close() {
    _tabController.dispose();
    return Future.value();
  }
}

class MockAboutViewController //
    extends Mock
    implements AboutViewController {}

class MockAppContentViewController //
    extends Mock
    implements AppContentViewController {}
