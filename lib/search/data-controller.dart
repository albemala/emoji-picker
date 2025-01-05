import 'dart:async';

import 'package:app/glyphs/data-controller.dart';
import 'package:app/glyphs/defines/glyph.dart';
import 'package:app/search/data-state.dart';
import 'package:app/search/functions.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchGlyphsDataController extends Cubit<SearchGlyphsDataState> {
  final GlyphsDataController _glyphsDataController;
  StreamSubscription<void>? _glyphsDataControllerSubscription;

  final searchFocusNode = FocusNode();
  final searchQueryController = TextEditingController();

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
      _updateState();
    });
    _updateState();

    searchFocusNode.addListener(onSearchFocusChanged);
    searchQueryController.addListener(onSearchChanged);
  }

  @override
  Future<void> close() async {
    await _glyphsDataControllerSubscription?.cancel();
    searchFocusNode
      ..removeListener(onSearchFocusChanged)
      ..dispose();
    searchQueryController
      ..removeListener(onSearchChanged)
      ..dispose();
    await super.close();
  }

  void onSearchFocusChanged() {
    // When the search field gets focused, select the existing text
    if (searchFocusNode.hasFocus) {
      searchQueryController.value = searchQueryController.value.copyWith(
        selection: TextSelection(
          baseOffset: 0,
          extentOffset: searchQueryController.text.length,
        ),
        composing: TextRange.empty,
      );
    }
  }

  void setSearchQuery(String value) {
    searchQueryController.value = TextEditingValue(
      text: value,
      selection: searchQueryController.selection,
    );
  }

  void clearSearch() {
    searchQueryController.clear();
  }

  void onSearchChanged() {
    EasyDebounce.debounce(
      'search-debounce',
      const Duration(milliseconds: 300),
      _updateState,
    );
  }

  void _updateState() {
    final searchQuery = searchQueryController.text;
    final state = _glyphsDataController.state;
    bool test(Glyph glyph) => matchesSearchTerm(glyph, searchQuery);

    final filteredEmoji =
        searchQuery.isEmpty ? state.emoji : state.emoji.where(test);
    final filteredSymbols =
        searchQuery.isEmpty ? state.symbols : state.symbols.where(test);
    final filteredKaomoji =
        searchQuery.isEmpty ? state.kaomoji : state.kaomoji.where(test);

    emit(
      SearchGlyphsDataState(
        filteredEmoji: filteredEmoji.toIList(),
        filteredSymbols: filteredSymbols.toIList(),
        filteredKaomoji: filteredKaomoji.toIList(),
      ),
    );
  }
}
