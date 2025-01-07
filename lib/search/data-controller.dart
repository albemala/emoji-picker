import 'dart:async';

import 'package:app/glyph-data/data-controller.dart';
import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/search/data-state.dart';
import 'package:app/search/functions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchGlyphsDataController extends Cubit<SearchGlyphsDataState> {
  final GlyphsDataController _glyphsDataController;
  StreamSubscription<void>? _glyphsDataControllerSubscription;

  final focusNode = FocusNode();

  factory SearchGlyphsDataController.fromContext(BuildContext context) {
    return SearchGlyphsDataController(
      context.read<GlyphsDataController>(),
    );
  }

  SearchGlyphsDataController(
    this._glyphsDataController,
  ) : super(defaultSearchGlyphsDataState) {
    _init();
  }

  void _init() {
    _glyphsDataControllerSubscription =
        _glyphsDataController.stream.listen((_) {
      _updateFilteredData();
    });
    _updateFilteredData();
  }

  @override
  Future<void> close() {
    _glyphsDataControllerSubscription?.cancel();
    return super.close();
  }

  void setSearchQuery(String value) {
    emit(state.copyWith(searchQuery: value));
    _updateFilteredData();
  }

  void _updateFilteredData() {
    bool test(Glyph glyph) => matchesSearchTerm(glyph, state.searchQuery);

    final glyphData = _glyphsDataController.state;
    final filteredEmoji = state.searchQuery.isEmpty
        ? glyphData.emoji
        : glyphData.emoji.where(test);
    final filteredSymbols = state.searchQuery.isEmpty
        ? glyphData.symbols
        : glyphData.symbols.where(test);
    final filteredKaomoji = state.searchQuery.isEmpty
        ? glyphData.kaomoji
        : glyphData.kaomoji.where(test);

    emit(
      state.copyWith(
        filteredEmoji: filteredEmoji.toIList(),
        filteredSymbols: filteredSymbols.toIList(),
        filteredKaomoji: filteredKaomoji.toIList(),
      ),
    );
  }
}
