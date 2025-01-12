import 'package:app/about/view-controller.dart';
import 'package:app/app-content/view-controller.dart';
import 'package:app/glyph-data/data-controller.dart';
import 'package:app/glyph-data/data-state.dart';
import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/preferences/data-controller.dart';
import 'package:app/preferences/data-state.dart';
import 'package:app/search/data-controller.dart';
import 'package:app/search/data-state.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:app/selected-glyph/data-state.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext //
    extends Mock implements BuildContext {}

class MockPreferencesDataController //
    extends Mock implements PreferencesDataController {
  @override
  Stream<PreferencesDataState> get stream {
    return Stream.value(defaultPreferencesDataState);
  }

  @override
  PreferencesDataState get state {
    return defaultPreferencesDataState;
  }
}

class MockGlyphsDataController //
    extends Mock implements GlyphsDataController {
  final GlyphsDataState? initialState;

  MockGlyphsDataController({this.initialState});

  @override
  Stream<GlyphsDataState> get stream {
    return Stream.value(initialState ?? defaultGlyphsDataState);
  }

  @override
  GlyphsDataState get state {
    return initialState ?? defaultGlyphsDataState;
  }
}

class MockSearchGlyphsDataController //
    extends Mock implements SearchGlyphsDataController {
  final SearchGlyphsDataState? initialState;

  MockSearchGlyphsDataController({this.initialState});

  @override
  Stream<SearchGlyphsDataState> get stream {
    return Stream.value(initialState ?? defaultSearchGlyphsDataState);
  }

  @override
  SearchGlyphsDataState get state {
    return initialState ?? defaultSearchGlyphsDataState;
  }

  @override
  FocusNode get focusNode => FocusNode();
}

class MockSelectedGlyphDataController //
    extends Mock implements SelectedGlyphDataController {
  final SelectedGlyphDataState? initialState;

  MockSelectedGlyphDataController({this.initialState});

  @override
  Stream<SelectedGlyphDataState> get stream {
    return Stream.value(initialState ?? defaultSelectedGlyphDataState);
  }

  @override
  SelectedGlyphDataState get state {
    return initialState ?? defaultSelectedGlyphDataState;
  }

  @override
  Glyph get selectedGlyph => state.selectedGlyph;
}

class MockAboutViewController //
    extends Mock implements AboutViewController {}

class MockAppContentViewController //
    extends Mock implements AppContentViewController {}
