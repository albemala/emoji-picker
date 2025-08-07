import 'dart:async';

import 'package:app/glyph-data/data-controller.dart';
import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/search/data-state.dart';
import 'package:app/search/functions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchGlyphsDataController extends Cubit<SearchGlyphsDataState> {
  final GlyphsDataController glyphsDataController;
  StreamSubscription<void>? glyphsDataControllerSubscription;

  final focusNode = FocusNode();

  factory SearchGlyphsDataController.fromContext(BuildContext context) {
    return SearchGlyphsDataController(context.read<GlyphsDataController>());
  }

  SearchGlyphsDataController(this.glyphsDataController)
    : super(defaultSearchGlyphsDataState) {
    glyphsDataControllerSubscription = glyphsDataController.stream.listen((_) {
      updateFilteredData();
    });
    updateFilteredData();
  }

  @override
  Future<void> close() {
    glyphsDataControllerSubscription?.cancel();
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

    emit(
      state.copyWith(
        filteredEmoji: filteredEmoji,
        filteredSymbols: filteredSymbols,
        filteredKaomoji: filteredKaomoji,
      ),
    );
  }
}
